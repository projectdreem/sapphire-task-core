-- ============ TASK MANAGER MODULE ============
CREATE TABLE public.tm_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  role TEXT NOT NULL DEFAULT 'developer',
  department TEXT NOT NULL DEFAULT 'engineering',
  skills TEXT[] NOT NULL DEFAULT '{}',
  capacity_hours NUMERIC(5,2) NOT NULL DEFAULT 40,
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  category TEXT NOT NULL DEFAULT 'development',
  module TEXT,
  client_name TEXT,
  status TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new','assigned','accepted','in_progress','ai_review','waiting_client','testing','blocked','on_hold','completed','cancelled')),
  priority TEXT NOT NULL DEFAULT 'medium' CHECK (priority IN ('low','medium','high','critical')),
  difficulty TEXT NOT NULL DEFAULT 'medium' CHECK (difficulty IN ('easy','medium','hard','expert')),
  created_by UUID REFERENCES public.tm_members(id) ON DELETE SET NULL,
  assigned_to UUID REFERENCES public.tm_members(id) ON DELETE SET NULL,
  estimated_hours NUMERIC(6,2) NOT NULL DEFAULT 4,
  actual_minutes INTEGER NOT NULL DEFAULT 0,
  sla_hours NUMERIC(6,2) NOT NULL DEFAULT 24,
  promised_at TIMESTAMPTZ,
  deadline TIMESTAMPTZ,
  accepted_at TIMESTAMPTZ,
  started_at TIMESTAMPTZ,
  paused_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  total_paused_minutes INTEGER NOT NULL DEFAULT 0,
  timer_running BOOLEAN NOT NULL DEFAULT false,
  progress INTEGER NOT NULL DEFAULT 0 CHECK (progress BETWEEN 0 AND 100),
  billable BOOLEAN NOT NULL DEFAULT true,
  cost NUMERIC(12,2) NOT NULL DEFAULT 0,
  tags TEXT[] NOT NULL DEFAULT '{}',
  blocked_reason TEXT,
  buzzer_active BOOLEAN NOT NULL DEFAULT false,
  buzzer_acknowledged_at TIMESTAMPTZ,
  escalation_level INTEGER NOT NULL DEFAULT 0,
  approval_status TEXT NOT NULL DEFAULT 'not_required' CHECK (approval_status IN ('not_required','pending','approved','rejected','changes_requested')),
  ai_generated BOOLEAN NOT NULL DEFAULT false,
  quality_score INTEGER,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_tm_tasks_status ON public.tm_tasks(status);
CREATE INDEX idx_tm_tasks_assigned ON public.tm_tasks(assigned_to);
CREATE INDEX idx_tm_tasks_deadline ON public.tm_tasks(deadline);

CREATE TABLE public.tm_subtasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  completed BOOLEAN NOT NULL DEFAULT false,
  position INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  author_id UUID REFERENCES public.tm_members(id) ON DELETE SET NULL,
  author_name TEXT NOT NULL,
  author_role TEXT NOT NULL DEFAULT 'developer',
  message TEXT NOT NULL,
  is_system BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_attachments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  file_type TEXT NOT NULL DEFAULT 'document',
  url TEXT NOT NULL DEFAULT '',
  size_kb INTEGER NOT NULL DEFAULT 0,
  uploaded_by TEXT NOT NULL DEFAULT 'system',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_dependencies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  depends_on_task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  dependency_type TEXT NOT NULL DEFAULT 'blocks' CHECK (dependency_type IN ('blocks','relates_to','duplicates','subtask_of')),
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','satisfied','broken')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (task_id, depends_on_task_id)
);

CREATE TABLE public.tm_approvals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  stage TEXT NOT NULL DEFAULT 'manager' CHECK (stage IN ('lead','manager','qa','client','finance')),
  approver_id UUID REFERENCES public.tm_members(id) ON DELETE SET NULL,
  approver_name TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','approved','rejected','changes_requested')),
  remarks TEXT,
  position INTEGER NOT NULL DEFAULT 1,
  decided_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  reviewer_id UUID REFERENCES public.tm_members(id) ON DELETE SET NULL,
  reviewer_name TEXT NOT NULL,
  quality_score INTEGER NOT NULL DEFAULT 0 CHECK (quality_score BETWEEN 0 AND 100),
  timeliness_score INTEGER NOT NULL DEFAULT 0 CHECK (timeliness_score BETWEEN 0 AND 100),
  verdict TEXT NOT NULL DEFAULT 'pending' CHECK (verdict IN ('pending','passed','failed','rework')),
  remarks TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_time_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  member_id UUID REFERENCES public.tm_members(id) ON DELETE SET NULL,
  action TEXT NOT NULL CHECK (action IN ('start','pause','resume','stop','manual')),
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  ended_at TIMESTAMPTZ,
  seconds INTEGER NOT NULL DEFAULT 0,
  note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_escalations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  level INTEGER NOT NULL DEFAULT 1,
  reason TEXT NOT NULL,
  raised_by TEXT NOT NULL DEFAULT 'system',
  raised_to TEXT NOT NULL DEFAULT 'task_manager',
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open','acknowledged','resolved','closed')),
  resolution TEXT,
  resolved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_automations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  trigger_type TEXT NOT NULL CHECK (trigger_type IN ('task_created','status_changed','sla_at_risk','sla_breached','unassigned_timeout','approval_pending','task_completed','daily_digest')),
  condition_json JSONB NOT NULL DEFAULT '{}',
  action_type TEXT NOT NULL CHECK (action_type IN ('assign','notify','escalate','set_priority','add_tag','buzzer','ai_review')),
  action_config JSONB NOT NULL DEFAULT '{}',
  enabled BOOLEAN NOT NULL DEFAULT true,
  run_count INTEGER NOT NULL DEFAULT 0,
  last_run_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  level TEXT NOT NULL DEFAULT 'info' CHECK (level IN ('info','success','warning','critical')),
  channel TEXT NOT NULL DEFAULT 'in_app',
  read BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.tm_activity (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES public.tm_tasks(id) ON DELETE CASCADE,
  actor_name TEXT NOT NULL DEFAULT 'system',
  actor_role TEXT NOT NULL DEFAULT 'task_manager',
  action TEXT NOT NULL,
  action_type TEXT NOT NULL DEFAULT 'update',
  from_value TEXT,
  to_value TEXT,
  details TEXT,
  meta JSONB NOT NULL DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_tm_activity_task ON public.tm_activity(task_id);

CREATE TABLE public.tm_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  singleton BOOLEAN NOT NULL DEFAULT true UNIQUE,
  default_sla_hours NUMERIC(6,2) NOT NULL DEFAULT 24,
  critical_sla_hours NUMERIC(6,2) NOT NULL DEFAULT 4,
  sla_warning_percent INTEGER NOT NULL DEFAULT 75,
  auto_assign BOOLEAN NOT NULL DEFAULT true,
  auto_escalate BOOLEAN NOT NULL DEFAULT true,
  buzzer_enabled BOOLEAN NOT NULL DEFAULT true,
  buzzer_repeat_minutes INTEGER NOT NULL DEFAULT 10,
  require_approval BOOLEAN NOT NULL DEFAULT true,
  ai_review_enabled BOOLEAN NOT NULL DEFAULT true,
  working_hours_start TEXT NOT NULL DEFAULT '09:30',
  working_hours_end TEXT NOT NULL DEFAULT '19:00',
  timezone TEXT NOT NULL DEFAULT 'Asia/Kolkata',
  escalation_matrix JSONB NOT NULL DEFAULT '[]',
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- updated_at trigger
CREATE OR REPLACE FUNCTION public.tm_touch_updated_at() RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END; $$ LANGUAGE plpgsql SET search_path = public;

CREATE TRIGGER tm_tasks_touch BEFORE UPDATE ON public.tm_tasks FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
CREATE TRIGGER tm_members_touch BEFORE UPDATE ON public.tm_members FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
CREATE TRIGGER tm_automations_touch BEFORE UPDATE ON public.tm_automations FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();

-- ============ GRANTS ============
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_members TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_tasks TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_subtasks TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_comments TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_attachments TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_dependencies TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_approvals TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_reviews TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_time_logs TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_escalations TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_automations TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tm_notifications TO anon, authenticated;
GRANT SELECT, INSERT ON public.tm_activity TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE ON public.tm_settings TO anon, authenticated;
GRANT ALL ON public.tm_members, public.tm_tasks, public.tm_subtasks, public.tm_comments,
  public.tm_attachments, public.tm_dependencies, public.tm_approvals, public.tm_reviews,
  public.tm_time_logs, public.tm_escalations, public.tm_automations, public.tm_notifications,
  public.tm_activity, public.tm_settings TO service_role;

-- ============ RLS ============
ALTER TABLE public.tm_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_subtasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_attachments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_dependencies ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_approvals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_time_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_escalations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_automations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_activity ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tm_settings ENABLE ROW LEVEL SECURITY;

-- Module has no login screen by product requirement: operational access is open,
-- audit trail is append-only.
CREATE POLICY "tm_members_all" ON public.tm_members FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_tasks_all" ON public.tm_tasks FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_subtasks_all" ON public.tm_subtasks FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_comments_all" ON public.tm_comments FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_attachments_all" ON public.tm_attachments FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_dependencies_all" ON public.tm_dependencies FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_approvals_all" ON public.tm_approvals FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_reviews_all" ON public.tm_reviews FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_time_logs_all" ON public.tm_time_logs FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_escalations_all" ON public.tm_escalations FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_automations_all" ON public.tm_automations FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_notifications_all" ON public.tm_notifications FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "tm_activity_read" ON public.tm_activity FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "tm_activity_append" ON public.tm_activity FOR INSERT TO anon, authenticated WITH CHECK (true);
CREATE POLICY "tm_settings_read" ON public.tm_settings FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "tm_settings_write" ON public.tm_settings FOR INSERT TO anon, authenticated WITH CHECK (true);
CREATE POLICY "tm_settings_update" ON public.tm_settings FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);

-- realtime
ALTER PUBLICATION supabase_realtime ADD TABLE public.tm_tasks;
ALTER PUBLICATION supabase_realtime ADD TABLE public.tm_comments;
ALTER PUBLICATION supabase_realtime ADD TABLE public.tm_notifications;
ALTER PUBLICATION supabase_realtime ADD TABLE public.tm_escalations;
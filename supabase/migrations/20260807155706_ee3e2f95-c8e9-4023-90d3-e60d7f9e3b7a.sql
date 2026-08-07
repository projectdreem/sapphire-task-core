-- DB-002: GIN indexes for array / JSONB / text search
CREATE INDEX IF NOT EXISTS idx_tm_tasks_tags_gin ON public.tm_tasks USING gin (tags);
CREATE INDEX IF NOT EXISTS idx_tm_tasks_search_gin ON public.tm_tasks USING gin (to_tsvector('english', coalesce(title,'') || ' ' || coalesce(description,'')));
CREATE INDEX IF NOT EXISTS idx_tm_automations_condition_gin ON public.tm_automations USING gin (condition_json);
CREATE INDEX IF NOT EXISTS idx_tm_automations_action_gin ON public.tm_automations USING gin (action_config);
CREATE INDEX IF NOT EXISTS idx_tm_activity_meta_gin ON public.tm_activity USING gin (meta);
CREATE INDEX IF NOT EXISTS idx_tm_settings_escalation_gin ON public.tm_settings USING gin (escalation_matrix);

-- DB-003: index FK created_by (and other frequently joined FKs)
CREATE INDEX IF NOT EXISTS idx_tm_tasks_created_by ON public.tm_tasks (created_by);
CREATE INDEX IF NOT EXISTS idx_tm_approvals_task ON public.tm_approvals (task_id);
CREATE INDEX IF NOT EXISTS idx_tm_reviews_task ON public.tm_reviews (task_id);
CREATE INDEX IF NOT EXISTS idx_tm_time_logs_task ON public.tm_time_logs (task_id);
CREATE INDEX IF NOT EXISTS idx_tm_escalations_task ON public.tm_escalations (task_id);
CREATE INDEX IF NOT EXISTS idx_tm_comments_task ON public.tm_comments (task_id);
CREATE INDEX IF NOT EXISTS idx_tm_subtasks_task ON public.tm_subtasks (task_id);
CREATE INDEX IF NOT EXISTS idx_tm_attachments_task ON public.tm_attachments (task_id);
CREATE INDEX IF NOT EXISTS idx_tm_dependencies_task ON public.tm_dependencies (task_id);
CREATE INDEX IF NOT EXISTS idx_tm_dependencies_depends_on ON public.tm_dependencies (depends_on_task_id);

-- DB-005: link activity rows to a member for reliable audit joins
ALTER TABLE public.tm_activity
  ADD COLUMN IF NOT EXISTS actor_id uuid REFERENCES public.tm_members(id) ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS idx_tm_activity_actor ON public.tm_activity (actor_id);

-- DB-004: consistent updated_at maintenance
ALTER TABLE public.tm_subtasks ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_comments ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_attachments ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_approvals ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_reviews ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_escalations ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_dependencies ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_notifications ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_time_logs ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
ALTER TABLE public.tm_activity ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();

DROP TRIGGER IF EXISTS tm_subtasks_touch ON public.tm_subtasks;
CREATE TRIGGER tm_subtasks_touch BEFORE UPDATE ON public.tm_subtasks FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_comments_touch ON public.tm_comments;
CREATE TRIGGER tm_comments_touch BEFORE UPDATE ON public.tm_comments FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_attachments_touch ON public.tm_attachments;
CREATE TRIGGER tm_attachments_touch BEFORE UPDATE ON public.tm_attachments FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_approvals_touch ON public.tm_approvals;
CREATE TRIGGER tm_approvals_touch BEFORE UPDATE ON public.tm_approvals FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_reviews_touch ON public.tm_reviews;
CREATE TRIGGER tm_reviews_touch BEFORE UPDATE ON public.tm_reviews FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_escalations_touch ON public.tm_escalations;
CREATE TRIGGER tm_escalations_touch BEFORE UPDATE ON public.tm_escalations FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_dependencies_touch ON public.tm_dependencies;
CREATE TRIGGER tm_dependencies_touch BEFORE UPDATE ON public.tm_dependencies FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_notifications_touch ON public.tm_notifications;
CREATE TRIGGER tm_notifications_touch BEFORE UPDATE ON public.tm_notifications FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_time_logs_touch ON public.tm_time_logs;
CREATE TRIGGER tm_time_logs_touch BEFORE UPDATE ON public.tm_time_logs FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_activity_touch ON public.tm_activity;
CREATE TRIGGER tm_activity_touch BEFORE UPDATE ON public.tm_activity FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
DROP TRIGGER IF EXISTS tm_settings_touch ON public.tm_settings;
CREATE TRIGGER tm_settings_touch BEFORE UPDATE ON public.tm_settings FOR EACH ROW EXECUTE FUNCTION public.tm_touch_updated_at();
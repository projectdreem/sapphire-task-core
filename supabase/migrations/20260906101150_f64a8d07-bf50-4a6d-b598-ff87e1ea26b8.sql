-- Task Manager integrity and access hardening

REVOKE DELETE ON public.tm_members, public.tm_tasks, public.tm_subtasks, public.tm_comments,
  public.tm_attachments, public.tm_approvals, public.tm_reviews, public.tm_time_logs,
  public.tm_escalations, public.tm_automations, public.tm_notifications, public.tm_settings
  FROM anon, authenticated;

ALTER TABLE public.tm_tasks
  DROP CONSTRAINT IF EXISTS tm_tasks_quality_score_range;
ALTER TABLE public.tm_tasks
  ADD CONSTRAINT tm_tasks_quality_score_range
  CHECK (quality_score IS NULL OR quality_score BETWEEN 0 AND 100);

ALTER TABLE public.tm_dependencies
  DROP CONSTRAINT IF EXISTS tm_dependencies_no_self;
ALTER TABLE public.tm_dependencies
  ADD CONSTRAINT tm_dependencies_no_self
  CHECK (task_id <> depends_on_task_id);

CREATE UNIQUE INDEX IF NOT EXISTS idx_tm_approvals_pending_stage
  ON public.tm_approvals (task_id, stage)
  WHERE status = 'pending';

DROP POLICY IF EXISTS "tm_attachments_read" ON storage.objects;
DROP POLICY IF EXISTS "tm_attachments_insert" ON storage.objects;
DROP POLICY IF EXISTS "tm_attachments_update" ON storage.objects;
DROP POLICY IF EXISTS "tm_attachments_delete" ON storage.objects;

CREATE POLICY "tm_attachments_read"
  ON storage.objects FOR SELECT TO anon, authenticated
  USING (
    bucket_id = 'tm-attachments'
    AND split_part(name, '/', 1) ~ '^[0-9a-fA-F-]{36}$'
    AND EXISTS (
      SELECT 1 FROM public.tm_tasks
      WHERE id::text = split_part(storage.objects.name, '/', 1)
    )
  );

CREATE POLICY "tm_attachments_insert"
  ON storage.objects FOR INSERT TO anon, authenticated
  WITH CHECK (
    bucket_id = 'tm-attachments'
    AND split_part(name, '/', 1) ~ '^[0-9a-fA-F-]{36}$'
    AND EXISTS (
      SELECT 1 FROM public.tm_tasks
      WHERE id::text = split_part(storage.objects.name, '/', 1)
    )
  );

CREATE POLICY "tm_attachments_update"
  ON storage.objects FOR UPDATE TO anon, authenticated
  USING (
    bucket_id = 'tm-attachments'
    AND split_part(name, '/', 1) ~ '^[0-9a-fA-F-]{36}$'
    AND EXISTS (
      SELECT 1 FROM public.tm_tasks
      WHERE id::text = split_part(storage.objects.name, '/', 1)
    )
  )
  WITH CHECK (
    bucket_id = 'tm-attachments'
    AND split_part(name, '/', 1) ~ '^[0-9a-fA-F-]{36}$'
    AND EXISTS (
      SELECT 1 FROM public.tm_tasks
      WHERE id::text = split_part(storage.objects.name, '/', 1)
    )
  );

CREATE POLICY "tm_attachments_delete"
  ON storage.objects FOR DELETE TO anon, authenticated
  USING (
    bucket_id = 'tm-attachments'
    AND split_part(name, '/', 1) ~ '^[0-9a-fA-F-]{36}$'
    AND EXISTS (
      SELECT 1 FROM public.tm_tasks
      WHERE id::text = split_part(storage.objects.name, '/', 1)
    )
  );
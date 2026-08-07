CREATE POLICY "tm_attachments_read" ON storage.objects FOR SELECT TO anon, authenticated USING (bucket_id = 'tm-attachments');
CREATE POLICY "tm_attachments_insert" ON storage.objects FOR INSERT TO anon, authenticated WITH CHECK (bucket_id = 'tm-attachments');
CREATE POLICY "tm_attachments_update" ON storage.objects FOR UPDATE TO anon, authenticated USING (bucket_id = 'tm-attachments') WITH CHECK (bucket_id = 'tm-attachments');
CREATE POLICY "tm_attachments_delete" ON storage.objects FOR DELETE TO anon, authenticated USING (bucket_id = 'tm-attachments');
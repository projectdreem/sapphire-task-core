-- MEMBERS
INSERT INTO public.tm_members (id, full_name, email, role, department, skills, capacity_hours) VALUES
('a0000000-0000-4000-8000-000000000001','Rohan Mehta','rohan.mehta@softwarevala.com','task_manager','operations','{"planning","sla","escalation"}',45),
('a0000000-0000-4000-8000-000000000002','Priya Nair','priya.nair@softwarevala.com','tech_lead','engineering','{"react","node","architecture"}',40),
('a0000000-0000-4000-8000-000000000003','Arjun Desai','arjun.desai@softwarevala.com','developer','engineering','{"react","typescript","tailwind"}',40),
('a0000000-0000-4000-8000-000000000004','Sneha Kulkarni','sneha.kulkarni@softwarevala.com','developer','engineering','{"postgres","node","api"}',40),
('a0000000-0000-4000-8000-000000000005','Imran Shaikh','imran.shaikh@softwarevala.com','developer','engineering','{"flutter","android","kotlin"}',40),
('a0000000-0000-4000-8000-000000000006','Neha Verma','neha.verma@softwarevala.com','qa_engineer','quality','{"automation","cypress","manual"}',38),
('a0000000-0000-4000-8000-000000000007','Karan Patel','karan.patel@softwarevala.com','devops','infrastructure','{"docker","ci_cd","aws"}',40),
('a0000000-0000-4000-8000-000000000008','Ananya Rao','ananya.rao@softwarevala.com','designer','design','{"figma","ux","design_system"}',36),
('a0000000-0000-4000-8000-000000000009','Vikram Singh','vikram.singh@softwarevala.com','delivery_manager','delivery','{"client_comms","scope","billing"}',42),
('a0000000-0000-4000-8000-00000000000a','Divya Menon','divya.menon@softwarevala.com','support_engineer','support','{"triage","l2_support","sql"}',40);

-- TASKS
INSERT INTO public.tm_tasks (id, code, title, description, category, module, client_name, status, priority, difficulty, created_by, assigned_to, estimated_hours, actual_minutes, sla_hours, promised_at, deadline, accepted_at, started_at, completed_at, timer_running, progress, billable, cost, tags, blocked_reason, buzzer_active, escalation_level, approval_status, ai_generated, quality_score, created_at) VALUES
('b0000000-0000-4000-8000-000000000001','TSK-1001','POS billing module — GST slab rework','Rework the GST slab calculation in the POS billing engine to support the revised 5/12/18/28 slabs with per-line-item overrides and rounding rules.','development','POS','Shree Retail Mart','in_progress','high','hard','a0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000003',12,395,24,now()+interval '6 hours',now()+interval '8 hours',now()-interval '9 hours',now()-interval '8 hours',NULL,true,62,true,18000,'{"pos","billing","gst"}',NULL,false,0,'pending',false,NULL,now()-interval '1 day'),
('b0000000-0000-4000-8000-000000000002','TSK-1002','Hospital dashboard — OPD queue crash on refresh','Critical production defect: OPD queue widget throws on refresh when a token is cancelled mid-session. Reproduced on 3 branches.','bugfix','Hospital ERP','Sanjeevani Hospitals','in_progress','critical','hard','a0000000-0000-4000-8000-00000000000a','a0000000-0000-4000-8000-000000000002',4,168,4,now()+interval '1 hour',now()+interval '1 hour',now()-interval '3 hours',now()-interval '3 hours',NULL,true,70,true,9500,'{"hospital","production","p1"}',NULL,true,2,'pending',false,NULL,now()-interval '4 hours'),
('b0000000-0000-4000-8000-000000000003','TSK-1003','School ERP — fee receipt PDF API integration','Integrate the new receipt service API into the fee module, including retry handling and signed URL storage.','integration','School ERP','Vidya Public School','assigned','medium','medium','a0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000004',10,0,48,now()+interval '2 days',now()+interval '2 days',NULL,NULL,NULL,false,0,true,14000,'{"school","api","pdf"}',NULL,false,0,'not_required',false,NULL,now()-interval '6 hours'),
('b0000000-0000-4000-8000-000000000004','TSK-1004','Logistics app — driver location batching','Reduce battery drain by batching driver GPS pings every 45s with offline queueing.','development','Logistics','TransGo Movers','new','medium','medium','a0000000-0000-4000-8000-000000000009',NULL,8,0,48,now()+interval '3 days',now()+interval '3 days',NULL,NULL,NULL,false,0,true,11000,'{"mobile","gps","battery"}',NULL,false,0,'not_required',false,NULL,now()-interval '2 hours'),
('b0000000-0000-4000-8000-000000000005','TSK-1005','E-commerce — Razorpay webhook signature verification','Harden the payment webhook: verify signature, make handler idempotent, log every event.','security','Payments','Kanha Crafts','testing','high','medium','a0000000-0000-4000-8000-000000000002','a0000000-0000-4000-8000-000000000004',6,352,24,now()+interval '10 hours',now()+interval '12 hours',now()-interval '2 days',now()-interval '2 days',NULL,false,85,true,9000,'{"payments","webhook","security"}',NULL,false,0,'pending',false,NULL,now()-interval '3 days'),
('b0000000-0000-4000-8000-000000000006','TSK-1006','Design system — dark surface token audit','Audit all dashboard surfaces against the unified token set and remove hardcoded colours.','design','Design System','Internal','in_progress','medium','easy','a0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000008',6,140,72,now()+interval '2 days',now()+interval '2 days',now()-interval '1 day',now()-interval '1 day',NULL,false,40,false,0,'{"design","tokens"}',NULL,false,0,'not_required',false,NULL,now()-interval '2 days'),
('b0000000-0000-4000-8000-000000000007','TSK-1007','CI pipeline — flaky Cypress suite on staging','Stabilise the checkout e2e suite; currently fails ~1 in 4 runs on staging.','devops','Infrastructure','Internal','blocked','high','hard','a0000000-0000-4000-8000-000000000006','a0000000-0000-4000-8000-000000000007',8,215,48,now()+interval '1 day',now()+interval '1 day',now()-interval '2 days',now()-interval '2 days',NULL,false,45,false,0,'{"ci","testing","flaky"}','Waiting on staging DB snapshot refresh from infrastructure vendor',false,1,'not_required',false,NULL,now()-interval '4 days'),
('b0000000-0000-4000-8000-000000000008','TSK-1008','POS — offline sync conflict resolution','Implement last-write-wins with conflict journal for offline POS terminals.','development','POS','Shree Retail Mart','waiting_client','high','expert','a0000000-0000-4000-8000-000000000002','a0000000-0000-4000-8000-000000000003',16,540,72,now()+interval '4 days',now()+interval '4 days',now()-interval '5 days',now()-interval '5 days',NULL,false,55,true,26000,'{"pos","offline","sync"}',NULL,false,0,'not_required',false,NULL,now()-interval '6 days'),
('b0000000-0000-4000-8000-000000000009','TSK-1009','Hospital ERP — pharmacy stock reorder report','Nightly reorder report with min/max thresholds per branch, emailed to pharmacy leads.','development','Hospital ERP','Sanjeevani Hospitals','ai_review','medium','medium','a0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000004',9,498,48,now()+interval '18 hours',now()+interval '20 hours',now()-interval '3 days',now()-interval '3 days',NULL,false,90,true,13500,'{"hospital","reports"}',NULL,false,0,'pending',false,NULL,now()-interval '4 days'),
('b0000000-0000-4000-8000-00000000000a','TSK-1010','School ERP — attendance biometric device driver','Driver for the ZKTeco device family with heartbeat and duplicate punch suppression.','integration','School ERP','Vidya Public School','in_progress','high','expert','a0000000-0000-4000-8000-000000000002','a0000000-0000-4000-8000-000000000005',20,760,96,now()+interval '2 days',now()+interval '2 days',now()-interval '6 days',now()-interval '6 days',NULL,true,58,true,30000,'{"school","hardware","biometric"}',NULL,false,0,'not_required',false,NULL,now()-interval '7 days'),
('b0000000-0000-4000-8000-00000000000b','TSK-1011','Overdue: Vendor portal — invoice ageing buckets','Ageing buckets 0-30/31-60/61-90/90+ with drill-down and CSV export.','development','Vendor Portal','TransGo Movers','in_progress','high','medium','a0000000-0000-4000-8000-000000000009','a0000000-0000-4000-8000-000000000003',10,690,48,now()-interval '14 hours',now()-interval '12 hours',now()-interval '4 days',now()-interval '4 days',NULL,false,72,true,15000,'{"finance","reports","overdue"}',NULL,true,2,'not_required',false,NULL,now()-interval '5 days'),
('b0000000-0000-4000-8000-00000000000c','TSK-1012','Overdue: Support — bulk ticket merge tool','Allow L2 agents to merge duplicate tickets with full history preservation.','development','Support Desk','Internal','in_progress','medium','medium','a0000000-0000-4000-8000-00000000000a','a0000000-0000-4000-8000-00000000000a',7,430,48,now()-interval '2 days',now()-interval '2 days',now()-interval '5 days',now()-interval '5 days',NULL,false,60,false,0,'{"support","tooling","overdue"}',NULL,true,3,'not_required',false,NULL,now()-interval '6 days'),
('b0000000-0000-4000-8000-00000000000d','TSK-1013','Kanha Crafts — product image CDN migration','Move 42k product images to CDN with on-the-fly resizing and cache warm-up.','devops','E-commerce','Kanha Crafts','completed','medium','medium','a0000000-0000-4000-8000-000000000002','a0000000-0000-4000-8000-000000000007',12,705,72,now()-interval '3 days',now()-interval '3 days',now()-interval '8 days',now()-interval '8 days',now()-interval '3 days',false,100,true,17000,'{"cdn","performance"}',NULL,false,0,'approved',false,92,now()-interval '9 days'),
('b0000000-0000-4000-8000-00000000000e','TSK-1014','POS — thermal printer ESC/POS template pack','Six receipt templates with logo, GSTIN block and QR for UPI.','development','POS','Shree Retail Mart','completed','low','easy','a0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000005',5,290,72,now()-interval '5 days',now()-interval '5 days',now()-interval '9 days',now()-interval '9 days',now()-interval '5 days',false,100,true,7000,'{"pos","printing"}',NULL,false,0,'approved',false,88,now()-interval '10 days'),
('b0000000-0000-4000-8000-00000000000f','TSK-1015','Hospital ERP — ABDM consent flow','Implement ABDM health-ID consent capture and audit persistence.','compliance','Hospital ERP','Sanjeevani Hospitals','completed','critical','expert','a0000000-0000-4000-8000-000000000009','a0000000-0000-4000-8000-000000000002',18,1120,96,now()-interval '6 days',now()-interval '6 days',now()-interval '14 days',now()-interval '14 days',now()-interval '6 days',false,100,true,34000,'{"compliance","abdm","health"}',NULL,false,0,'approved',false,95,now()-interval '15 days'),
('b0000000-0000-4000-8000-000000000010','TSK-1016','QA — regression pack for release 4.7','Author and execute the regression pack covering POS, billing and reports.','qa','Quality','Internal','testing','high','medium','a0000000-0000-4000-8000-000000000006','a0000000-0000-4000-8000-000000000006',10,480,48,now()+interval '1 day',now()+interval '1 day',now()-interval '2 days',now()-interval '2 days',NULL,true,75,false,0,'{"qa","regression","release"}',NULL,false,0,'not_required',false,NULL,now()-interval '3 days'),
('b0000000-0000-4000-8000-000000000011','TSK-1017','Reseller portal — commission slab engine','Configurable slab engine with retrospective recalculation.','development','Reseller','Internal','new','medium','hard','a0000000-0000-4000-8000-000000000009',NULL,14,0,72,now()+interval '5 days',now()+interval '5 days',NULL,NULL,NULL,false,0,true,21000,'{"reseller","finance"}',NULL,false,0,'not_required',false,NULL,now()-interval '5 hours'),
('b0000000-0000-4000-8000-000000000012','TSK-1018','AI: Auto-summarise weekly client status mails','Generate a weekly per-client delivery digest from task activity and send to delivery managers.','automation','Delivery','Internal','new','low','medium','a0000000-0000-4000-8000-000000000001',NULL,6,0,120,now()+interval '6 days',now()+interval '6 days',NULL,NULL,NULL,false,0,false,0,'{"ai","reporting"}',NULL,false,0,'not_required',true,NULL,now()-interval '1 hour'),
('b0000000-0000-4000-8000-000000000013','TSK-1019','AI: Detect duplicate support tickets before creation','Embed-and-compare incoming ticket text against the last 90 days of tickets.','automation','Support Desk','Internal','assigned','medium','hard','a0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-00000000000a',12,0,96,now()+interval '4 days',now()+interval '4 days',NULL,NULL,NULL,false,0,false,0,'{"ai","support","dedupe"}',NULL,false,0,'not_required',true,NULL,now()-interval '20 hours'),
('b0000000-0000-4000-8000-000000000014','TSK-1020','Logistics — POD photo compression pipeline','Client-side compression + server thumbnails for proof-of-delivery photos.','development','Logistics','TransGo Movers','on_hold','low','easy','a0000000-0000-4000-8000-000000000009','a0000000-0000-4000-8000-000000000005',5,60,120,now()+interval '8 days',now()+interval '8 days',now()-interval '3 days',now()-interval '3 days',NULL,false,15,true,7500,'{"mobile","images"}',NULL,false,0,'not_required',false,NULL,now()-interval '4 days'),
('b0000000-0000-4000-8000-000000000015','TSK-1021','Security — dependency CVE sweep across repos','Patch all high/critical CVEs reported in the monthly sweep.','security','Infrastructure','Internal','in_progress','critical','medium','a0000000-0000-4000-8000-000000000007','a0000000-0000-4000-8000-000000000007',8,205,12,now()+interval '3 hours',now()+interval '4 hours',now()-interval '4 hours',now()-interval '4 hours',NULL,true,35,false,0,'{"security","cve"}',NULL,true,1,'not_required',false,NULL,now()-interval '8 hours'),
('b0000000-0000-4000-8000-000000000016','TSK-1022','E-commerce — abandoned cart recovery mails','Three-step recovery sequence with coupon injection and unsubscribe handling.','development','E-commerce','Kanha Crafts','accepted','medium','medium','a0000000-0000-4000-8000-000000000009','a0000000-0000-4000-8000-000000000003',9,0,72,now()+interval '3 days',now()+interval '3 days',now()-interval '2 hours',NULL,NULL,false,0,true,13000,'{"marketing","email"}',NULL,false,0,'not_required',false,NULL,now()-interval '1 day'),
('b0000000-0000-4000-8000-000000000017','TSK-1023','Hospital ERP — lab result upload validation','Reject malformed LIS payloads with actionable errors instead of silent drops.','bugfix','Hospital ERP','Sanjeevani Hospitals','ai_review','high','medium','a0000000-0000-4000-8000-00000000000a','a0000000-0000-4000-8000-000000000004',6,320,24,now()+interval '9 hours',now()+interval '10 hours',now()-interval '1 day',now()-interval '1 day',NULL,false,88,true,9000,'{"hospital","validation"}',NULL,false,0,'pending',false,NULL,now()-interval '2 days'),
('b0000000-0000-4000-8000-000000000018','TSK-1024','School ERP — parent app push notification revamp','Segment-aware push with quiet hours and delivery receipts.','development','School ERP','Vidya Public School','cancelled','low','medium','a0000000-0000-4000-8000-000000000009','a0000000-0000-4000-8000-000000000005',10,45,96,now()+interval '7 days',now()+interval '7 days',now()-interval '6 days',NULL,NULL,false,5,true,0,'{"mobile","push"}',NULL,false,0,'not_required',false,NULL,now()-interval '7 days');

-- SUBTASKS
INSERT INTO public.tm_subtasks (task_id, title, completed, position) VALUES
('b0000000-0000-4000-8000-000000000001','Map revised slab matrix with finance',true,1),
('b0000000-0000-4000-8000-000000000001','Refactor line-item tax resolver',true,2),
('b0000000-0000-4000-8000-000000000001','Per-item override UI in billing screen',false,3),
('b0000000-0000-4000-8000-000000000001','Rounding + paise adjustment unit tests',false,4),
('b0000000-0000-4000-8000-000000000002','Reproduce cancellation race on staging',true,1),
('b0000000-0000-4000-8000-000000000002','Guard queue reducer against null token',true,2),
('b0000000-0000-4000-8000-000000000002','Hotfix branch + branch-wise rollout',false,3),
('b0000000-0000-4000-8000-000000000005','Verify HMAC signature on raw body',true,1),
('b0000000-0000-4000-8000-000000000005','Idempotency key table + replay guard',true,2),
('b0000000-0000-4000-8000-000000000005','Structured event logging',false,3),
('b0000000-0000-4000-8000-00000000000a','Device handshake + heartbeat',true,1),
('b0000000-0000-4000-8000-00000000000a','Duplicate punch suppression window',false,2),
('b0000000-0000-4000-8000-00000000000a','Branch-wise device registry screen',false,3),
('b0000000-0000-4000-8000-000000000010','Author POS regression cases',true,1),
('b0000000-0000-4000-8000-000000000010','Execute billing + reports suites',false,2);

-- COMMENTS
INSERT INTO public.tm_comments (task_id, author_id, author_name, author_role, message, is_system, created_at) VALUES
('b0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000001','Rohan Mehta','task_manager','Slab matrix signed off by finance this morning — please use v3 of the sheet, not v2.',false,now()-interval '9 hours'),
('b0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000003','Arjun Desai','developer','Resolver refactor is in. Override UI next, expect it by end of shift.',false,now()-interval '3 hours'),
('b0000000-0000-4000-8000-000000000001',NULL,'System','system','Timer started. Promised delivery in 6 hours.',true,now()-interval '8 hours'),
('b0000000-0000-4000-8000-000000000002','a0000000-0000-4000-8000-00000000000a','Divya Menon','support_engineer','Third branch reported the same crash at 11:20. Escalating to P1.',false,now()-interval '3 hours'),
('b0000000-0000-4000-8000-000000000002','a0000000-0000-4000-8000-000000000002','Priya Nair','tech_lead','Root cause found: reducer assumes token object exists after cancel event. Patch in review.',false,now()-interval '1 hour'),
('b0000000-0000-4000-8000-000000000007','a0000000-0000-4000-8000-000000000007','Karan Patel','devops','Blocked — vendor has not refreshed the staging snapshot. Chasing on the shared channel.',false,now()-interval '1 day'),
('b0000000-0000-4000-8000-000000000009','a0000000-0000-4000-8000-000000000004','Sneha Kulkarni','developer','Report generation done, awaiting AI review before handing to QA.',false,now()-interval '5 hours'),
('b0000000-0000-4000-8000-00000000000b','a0000000-0000-4000-8000-000000000009','Vikram Singh','delivery_manager','This is past the promised window. Client asked for a revised ETA today.',false,now()-interval '10 hours'),
('b0000000-0000-4000-8000-000000000015','a0000000-0000-4000-8000-000000000007','Karan Patel','devops','Two critical CVEs patched, four remaining across the mobile repos.',false,now()-interval '2 hours');

-- ATTACHMENTS
INSERT INTO public.tm_attachments (task_id, name, file_type, url, size_kb, uploaded_by) VALUES
('b0000000-0000-4000-8000-000000000001','gst-slab-matrix-v3.xlsx','spreadsheet','',248,'Rohan Mehta'),
('b0000000-0000-4000-8000-000000000002','opd-queue-crash-trace.log','log','',96,'Divya Menon'),
('b0000000-0000-4000-8000-000000000003','receipt-service-openapi.yaml','spec','',54,'Sneha Kulkarni'),
('b0000000-0000-4000-8000-00000000000f','abdm-consent-audit-report.pdf','document','',1320,'Priya Nair'),
('b0000000-0000-4000-8000-00000000000d','cdn-migration-runbook.md','document','',31,'Karan Patel');

-- DEPENDENCIES
INSERT INTO public.tm_dependencies (task_id, depends_on_task_id, dependency_type, status) VALUES
('b0000000-0000-4000-8000-000000000001','b0000000-0000-4000-8000-00000000000e','relates_to','satisfied'),
('b0000000-0000-4000-8000-000000000008','b0000000-0000-4000-8000-000000000001','blocks','pending'),
('b0000000-0000-4000-8000-000000000010','b0000000-0000-4000-8000-000000000005','blocks','pending'),
('b0000000-0000-4000-8000-000000000007','b0000000-0000-4000-8000-00000000000d','relates_to','satisfied'),
('b0000000-0000-4000-8000-000000000009','b0000000-0000-4000-8000-000000000017','relates_to','pending'),
('b0000000-0000-4000-8000-000000000016','b0000000-0000-4000-8000-000000000005','blocks','pending');

-- APPROVALS
INSERT INTO public.tm_approvals (task_id, stage, approver_id, approver_name, status, remarks, position, decided_at) VALUES
('b0000000-0000-4000-8000-000000000001','lead','a0000000-0000-4000-8000-000000000002','Priya Nair','approved','Approach approved, keep rounding centralised.',1,now()-interval '7 hours'),
('b0000000-0000-4000-8000-000000000001','manager','a0000000-0000-4000-8000-000000000001','Rohan Mehta','pending',NULL,2,NULL),
('b0000000-0000-4000-8000-000000000002','lead','a0000000-0000-4000-8000-000000000002','Priya Nair','pending',NULL,1,NULL),
('b0000000-0000-4000-8000-000000000005','qa','a0000000-0000-4000-8000-000000000006','Neha Verma','pending',NULL,1,NULL),
('b0000000-0000-4000-8000-000000000009','manager','a0000000-0000-4000-8000-000000000001','Rohan Mehta','pending',NULL,1,NULL),
('b0000000-0000-4000-8000-000000000017','lead','a0000000-0000-4000-8000-000000000002','Priya Nair','changes_requested','Add payload sample to the error response.',1,now()-interval '4 hours'),
('b0000000-0000-4000-8000-00000000000d','manager','a0000000-0000-4000-8000-000000000001','Rohan Mehta','approved','Clean migration, zero downtime.',1,now()-interval '3 days'),
('b0000000-0000-4000-8000-00000000000f','client','a0000000-0000-4000-8000-000000000009','Vikram Singh','approved','Client signed the compliance acceptance note.',2,now()-interval '6 days'),
('b0000000-0000-4000-8000-00000000000e','manager','a0000000-0000-4000-8000-000000000001','Rohan Mehta','approved','Templates verified on two printer models.',1,now()-interval '5 days');

-- REVIEWS
INSERT INTO public.tm_reviews (task_id, reviewer_id, reviewer_name, quality_score, timeliness_score, verdict, remarks, created_at) VALUES
('b0000000-0000-4000-8000-00000000000d','a0000000-0000-4000-8000-000000000006','Neha Verma',92,95,'passed','No regressions found, cache hit ratio above target.',now()-interval '3 days'),
('b0000000-0000-4000-8000-00000000000e','a0000000-0000-4000-8000-000000000006','Neha Verma',88,90,'passed','Minor alignment fix applied during review.',now()-interval '5 days'),
('b0000000-0000-4000-8000-00000000000f','a0000000-0000-4000-8000-000000000002','Priya Nair',95,80,'passed','Delivered late by half a day but compliance-complete.',now()-interval '6 days'),
('b0000000-0000-4000-8000-000000000009','a0000000-0000-4000-8000-000000000006','Neha Verma',0,0,'pending','Awaiting AI review completion.',now()-interval '4 hours'),
('b0000000-0000-4000-8000-000000000017','a0000000-0000-4000-8000-000000000006','Neha Verma',70,85,'rework','Error payload needs sample and field-level codes.',now()-interval '4 hours');

-- TIME LOGS
INSERT INTO public.tm_time_logs (task_id, member_id, action, started_at, ended_at, seconds, note) VALUES
('b0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000003','start',now()-interval '8 hours',now()-interval '5 hours',10800,'Resolver refactor'),
('b0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000003','pause',now()-interval '5 hours',now()-interval '4 hours',3600,'Client call'),
('b0000000-0000-4000-8000-000000000001','a0000000-0000-4000-8000-000000000003','resume',now()-interval '4 hours',NULL,12900,'Override UI'),
('b0000000-0000-4000-8000-000000000002','a0000000-0000-4000-8000-000000000002','start',now()-interval '3 hours',NULL,10080,'P1 hotfix'),
('b0000000-0000-4000-8000-00000000000a','a0000000-0000-4000-8000-000000000005','start',now()-interval '6 days',now()-interval '5 days',28800,'Device handshake'),
('b0000000-0000-4000-8000-00000000000a','a0000000-0000-4000-8000-000000000005','resume',now()-interval '2 days',NULL,16800,'Suppression window'),
('b0000000-0000-4000-8000-000000000015','a0000000-0000-4000-8000-000000000007','start',now()-interval '4 hours',NULL,12300,'CVE sweep'),
('b0000000-0000-4000-8000-00000000000d','a0000000-0000-4000-8000-000000000007','stop',now()-interval '8 days',now()-interval '3 days',42300,'Migration complete');

-- ESCALATIONS
INSERT INTO public.tm_escalations (task_id, level, reason, raised_by, raised_to, status, resolution, resolved_at, created_at) VALUES
('b0000000-0000-4000-8000-000000000002',2,'Production P1 affecting three hospital branches; SLA window under one hour.','Divya Menon','tech_lead','acknowledged',NULL,NULL,now()-interval '2 hours'),
('b0000000-0000-4000-8000-00000000000b',2,'Promised delivery window missed by 14 hours with no revised ETA.','system','delivery_manager','open',NULL,NULL,now()-interval '13 hours'),
('b0000000-0000-4000-8000-00000000000c',3,'Task overdue by 2 days and still unassigned at L2.','system','task_manager','open',NULL,NULL,now()-interval '1 day'),
('b0000000-0000-4000-8000-000000000015',1,'Critical CVE SLA is 12 hours; 35% progress at the halfway mark.','system','devops','acknowledged',NULL,NULL,now()-interval '2 hours'),
('b0000000-0000-4000-8000-000000000007',1,'Blocked more than 48 hours on an external vendor dependency.','Neha Verma','task_manager','resolved','Vendor committed to a snapshot refresh tonight.',now()-interval '6 hours',now()-interval '2 days');

-- AUTOMATIONS
INSERT INTO public.tm_automations (name, description, trigger_type, condition_json, action_type, action_config, enabled, run_count, last_run_at) VALUES
('Auto-assign by skill','Route new tasks to the least-loaded active member whose skills match the task tags.','task_created','{"has_assignee": false}','assign','{"strategy":"least_loaded_skill_match"}',true,214,now()-interval '2 hours'),
('SLA 75% warning buzzer','Fire the buzzer when a task crosses 75% of its SLA window without completion.','sla_at_risk','{"threshold_percent":75}','buzzer','{"repeat_minutes":10}',true,86,now()-interval '40 minutes'),
('Breach escalation to manager','Escalate to level 2 and notify the delivery manager as soon as SLA is breached.','sla_breached','{}','escalate','{"level":2,"notify":"delivery_manager"}',true,31,now()-interval '13 hours'),
('Critical priority on production bugs','Any bugfix tagged production is raised to critical priority automatically.','task_created','{"category":"bugfix","tag":"production"}','set_priority','{"priority":"critical"}',true,18,now()-interval '4 hours'),
('Approval reminder','Ping approvers when an approval has been pending more than 6 hours.','approval_pending','{"pending_hours":6}','notify','{"channel":"in_app"}',true,64,now()-interval '3 hours'),
('AI review on completion','Send completed development tasks to AI review before manager approval.','task_completed','{"category":"development"}','ai_review','{"model":"google/gemini-3.5-flash"}',true,47,now()-interval '1 day'),
('Daily delivery digest','Post a per-client digest of task movement every evening.','daily_digest','{"at":"18:30"}','notify','{"channel":"in_app"}',false,0,NULL);

-- NOTIFICATIONS
INSERT INTO public.tm_notifications (task_id, title, message, level, read, created_at) VALUES
('b0000000-0000-4000-8000-000000000002','P1 escalation acknowledged','Priya Nair acknowledged the OPD queue crash escalation.','critical',false,now()-interval '2 hours'),
('b0000000-0000-4000-8000-00000000000b','SLA breached','TSK-1011 crossed its promised delivery window 14 hours ago.','critical',false,now()-interval '13 hours'),
('b0000000-0000-4000-8000-000000000015','SLA at risk','TSK-1021 is at 75% of its 12-hour SLA window.','warning',false,now()-interval '40 minutes'),
('b0000000-0000-4000-8000-000000000001','Approval pending','TSK-1001 is waiting on manager approval for over 6 hours.','warning',true,now()-interval '3 hours'),
('b0000000-0000-4000-8000-000000000016','Task accepted','Arjun Desai accepted TSK-1022. Timer will start on first execution.','info',true,now()-interval '2 hours'),
('b0000000-0000-4000-8000-00000000000d','Task approved','TSK-1013 was approved with a quality score of 92.','success',true,now()-interval '3 days'),
('b0000000-0000-4000-8000-000000000018','AI task drafted','AI generated TSK-1018 from the weekly delivery review notes.','info',false,now()-interval '1 hour');

-- ACTIVITY / AUDIT
INSERT INTO public.tm_activity (task_id, actor_name, actor_role, action, action_type, from_value, to_value, details, created_at) VALUES
('b0000000-0000-4000-8000-000000000001','Rohan Mehta','task_manager','Task created','create',NULL,'new','GST slab rework raised from the finance change request.',now()-interval '1 day'),
('b0000000-0000-4000-8000-000000000001','Rohan Mehta','task_manager','Assigned task','assign',NULL,'Arjun Desai','Matched on POS and billing skills.',now()-interval '10 hours'),
('b0000000-0000-4000-8000-000000000001','Arjun Desai','developer','Status changed','status','assigned','in_progress','Timer started.',now()-interval '8 hours'),
('b0000000-0000-4000-8000-000000000001','Priya Nair','tech_lead','Approval decision','approval','pending','approved','Lead stage approved.',now()-interval '7 hours'),
('b0000000-0000-4000-8000-000000000002','Divya Menon','support_engineer','Task created','create',NULL,'new','Raised from three branch incident reports.',now()-interval '4 hours'),
('b0000000-0000-4000-8000-000000000002','System','automation','Priority raised','priority','high','critical','Automation: critical priority on production bugs.',now()-interval '4 hours'),
('b0000000-0000-4000-8000-000000000002','System','automation','Escalated','escalate','1','2','SLA window under one hour.',now()-interval '2 hours'),
('b0000000-0000-4000-8000-000000000007','Karan Patel','devops','Status changed','status','in_progress','blocked','Vendor snapshot dependency.',now()-interval '2 days'),
('b0000000-0000-4000-8000-00000000000b','System','automation','SLA breached','sla','on_track','breached','Promised window missed by 14 hours.',now()-interval '13 hours'),
('b0000000-0000-4000-8000-00000000000d','Neha Verma','qa_engineer','Review completed','review','pending','passed','Quality 92, timeliness 95.',now()-interval '3 days'),
('b0000000-0000-4000-8000-00000000000d','Rohan Mehta','task_manager','Approval decision','approval','pending','approved','Closed and marked billable.',now()-interval '3 days'),
('b0000000-0000-4000-8000-00000000000f','Vikram Singh','delivery_manager','Client sign-off','approval','pending','approved','ABDM compliance acceptance received.',now()-interval '6 days'),
('b0000000-0000-4000-8000-000000000018','AI Task Generator','ai','Task drafted','create',NULL,'new','Generated from weekly delivery review notes.',now()-interval '1 hour'),
('b0000000-0000-4000-8000-000000000013','AI Task Generator','ai','Task drafted','create',NULL,'new','Generated from support duplicate-ticket analysis.',now()-interval '20 hours');

-- SETTINGS
INSERT INTO public.tm_settings (default_sla_hours, critical_sla_hours, sla_warning_percent, auto_assign, auto_escalate, buzzer_enabled, buzzer_repeat_minutes, require_approval, ai_review_enabled, working_hours_start, working_hours_end, timezone, escalation_matrix)
VALUES (24, 4, 75, true, true, true, 10, true, true, '09:30', '19:00', 'Asia/Kolkata',
'[{"level":1,"after_percent":75,"notify":"tech_lead"},{"level":2,"after_percent":100,"notify":"delivery_manager"},{"level":3,"after_percent":150,"notify":"task_manager"}]'::jsonb);

-- keep member task counts consistent
UPDATE public.tm_tasks SET actual_minutes = GREATEST(actual_minutes, 0);
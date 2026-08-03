import { useMemo, useState } from "react";
import { Bell, CheckCheck } from "lucide-react";

import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { ScrollArea } from "@/components/ui/scroll-area";
import { relativeTime } from "@/lib/tm/format";
import {
  useApprovals,
  useEscalations,
  useMarkAllNotificationsRead,
  useMarkNotificationRead,
  useNotifications,
  useRealtimeTasks,
  useTasks,
} from "@/lib/tm/hooks";
import { computeSLA } from "@/lib/tm/format";
import { TMSidebar, TM_NAV, type TMScreen } from "./TMSidebar";
import { TMTaskDetail } from "./TMTaskDetail";
import { TMDashboard } from "./screens/TMDashboard";
import { TMInbox } from "./screens/TMInbox";
import { TMTaskCreation } from "./screens/TMTaskCreation";
import { TMAIGenerator } from "./screens/TMAIGenerator";
import { TMAssignment } from "./screens/TMAssignment";
import { TMExecution } from "./screens/TMExecution";
import { TMDependency } from "./screens/TMDependency";
import { TMApproval } from "./screens/TMApproval";
import { TMReview } from "./screens/TMReview";
import { TMSLATracker } from "./screens/TMSLATracker";
import { TMEscalation } from "./screens/TMEscalation";
import { TMAutomation } from "./screens/TMAutomation";
import { TMHistory } from "./screens/TMHistory";
import { TMAnalytics } from "./screens/TMAnalytics";
import { TMAuditLog } from "./screens/TMAuditLog";
import { TMSettings } from "./screens/TMSettings";

export function TMShell() {
  useRealtimeTasks();
  const [screen, setScreen] = useState<TMScreen>("task_dashboard");
  const [collapsed, setCollapsed] = useState(false);
  const [openTaskId, setOpenTaskId] = useState<string | null>(null);

  const { data: tasks } = useTasks();
  const { data: approvals } = useApprovals();
  const { data: escalations } = useEscalations();
  const { data: notifications } = useNotifications();
  const markRead = useMarkNotificationRead();
  const markAll = useMarkAllNotificationsRead();

  const badges = useMemo<Partial<Record<TMScreen, number>>>(
    () => ({
      task_inbox: (tasks ?? []).filter((t) => t.status === "new").length,
      task_assignment: (tasks ?? []).filter((t) => !t.assigned_to && t.status !== "completed" && t.status !== "cancelled").length,
      task_approval: (approvals ?? []).filter((a) => a.status === "pending").length,
      task_escalation: (escalations ?? []).filter((e) => e.status === "open").length,
      task_sla_tracker: (tasks ?? []).filter((t) => computeSLA(t).state === "breached").length,
    }),
    [tasks, approvals, escalations],
  );

  const unread = (notifications ?? []).filter((n) => !n.read);
  const openTask = (taskId: string) => setOpenTaskId(taskId);

  const content = () => {
    switch (screen) {
      case "task_dashboard":
        return <TMDashboard onNavigate={setScreen} />;
      case "task_inbox":
        return <TMInbox onOpenTask={openTask} />;
      case "task_creation":
        return <TMTaskCreation onCreated={openTask} />;
      case "ai_task_generator":
        return <TMAIGenerator onCreated={openTask} />;
      case "task_assignment":
        return <TMAssignment onOpenTask={openTask} />;
      case "task_execution":
        return <TMExecution onOpenTask={openTask} />;
      case "task_dependency":
        return <TMDependency onOpenTask={openTask} />;
      case "task_approval":
        return <TMApproval onOpenTask={openTask} />;
      case "task_review":
        return <TMReview onOpenTask={openTask} />;
      case "task_sla_tracker":
        return <TMSLATracker onOpenTask={openTask} />;
      case "task_escalation":
        return <TMEscalation onOpenTask={openTask} />;
      case "task_automation":
        return <TMAutomation />;
      case "task_history":
        return <TMHistory onOpenTask={openTask} />;
      case "task_analytics":
        return <TMAnalytics />;
      case "task_audit_log":
        return <TMAuditLog />;
      case "task_settings":
        return <TMSettings />;
    }
  };

  const activeLabel = TM_NAV.find((item) => item.id === screen)?.label ?? "Task Manager";

  return (
    <div className="flex h-screen w-full overflow-hidden bg-background">
      <TMSidebar
        activeScreen={screen}
        onScreenChange={setScreen}
        collapsed={collapsed}
        onToggleCollapse={() => setCollapsed((v) => !v)}
        badges={badges}
      />

      <div className="flex min-w-0 flex-1 flex-col">
        <header className="flex h-14 shrink-0 items-center justify-between border-b border-border px-6">
          <p className="font-display text-sm font-medium text-foreground">{activeLabel}</p>
          <Popover>
            <PopoverTrigger asChild>
              <Button variant="ghost" size="icon" className="relative" aria-label="Notifications">
                <Bell className="h-4 w-4" />
                {unread.length > 0 && (
                  <span className="absolute -right-0.5 -top-0.5 grid h-4 min-w-4 place-items-center rounded-full bg-destructive px-1 text-[10px] text-destructive-foreground">
                    {unread.length}
                  </span>
                )}
              </Button>
            </PopoverTrigger>
            <PopoverContent align="end" className="w-80 p-0">
              <div className="flex items-center justify-between border-b border-border p-3">
                <p className="text-sm font-medium text-foreground">Notifications</p>
                <Button variant="ghost" size="sm" onClick={() => markAll.mutate(undefined)}>
                  <CheckCheck className="mr-1 h-3 w-3" /> Mark all
                </Button>
              </div>
              <ScrollArea className="max-h-80">
                <div className="divide-y divide-border">
                  {(notifications ?? []).map((item) => (
                    <button
                      key={item.id}
                      type="button"
                      className="block w-full p-3 text-left hover:bg-accent/40"
                      onClick={() => {
                        if (!item.read) markRead.mutate(item.id);
                        if (item.task_id) openTask(item.task_id);
                      }}
                    >
                      <div className="flex items-center justify-between gap-2">
                        <p className="text-sm text-foreground">{item.title}</p>
                        {!item.read && <Badge variant="outline">new</Badge>}
                      </div>
                      <p className="text-xs text-muted-foreground">{item.message}</p>
                      <p className="text-xs text-muted-foreground">{relativeTime(item.created_at)}</p>
                    </button>
                  ))}
                  {(notifications ?? []).length === 0 && (
                    <p className="p-4 text-center text-sm text-muted-foreground">No notifications</p>
                  )}
                </div>
              </ScrollArea>
            </PopoverContent>
          </Popover>
        </header>

        <main className="scrollbar-slim flex-1 overflow-y-auto p-6">{content()}</main>
      </div>

      <TMTaskDetail taskId={openTaskId} onOpenChange={(open) => !open && setOpenTaskId(null)} />
    </div>
  );
}

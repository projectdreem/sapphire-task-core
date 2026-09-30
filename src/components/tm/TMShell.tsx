import { useMemo, useState } from "react";
import { Bell, CheckCheck, Menu, Plus, Search } from "lucide-react";

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
import { TMSidebar, TM_NAV, useTMSidebarState, type TMScreen } from "./TMSidebar";
import { TMTaskDetail } from "./TMTaskDetail";
import { TMDashboard } from "./screens/TMDashboard";
import { TMInbox } from "./screens/TMInbox";
import { TMPipeline } from "./screens/TMPipeline";
import { TMGantt } from "./screens/TMGantt";
import { TMBuzzer } from "./screens/TMBuzzer";
import { TMChat } from "./screens/TMChat";
import { TMWallet } from "./screens/TMWallet";
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
  const { collapsed, toggleCollapsed, mobileOpen, setMobileOpen } = useTMSidebarState();
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
      task_buzzer: (tasks ?? []).filter((t) => t.buzzer_active).length,
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
      case "task_pipeline":
        return <TMPipeline onOpenTask={openTask} />;
      case "task_creation":
        return <TMTaskCreation onCreated={openTask} />;
      case "ai_task_generator":
        return <TMAIGenerator onCreated={openTask} />;
      case "task_assignment":
        return <TMAssignment onOpenTask={openTask} />;
      case "task_execution":
        return <TMExecution onOpenTask={openTask} />;
      case "task_gantt":
        return <TMGantt onOpenTask={openTask} />;
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
      case "task_buzzer":
        return <TMBuzzer onOpenTask={openTask} />;
      case "task_chat":
        return <TMChat onOpenTask={openTask} />;
      case "task_wallet":
        return <TMWallet onOpenTask={openTask} />;
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
      default:
        return <TMDashboard onNavigate={setScreen} />;
    }
  };

  const activeLabel = TM_NAV.find((item) => item.id === screen)?.label ?? "Task Manager";

  return (
    <div className="flex min-h-screen w-full bg-background">
      <TMSidebar
        activeScreen={screen}
        onScreenChange={setScreen}
        collapsed={collapsed}
        onToggleCollapse={toggleCollapsed}
        badges={badges}
        mobileOpen={mobileOpen}
        onCloseMobile={() => setMobileOpen(false)}
      />

      <div className="flex min-w-0 flex-1 flex-col">
        <header className="sticky top-0 z-40 grid h-14 shrink-0 grid-cols-[auto_minmax(0,1fr)_auto] items-center gap-3 border-b border-border bg-background/80 px-3 backdrop-blur-xl lg:px-8">
          <button
            className="icon3d grid h-9 w-9 shrink-0 place-items-center rounded-xl text-muted-foreground transition-colors hover:text-foreground lg:hidden"
            onClick={() => setMobileOpen(true)}
            aria-label="Open menu"
          >
            <Menu className="h-[18px] w-[18px]" />
          </button>
          <button
            className="hidden min-w-0 max-w-sm items-center gap-2 rounded-md border border-border bg-surface/40 px-3 py-2 text-left text-xs text-muted-foreground transition-colors hover:border-primary/40 hover:text-foreground sm:flex"
            onClick={() => setScreen("task_inbox")}
            aria-label="Search tasks"
          >
            <Search className="h-4 w-4 shrink-0" />
            <span className="truncate">Search tasks, codes or clients…</span>
          </button>
          <p className="min-w-0 truncate text-sm font-medium text-foreground sm:hidden">{activeLabel}</p>
          <div className="flex items-center justify-end gap-2">
          <Popover>
            <PopoverTrigger asChild>
              <button
                className="relative grid h-9 w-9 shrink-0 place-items-center rounded-md border border-transparent text-muted-foreground transition-colors hover:border-border hover:bg-surface hover:text-foreground"
                aria-label="Notifications"
              >
                <Bell className="h-[18px] w-[18px]" />
                {unread.length > 0 && (
                  <span className="absolute -right-1 -top-1 grid h-[18px] min-w-[18px] place-items-center rounded-full bg-primary px-1 text-[10px] font-bold leading-none text-primary-foreground ring-2 ring-background">
                    {unread.length}
                  </span>
                )}
              </button>
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
          <div className="hidden h-5 w-px bg-border sm:block" />
          <Button size="sm" onClick={() => setScreen("task_creation")}>
            <Plus className="h-4 w-4" />
            <span className="hidden sm:inline">New Task</span>
          </Button>
          </div>
        </header>

        <main className="flex-1">
          <div className="mx-auto w-full max-w-[1600px] space-y-6 px-4 py-5 sm:px-6 sm:py-7 lg:px-8">
            {content()}
          </div>
        </main>
      </div>

      <TMTaskDetail taskId={openTaskId} onOpenChange={(open) => !open && setOpenTaskId(null)} />
    </div>
  );
}

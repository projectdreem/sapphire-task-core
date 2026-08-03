import type { ElementType } from "react";
import {
  ArrowUpCircle,
  BarChart3,
  Bot,
  CheckCircle,
  ChevronLeft,
  ChevronRight,
  ClipboardCheck,
  Clock,
  FileText,
  GitBranch,
  History,
  Inbox,
  LayoutDashboard,
  ListChecks,
  Play,
  PlusCircle,
  Settings,
  UserCheck,
  Zap,
} from "lucide-react";

import { Button } from "@/components/ui/button";
import { ScrollArea } from "@/components/ui/scroll-area";
import { cn } from "@/lib/utils";

export type TMScreen =
  | "task_dashboard"
  | "task_inbox"
  | "task_creation"
  | "ai_task_generator"
  | "task_assignment"
  | "task_execution"
  | "task_dependency"
  | "task_approval"
  | "task_review"
  | "task_sla_tracker"
  | "task_escalation"
  | "task_automation"
  | "task_history"
  | "task_analytics"
  | "task_audit_log"
  | "task_settings";

interface SidebarItem {
  id: TMScreen;
  label: string;
  icon: ElementType;
}

export const TM_NAV: SidebarItem[] = [
  { id: "task_dashboard", label: "Task Dashboard", icon: LayoutDashboard },
  { id: "task_inbox", label: "Task Inbox", icon: Inbox },
  { id: "task_creation", label: "Task Creation", icon: PlusCircle },
  { id: "ai_task_generator", label: "AI Task Generator", icon: Bot },
  { id: "task_assignment", label: "Task Assignment", icon: UserCheck },
  { id: "task_execution", label: "Task Execution", icon: Play },
  { id: "task_dependency", label: "Task Dependency", icon: GitBranch },
  { id: "task_approval", label: "Task Approval", icon: CheckCircle },
  { id: "task_review", label: "Task Review", icon: ClipboardCheck },
  { id: "task_sla_tracker", label: "Task SLA Tracker", icon: Clock },
  { id: "task_escalation", label: "Task Escalation", icon: ArrowUpCircle },
  { id: "task_automation", label: "Task Automation", icon: Zap },
  { id: "task_history", label: "Task History", icon: History },
  { id: "task_analytics", label: "Task Analytics", icon: BarChart3 },
  { id: "task_audit_log", label: "Task Audit Log", icon: FileText },
  { id: "task_settings", label: "Task Settings", icon: Settings },
];

export function TMSidebar({
  activeScreen,
  onScreenChange,
  collapsed,
  onToggleCollapse,
  badges,
}: {
  activeScreen: TMScreen;
  onScreenChange: (screen: TMScreen) => void;
  collapsed: boolean;
  onToggleCollapse: () => void;
  badges: Partial<Record<TMScreen, number>>;
}) {
  return (
    <aside
      className={cn(
        "flex h-full shrink-0 flex-col border-r border-border bg-sidebar transition-all duration-300",
        collapsed ? "w-16" : "w-64",
      )}
    >
      <div className="flex items-center justify-between gap-2 border-b border-border p-4">
        <div className={cn("flex items-center gap-2 overflow-hidden", collapsed && "justify-center")}>
          <span className="grid h-9 w-9 shrink-0 place-items-center rounded-lg gradient-brand text-primary-foreground">
            <ListChecks className="h-5 w-5" />
          </span>
          {!collapsed && (
            <div className="min-w-0">
              <p className="truncate font-display text-sm font-semibold text-foreground">Software Vala</p>
              <p className="truncate text-xs text-muted-foreground">Task Manager</p>
            </div>
          )}
        </div>
        <Button
          variant="ghost"
          size="icon"
          className="h-7 w-7 shrink-0"
          onClick={onToggleCollapse}
          aria-label={collapsed ? "Expand sidebar" : "Collapse sidebar"}
        >
          {collapsed ? <ChevronRight className="h-4 w-4" /> : <ChevronLeft className="h-4 w-4" />}
        </Button>
      </div>

      <ScrollArea className="flex-1">
        <nav className="space-y-1 p-2">
          {TM_NAV.map((item) => {
            const badge = badges[item.id];
            const active = activeScreen === item.id;
            return (
              <Button
                key={item.id}
                variant={active ? "secondary" : "ghost"}
                className={cn("h-10 w-full justify-start gap-3", collapsed && "justify-center px-2")}
                onClick={() => onScreenChange(item.id)}
                title={item.label}
              >
                <item.icon className="h-4 w-4 shrink-0" />
                {!collapsed && (
                  <>
                    <span className="truncate text-sm">{item.label}</span>
                    {badge ? (
                      <span className="ml-auto rounded-full bg-destructive px-1.5 py-0.5 text-xs text-destructive-foreground">
                        {badge}
                      </span>
                    ) : null}
                  </>
                )}
              </Button>
            );
          })}
        </nav>
      </ScrollArea>

      <div className="border-t border-border p-3">
        {!collapsed && (
          <p className="text-center text-[11px] tracking-widest text-muted-foreground">
            ENTERPRISE • AI-FIRST • ZERO-MISS
          </p>
        )}
      </div>
    </aside>
  );
}

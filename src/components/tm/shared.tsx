import type { ReactNode } from "react";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { cn } from "@/lib/utils";
import {
  PRIORITY_CLASSES,
  PRIORITY_LABELS,
  STATUS_CLASSES,
  STATUS_LABELS,
  computeSLA,
} from "@/lib/tm/format";
import type { TMTask, TMTaskPriority, TMTaskStatus } from "@/lib/tm/types";

export function TMPageHeader({
  title,
  subtitle,
  actions,
}: {
  title: string;
  subtitle: string;
  actions?: ReactNode;
}) {
  return (
    <div className="flex flex-wrap items-end justify-between gap-4">
      <div>
        <h1 className="font-display text-2xl font-semibold tracking-tight text-foreground">{title}</h1>
        <p className="text-sm text-muted-foreground">{subtitle}</p>
      </div>
      {actions ? <div className="flex flex-wrap items-center gap-2">{actions}</div> : null}
    </div>
  );
}

export function TMPanel({
  title,
  icon,
  actions,
  children,
  className,
}: {
  title: ReactNode;
  icon?: ReactNode;
  actions?: ReactNode;
  children: ReactNode;
  className?: string;
}) {
  return (
    <Card className={cn("glass-panel border-0", className)}>
      <CardHeader className="flex flex-row items-center justify-between gap-3 pb-3">
        <CardTitle className="flex items-center gap-2 font-display text-base text-foreground">
          {icon}
          {title}
        </CardTitle>
        {actions}
      </CardHeader>
      <CardContent>{children}</CardContent>
    </Card>
  );
}

export function TMStat({
  label,
  value,
  icon,
  onClick,
  tone = "default",
}: {
  label: string;
  value: string | number;
  icon: ReactNode;
  onClick?: () => void;
  tone?: "default" | "success" | "warning" | "danger" | "info";
}) {
  const toneClass = {
    default: "text-primary",
    success: "text-success",
    warning: "text-warning",
    danger: "text-destructive",
    info: "text-info",
  }[tone];

  return (
    <Card
      className={cn(
        "glass-panel border-0 transition-colors",
        onClick && "cursor-pointer hover:bg-accent/40",
      )}
      onClick={onClick}
    >
      <CardContent className="p-4">
        <div className="flex items-center justify-between">
          <span className={cn("[&_svg]:h-7 [&_svg]:w-7", toneClass)}>{icon}</span>
          <span className="font-display text-2xl font-semibold text-foreground">{value}</span>
        </div>
        <p className="mt-2 text-sm text-muted-foreground">{label}</p>
      </CardContent>
    </Card>
  );
}

export function StatusBadge({ status }: { status: TMTaskStatus }) {
  return (
    <Badge variant="outline" className={cn("border", STATUS_CLASSES[status])}>
      {STATUS_LABELS[status]}
    </Badge>
  );
}

export function PriorityBadge({ priority }: { priority: TMTaskPriority }) {
  return (
    <Badge variant="outline" className={cn("border", PRIORITY_CLASSES[priority])}>
      {PRIORITY_LABELS[priority]}
    </Badge>
  );
}

export function SLABadge({
  task,
  warningPercent = 75,
}: {
  task: Pick<TMTask, "status" | "created_at" | "promised_at" | "deadline" | "completed_at" | "sla_hours">;
  warningPercent?: number;
}) {
  const sla = computeSLA(task, warningPercent);
  return <span className={cn("text-xs font-medium", sla.className)}>{sla.label}</span>;
}

export function TaskCode({ code }: { code: string }) {
  return <span className="font-mono text-xs text-muted-foreground">{code}</span>;
}

export function TMEmpty({ message }: { message: string }) {
  return <p className="py-10 text-center text-sm text-muted-foreground">{message}</p>;
}

export function TMLoading({ label = "Loading" }: { label?: string }) {
  return <p className="py-10 text-center text-sm text-muted-foreground">{label}…</p>;
}

export function TMRow({ children, className }: { children: ReactNode; className?: string }) {
  return (
    <div
      className={cn(
        "flex flex-wrap items-center justify-between gap-4 rounded-lg border border-border bg-muted/40 p-4",
        className,
      )}
    >
      {children}
    </div>
  );
}

import { createFileRoute } from "@tanstack/react-router";

import { TMShell } from "@/components/tm/TMShell";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "Task Manager — Software Vala Operations Control" },
      {
        name: "description",
        content:
          "Software Vala Task Manager: intake, assignment, execution timers, SLA tracking, approvals, escalations, automation and audit trail.",
      },
      { property: "og:title", content: "Task Manager — Software Vala Operations Control" },
      {
        property: "og:description",
        content:
          "Live task operations: SLA tracker, approvals, escalations, automation rules and a full audit trail.",
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: TaskManagerPage,
});

function TaskManagerPage() {
  return <TMShell />;
}

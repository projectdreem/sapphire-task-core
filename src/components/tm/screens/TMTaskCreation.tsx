import { useState } from "react";
import { Plus, X } from "lucide-react";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Textarea } from "@/components/ui/textarea";
import { titleCase } from "@/lib/tm/format";
import { useCreateTask, useMembers, useSettings } from "@/lib/tm/hooks";
import { TM_CATEGORIES, TM_DIFFICULTIES, TM_PRIORITIES } from "@/lib/tm/types";
import { TMPageHeader, TMPanel } from "../shared";

export function TMTaskCreation({ onCreated }: { onCreated: (taskId: string) => void }) {
  const { data: members } = useMembers();
  const { data: settings } = useSettings();
  const createTask = useCreateTask();

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [category, setCategory] = useState<string>("development");
  const [module, setModule] = useState("");
  const [client, setClient] = useState("");
  const [priority, setPriority] = useState<string>("medium");
  const [difficulty, setDifficulty] = useState<string>("medium");
  const [assignee, setAssignee] = useState<string>("unassigned");
  const [estimated, setEstimated] = useState("4");
  const [slaHours, setSlaHours] = useState(String(settings?.default_sla_hours ?? 24));
  const [billable, setBillable] = useState(true);
  const [requireApproval, setRequireApproval] = useState(false);
  const [tags, setTags] = useState<string[]>([]);
  const [tagDraft, setTagDraft] = useState("");
  const [checklist, setChecklist] = useState<string[]>([]);
  const [checklistDraft, setChecklistDraft] = useState("");

  const submit = async () => {
    if (!title.trim()) return;
    const hours = Number(slaHours) || 24;
    const deadline = new Date(Date.now() + hours * 3600_000).toISOString();
    const task = await createTask.mutateAsync({
      title: title.trim(),
      description: description.trim(),
      category,
      module: module.trim() || null,
      client_name: client.trim() || null,
      priority,
      difficulty,
      assigned_to: assignee === "unassigned" ? null : assignee,
      status: assignee === "unassigned" ? "new" : "assigned",
      estimated_hours: Number(estimated) || 4,
      sla_hours: hours,
      promised_at: deadline,
      deadline,
      billable,
      approval_status: requireApproval ? "pending" : "not_required",
      tags,
      subtasks: checklist,
    });
    setTitle("");
    setDescription("");
    setTags([]);
    setChecklist([]);
    onCreated(task.id);
  };

  return (
    <div className="space-y-6">
      <TMPageHeader title="Task Creation" subtitle="Create a task with SLA, ownership, checklist and approval routing" />

      <div className="grid gap-6 lg:grid-cols-3">
        <TMPanel title="Task details" className="lg:col-span-2">
          <div className="space-y-4">
            <div className="space-y-2">
              <Label>Title</Label>
              <Input value={title} onChange={(e) => setTitle(e.target.value)} placeholder="e.g. Fix payment webhook retry loop" />
            </div>
            <div className="space-y-2">
              <Label>Description</Label>
              <Textarea rows={5} value={description} onChange={(e) => setDescription(e.target.value)} placeholder="Scope, acceptance criteria, links" />
            </div>
            <div className="grid gap-4 sm:grid-cols-2">
              <div className="space-y-2">
                <Label>Category</Label>
                <Select value={category} onValueChange={setCategory}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>{TM_CATEGORIES.map((c) => <SelectItem key={c} value={c}>{titleCase(c)}</SelectItem>)}</SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>Module</Label>
                <Input value={module} onChange={(e) => setModule(e.target.value)} placeholder="Billing, CRM, Portal…" />
              </div>
              <div className="space-y-2">
                <Label>Client</Label>
                <Input value={client} onChange={(e) => setClient(e.target.value)} placeholder="Client / internal" />
              </div>
              <div className="space-y-2">
                <Label>Assign to</Label>
                <Select value={assignee} onValueChange={setAssignee}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="unassigned">Leave in new queue</SelectItem>
                    {(members ?? []).map((m) => <SelectItem key={m.id} value={m.id}>{m.full_name} — {titleCase(m.role)}</SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="space-y-2">
              <Label>Checklist</Label>
              <div className="flex gap-2">
                <Input value={checklistDraft} onChange={(e) => setChecklistDraft(e.target.value)} placeholder="Add a checklist item" />
                <Button
                  type="button"
                  variant="outline"
                  size="icon"
                  onClick={() => {
                    if (!checklistDraft.trim()) return;
                    setChecklist([...checklist, checklistDraft.trim()]);
                    setChecklistDraft("");
                  }}
                >
                  <Plus className="h-4 w-4" />
                </Button>
              </div>
              <div className="space-y-1">
                {checklist.map((item, index) => (
                  <div key={`${item}-${index}`} className="flex items-center justify-between rounded-md bg-muted/40 px-3 py-2 text-sm">
                    {item}
                    <button type="button" onClick={() => setChecklist(checklist.filter((_, i) => i !== index))}>
                      <X className="h-3 w-3 text-muted-foreground" />
                    </button>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </TMPanel>

        <TMPanel title="Delivery controls">
          <div className="space-y-4">
            <div className="space-y-2">
              <Label>Priority</Label>
              <Select value={priority} onValueChange={setPriority}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>{TM_PRIORITIES.map((p) => <SelectItem key={p} value={p}>{titleCase(p)}</SelectItem>)}</SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>Difficulty</Label>
              <Select value={difficulty} onValueChange={setDifficulty}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>{TM_DIFFICULTIES.map((d) => <SelectItem key={d} value={d}>{titleCase(d)}</SelectItem>)}</SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>Estimated hours</Label>
              <Input type="number" min="0.5" step="0.5" value={estimated} onChange={(e) => setEstimated(e.target.value)} />
            </div>
            <div className="space-y-2">
              <Label>SLA hours</Label>
              <Input type="number" min="1" value={slaHours} onChange={(e) => setSlaHours(e.target.value)} />
            </div>
            <div className="space-y-2">
              <Label>Tags</Label>
              <div className="flex gap-2">
                <Input value={tagDraft} onChange={(e) => setTagDraft(e.target.value)} placeholder="Add tag" />
                <Button
                  type="button"
                  variant="outline"
                  size="icon"
                  onClick={() => {
                    if (!tagDraft.trim()) return;
                    setTags([...tags, tagDraft.trim()]);
                    setTagDraft("");
                  }}
                >
                  <Plus className="h-4 w-4" />
                </Button>
              </div>
              <div className="flex flex-wrap gap-2">
                {tags.map((tag, index) => (
                  <button
                    key={`${tag}-${index}`}
                    type="button"
                    onClick={() => setTags(tags.filter((_, i) => i !== index))}
                    className="rounded-full border border-border px-2 py-0.5 text-xs text-muted-foreground"
                  >
                    {tag} ×
                  </button>
                ))}
              </div>
            </div>
            <div className="flex items-center justify-between">
              <Label>Billable</Label>
              <Switch checked={billable} onCheckedChange={setBillable} />
            </div>
            <div className="flex items-center justify-between">
              <Label>Require approval</Label>
              <Switch checked={requireApproval} onCheckedChange={setRequireApproval} />
            </div>
            <Button className="w-full" onClick={submit} disabled={createTask.isPending || !title.trim()}>
              {createTask.isPending ? "Creating…" : "Create task"}
            </Button>
          </div>
        </TMPanel>
      </div>
    </div>
  );
}

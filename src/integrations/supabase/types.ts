export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      tm_activity: {
        Row: {
          action: string
          action_type: string
          actor_id: string | null
          actor_name: string
          actor_role: string
          created_at: string
          details: string | null
          from_value: string | null
          id: string
          meta: Json
          task_id: string | null
          to_value: string | null
          updated_at: string
        }
        Insert: {
          action: string
          action_type?: string
          actor_id?: string | null
          actor_name?: string
          actor_role?: string
          created_at?: string
          details?: string | null
          from_value?: string | null
          id?: string
          meta?: Json
          task_id?: string | null
          to_value?: string | null
          updated_at?: string
        }
        Update: {
          action?: string
          action_type?: string
          actor_id?: string | null
          actor_name?: string
          actor_role?: string
          created_at?: string
          details?: string | null
          from_value?: string | null
          id?: string
          meta?: Json
          task_id?: string | null
          to_value?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_activity_actor_id_fkey"
            columns: ["actor_id"]
            isOneToOne: false
            referencedRelation: "tm_members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tm_activity_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_approvals: {
        Row: {
          approver_id: string | null
          approver_name: string
          created_at: string
          decided_at: string | null
          id: string
          position: number
          remarks: string | null
          stage: string
          status: string
          task_id: string
          updated_at: string
        }
        Insert: {
          approver_id?: string | null
          approver_name: string
          created_at?: string
          decided_at?: string | null
          id?: string
          position?: number
          remarks?: string | null
          stage?: string
          status?: string
          task_id: string
          updated_at?: string
        }
        Update: {
          approver_id?: string | null
          approver_name?: string
          created_at?: string
          decided_at?: string | null
          id?: string
          position?: number
          remarks?: string | null
          stage?: string
          status?: string
          task_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_approvals_approver_id_fkey"
            columns: ["approver_id"]
            isOneToOne: false
            referencedRelation: "tm_members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tm_approvals_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_attachments: {
        Row: {
          created_at: string
          file_type: string
          id: string
          name: string
          size_kb: number
          task_id: string
          updated_at: string
          uploaded_by: string
          url: string
        }
        Insert: {
          created_at?: string
          file_type?: string
          id?: string
          name: string
          size_kb?: number
          task_id: string
          updated_at?: string
          uploaded_by?: string
          url?: string
        }
        Update: {
          created_at?: string
          file_type?: string
          id?: string
          name?: string
          size_kb?: number
          task_id?: string
          updated_at?: string
          uploaded_by?: string
          url?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_attachments_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_automations: {
        Row: {
          action_config: Json
          action_type: string
          condition_json: Json
          created_at: string
          description: string
          enabled: boolean
          id: string
          last_run_at: string | null
          name: string
          run_count: number
          trigger_type: string
          updated_at: string
        }
        Insert: {
          action_config?: Json
          action_type: string
          condition_json?: Json
          created_at?: string
          description?: string
          enabled?: boolean
          id?: string
          last_run_at?: string | null
          name: string
          run_count?: number
          trigger_type: string
          updated_at?: string
        }
        Update: {
          action_config?: Json
          action_type?: string
          condition_json?: Json
          created_at?: string
          description?: string
          enabled?: boolean
          id?: string
          last_run_at?: string | null
          name?: string
          run_count?: number
          trigger_type?: string
          updated_at?: string
        }
        Relationships: []
      }
      tm_comments: {
        Row: {
          author_id: string | null
          author_name: string
          author_role: string
          created_at: string
          id: string
          is_system: boolean
          message: string
          task_id: string
          updated_at: string
        }
        Insert: {
          author_id?: string | null
          author_name: string
          author_role?: string
          created_at?: string
          id?: string
          is_system?: boolean
          message: string
          task_id: string
          updated_at?: string
        }
        Update: {
          author_id?: string | null
          author_name?: string
          author_role?: string
          created_at?: string
          id?: string
          is_system?: boolean
          message?: string
          task_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_comments_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "tm_members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tm_comments_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_dependencies: {
        Row: {
          created_at: string
          dependency_type: string
          depends_on_task_id: string
          id: string
          status: string
          task_id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          dependency_type?: string
          depends_on_task_id: string
          id?: string
          status?: string
          task_id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          dependency_type?: string
          depends_on_task_id?: string
          id?: string
          status?: string
          task_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_dependencies_depends_on_task_id_fkey"
            columns: ["depends_on_task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tm_dependencies_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_escalations: {
        Row: {
          created_at: string
          id: string
          level: number
          raised_by: string
          raised_to: string
          reason: string
          resolution: string | null
          resolved_at: string | null
          status: string
          task_id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          level?: number
          raised_by?: string
          raised_to?: string
          reason: string
          resolution?: string | null
          resolved_at?: string | null
          status?: string
          task_id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          level?: number
          raised_by?: string
          raised_to?: string
          reason?: string
          resolution?: string | null
          resolved_at?: string | null
          status?: string
          task_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_escalations_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_members: {
        Row: {
          active: boolean
          capacity_hours: number
          created_at: string
          department: string
          email: string
          full_name: string
          id: string
          role: string
          skills: string[]
          updated_at: string
        }
        Insert: {
          active?: boolean
          capacity_hours?: number
          created_at?: string
          department?: string
          email: string
          full_name: string
          id?: string
          role?: string
          skills?: string[]
          updated_at?: string
        }
        Update: {
          active?: boolean
          capacity_hours?: number
          created_at?: string
          department?: string
          email?: string
          full_name?: string
          id?: string
          role?: string
          skills?: string[]
          updated_at?: string
        }
        Relationships: []
      }
      tm_notifications: {
        Row: {
          channel: string
          created_at: string
          id: string
          level: string
          message: string
          read: boolean
          task_id: string | null
          title: string
          updated_at: string
        }
        Insert: {
          channel?: string
          created_at?: string
          id?: string
          level?: string
          message: string
          read?: boolean
          task_id?: string | null
          title: string
          updated_at?: string
        }
        Update: {
          channel?: string
          created_at?: string
          id?: string
          level?: string
          message?: string
          read?: boolean
          task_id?: string | null
          title?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_notifications_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_reviews: {
        Row: {
          created_at: string
          id: string
          quality_score: number
          remarks: string | null
          reviewer_id: string | null
          reviewer_name: string
          task_id: string
          timeliness_score: number
          updated_at: string
          verdict: string
        }
        Insert: {
          created_at?: string
          id?: string
          quality_score?: number
          remarks?: string | null
          reviewer_id?: string | null
          reviewer_name: string
          task_id: string
          timeliness_score?: number
          updated_at?: string
          verdict?: string
        }
        Update: {
          created_at?: string
          id?: string
          quality_score?: number
          remarks?: string | null
          reviewer_id?: string | null
          reviewer_name?: string
          task_id?: string
          timeliness_score?: number
          updated_at?: string
          verdict?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_reviews_reviewer_id_fkey"
            columns: ["reviewer_id"]
            isOneToOne: false
            referencedRelation: "tm_members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tm_reviews_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_settings: {
        Row: {
          ai_review_enabled: boolean
          auto_assign: boolean
          auto_escalate: boolean
          buzzer_enabled: boolean
          buzzer_repeat_minutes: number
          critical_sla_hours: number
          default_sla_hours: number
          escalation_matrix: Json
          id: string
          require_approval: boolean
          singleton: boolean
          sla_warning_percent: number
          timezone: string
          updated_at: string
          working_hours_end: string
          working_hours_start: string
        }
        Insert: {
          ai_review_enabled?: boolean
          auto_assign?: boolean
          auto_escalate?: boolean
          buzzer_enabled?: boolean
          buzzer_repeat_minutes?: number
          critical_sla_hours?: number
          default_sla_hours?: number
          escalation_matrix?: Json
          id?: string
          require_approval?: boolean
          singleton?: boolean
          sla_warning_percent?: number
          timezone?: string
          updated_at?: string
          working_hours_end?: string
          working_hours_start?: string
        }
        Update: {
          ai_review_enabled?: boolean
          auto_assign?: boolean
          auto_escalate?: boolean
          buzzer_enabled?: boolean
          buzzer_repeat_minutes?: number
          critical_sla_hours?: number
          default_sla_hours?: number
          escalation_matrix?: Json
          id?: string
          require_approval?: boolean
          singleton?: boolean
          sla_warning_percent?: number
          timezone?: string
          updated_at?: string
          working_hours_end?: string
          working_hours_start?: string
        }
        Relationships: []
      }
      tm_subtasks: {
        Row: {
          completed: boolean
          created_at: string
          id: string
          position: number
          task_id: string
          title: string
          updated_at: string
        }
        Insert: {
          completed?: boolean
          created_at?: string
          id?: string
          position?: number
          task_id: string
          title: string
          updated_at?: string
        }
        Update: {
          completed?: boolean
          created_at?: string
          id?: string
          position?: number
          task_id?: string
          title?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_subtasks_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_tasks: {
        Row: {
          accepted_at: string | null
          actual_minutes: number
          ai_generated: boolean
          approval_status: string
          assigned_to: string | null
          billable: boolean
          blocked_reason: string | null
          buzzer_acknowledged_at: string | null
          buzzer_active: boolean
          category: string
          client_name: string | null
          code: string
          completed_at: string | null
          cost: number
          created_at: string
          created_by: string | null
          deadline: string | null
          description: string
          difficulty: string
          escalation_level: number
          estimated_hours: number
          id: string
          module: string | null
          paused_at: string | null
          priority: string
          progress: number
          promised_at: string | null
          quality_score: number | null
          sla_hours: number
          started_at: string | null
          status: string
          tags: string[]
          timer_running: boolean
          title: string
          total_paused_minutes: number
          updated_at: string
        }
        Insert: {
          accepted_at?: string | null
          actual_minutes?: number
          ai_generated?: boolean
          approval_status?: string
          assigned_to?: string | null
          billable?: boolean
          blocked_reason?: string | null
          buzzer_acknowledged_at?: string | null
          buzzer_active?: boolean
          category?: string
          client_name?: string | null
          code: string
          completed_at?: string | null
          cost?: number
          created_at?: string
          created_by?: string | null
          deadline?: string | null
          description?: string
          difficulty?: string
          escalation_level?: number
          estimated_hours?: number
          id?: string
          module?: string | null
          paused_at?: string | null
          priority?: string
          progress?: number
          promised_at?: string | null
          quality_score?: number | null
          sla_hours?: number
          started_at?: string | null
          status?: string
          tags?: string[]
          timer_running?: boolean
          title: string
          total_paused_minutes?: number
          updated_at?: string
        }
        Update: {
          accepted_at?: string | null
          actual_minutes?: number
          ai_generated?: boolean
          approval_status?: string
          assigned_to?: string | null
          billable?: boolean
          blocked_reason?: string | null
          buzzer_acknowledged_at?: string | null
          buzzer_active?: boolean
          category?: string
          client_name?: string | null
          code?: string
          completed_at?: string | null
          cost?: number
          created_at?: string
          created_by?: string | null
          deadline?: string | null
          description?: string
          difficulty?: string
          escalation_level?: number
          estimated_hours?: number
          id?: string
          module?: string | null
          paused_at?: string | null
          priority?: string
          progress?: number
          promised_at?: string | null
          quality_score?: number | null
          sla_hours?: number
          started_at?: string | null
          status?: string
          tags?: string[]
          timer_running?: boolean
          title?: string
          total_paused_minutes?: number
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_tasks_assigned_to_fkey"
            columns: ["assigned_to"]
            isOneToOne: false
            referencedRelation: "tm_members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tm_tasks_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "tm_members"
            referencedColumns: ["id"]
          },
        ]
      }
      tm_time_logs: {
        Row: {
          action: string
          created_at: string
          ended_at: string | null
          id: string
          member_id: string | null
          note: string | null
          seconds: number
          started_at: string
          task_id: string
          updated_at: string
        }
        Insert: {
          action: string
          created_at?: string
          ended_at?: string | null
          id?: string
          member_id?: string | null
          note?: string | null
          seconds?: number
          started_at?: string
          task_id: string
          updated_at?: string
        }
        Update: {
          action?: string
          created_at?: string
          ended_at?: string | null
          id?: string
          member_id?: string | null
          note?: string | null
          seconds?: number
          started_at?: string
          task_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "tm_time_logs_member_id_fkey"
            columns: ["member_id"]
            isOneToOne: false
            referencedRelation: "tm_members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tm_time_logs_task_id_fkey"
            columns: ["task_id"]
            isOneToOne: false
            referencedRelation: "tm_tasks"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const

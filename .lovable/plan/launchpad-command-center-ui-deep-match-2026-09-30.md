# Launchpad Command Center UI Deep Match

## Goal
Restyle the existing Task Manager to match the selected Launchpad Command Center direction while preserving every current screen, workflow, data source, API call, and business rule.

## Changes
- Replace the current visual tokens with the selected deep navy, blue, indigo, slate, and semantic status palette.
- Rebuild the persistent grouped sidebar with compact navigation, precise active states, badges, collapse behavior, search, and mobile drawer support.
- Refine the slim top utility bar with global task search, notifications, and a direct New Task action.
- Apply the selected indigo-to-blue command banner consistently through the shared screen header used by all 21 screens.
- Tighten shared cards, rows, badges, filters, tables, forms, and dashboard panels for the selected high-density command-center layout.
- Preserve current screen composition where required by existing workflows, while matching the selected spacing, borders, typography, shadows, and interaction quality.

## Technical Details
- Keep all changes in frontend presentation files and semantic design tokens.
- Reuse existing shared Task Manager primitives so the redesign propagates consistently across every screen.
- Keep responsive sidebar and mobile navigation behavior intact.
- Verify the dashboard, inbox, creation flow, another dense operational screen, and mobile layout in the live preview.
- Check build, runtime, console, overflow, and overlap signals after implementation.

## Out of Scope
- No business logic, database, API, seed data, authentication, routes, or additional modules will be changed.

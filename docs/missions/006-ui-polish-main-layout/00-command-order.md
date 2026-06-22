# 00-command-order.md

Mission 006 — UI Polish / Main Menu Layout

Current game state
- Mission 001 is complete: the player can press WORK and earn money.
- Mission 002 is complete: the player can buy promotions.
- Mission 003 is complete: the player can hire workers for passive income.
- Mission 004 is complete: player progress saves and loads.
- Mission 005 is complete: Rebirth / Prestige is working.

Objective
- Improve the game’s UI layout, presentation, button consistency, information display, and user experience without changing the core gameplay systems.

First-version scope
- Improve main screen layout.
- Make money, per-click earnings, passive income, prestige, and rebirth info clearer.
- Improve panel design for Promotions, Hiring, and Rebirth.
- Make all panels closable and consistent.
- Improve button styling and feedback.
- Add simple tutorial/help hints if appropriate.
- Keep the game simple and readable.
- Preserve all existing functionality.

Rules
- Do not edit gameplay scripts.
- Do not edit existing Mission 001, 002, 003, 004, or 005 files.
- Do not edit agent role files.
- Only edit `docs/missions/006-ui-polish-main-layout/00-command-order.md` for this task.
- This file is the single source of mission command for Mission 006.

Acceptance criteria
- `docs/missions/006-ui-polish-main-layout/00-command-order.md` contains the official mission command order.
- The mission scope is clear that UI improvements must preserve current gameplay behavior.
- The Game Design Agent receives a clear, actionable handoff describing the main menu layout, panel behavior, and information display requirements.
- The Roblox Studio Agent receives enough context to specify UI placement, menu structure, and polish targets without changing systems.
- The Coding Agent receives a precise mission scope and relay order.
- The UI should present money, earnings, prestige, and rebirth details clearly and consistently.
- All panels should be consistently styled, closable, and easy to navigate.
- Buttons should have improved styling and feedback but retain current functionality.
- Any new tutorial/help hints should be simple, optional, and not introduce new gameplay mechanics.

Handoff instruction to Game Design Agent
- Deliverables:
	- A concise UI design spec for the main menu layout, including where key information is displayed and how panels are organized.
	- A list of presentation improvements for Money, Per Click, Passive Income, Prestige, and Rebirth information.
	- Recommended layout and close behavior for Promotions, Hiring, and Rebirth panels.
	- Suggested button styling and feedback patterns that remain simple and readable.
	- A short acceptance checklist the Coding and QA Agents can use to validate the UI polish work.

# 00-command-order.md

Mission 003 — Hiring / Autogenerators

Current game state
- Mission 001 is complete: the player can press WORK and earn money.
- Mission 002 is complete: the player can buy promotions to increase money earned per click.
- The UI already has a Hiring button, but it does not do anything yet.

Objective
- Create a Hiring system where the player can spend money to hire workers who generate passive money automatically over time.

First-version scope
- Hiring button opens and closes a Hiring panel.
- The player can buy at least one worker type.
- Workers generate passive money every second.
- The UI shows worker count, cost, and income per second.
- The player cannot buy workers without enough money.
- Money and UI update correctly.

Rules
- Do not edit gameplay scripts.
- Do not edit existing Mission 001 or Mission 002 files.
- Do not edit agent role files.
- Only edit `docs/missions/003-hiring-autogenerators/00-command-order.md` for this task.
- This file is the single source of mission command for Mission 003.

Acceptance criteria
- `docs/missions/003-hiring-autogenerators/00-command-order.md` contains the official mission command order.
- The Game Design Agent receives a clear, actionable handoff describing Hiring UI flow, worker behavior, and expected UX for buying workers.
- The Economy Agent receives the mission context needed to propose costs and passive income values.
- The Roblox Studio Agent receives the mission context needed to describe UI placement and implementation constraints.
- The Coding Agent receives a precise mission scope and relay order.
- The implementation should allow a player to open the Hiring panel, purchase workers when affordable, see worker count and income per second, and earn passive money over time.

Handoff instruction to Game Design Agent
- Deliverables:
	- A concise gameplay spec describing how the Hiring panel opens, how the purchase flow works, and what feedback the player sees when hiring or when funds are insufficient.
	- A design for at least one worker type, including worker name, base cost, income per second, and count display.
	- A list of required UI hooks/events for the Coding Agent (e.g., `RequestOpenHiringPanel`, `RequestHireWorker`, `UpdateWorkerUI`, `WorkerHired`, `HiringPanelToggled`).
	- A short acceptance checklist for the Coding and QA Agents: panel open/close behavior, purchase validation, worker count updates, income display, and passive income generation.

Required agent relay order
1. Game Design Agent
2. Economy Agent
3. Roblox Studio Agent
4. Coding Agent
5. QA Agent
6. Commander field test

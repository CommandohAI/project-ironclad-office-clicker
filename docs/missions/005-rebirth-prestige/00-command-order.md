# 00-command-order.md

Mission 005 — Rebirth / Prestige System

Current game state
- Mission 001 is complete: the player can press WORK and earn money.
- Mission 002 is complete: the player can buy promotions to increase money earned per click.
- Mission 003 is complete: the player can hire workers who generate passive income.
- Mission 004 is complete: player progress saves and loads correctly.

Objective
- Create a Rebirth / Prestige system where the player can reset current run progress in exchange for permanent Prestige Points or Corporate Influence.

First-version scope
- Add a Rebirth button or panel.
- The player can rebirth only when they meet a money requirement.
- Rebirth resets Money, PromotionLevel, WorkPower, and WorkerCount.
- Rebirth grants a permanent Prestige/Corporate Influence value.
- Prestige provides a simple permanent bonus, such as increased earnings.
- Prestige data must save and load.
- UI shows current prestige amount and rebirth requirement.
- The player cannot rebirth before meeting the requirement.

Rules
- Do not edit gameplay scripts.
- Do not edit existing Mission 001, 002, 003, or 004 files.
- Do not edit agent role files.
- Only edit `docs/missions/005-rebirth-prestige/00-command-order.md` for this task.
- This file is the single source of mission command for Mission 005.

Acceptance criteria
- `docs/missions/005-rebirth-prestige/00-command-order.md` contains the official mission command order.
- The Game Design Agent receives a clear, actionable handoff describing rebirth eligibility, reset behavior, and prestige bonus.
- The Economy Agent receives the mission context needed to define rebirth cost, prestige reward, and bonus scaling.
- The Roblox Studio Agent receives the mission context needed to describe UI placement and testing for the Rebirth system.
- The Coding Agent receives a precise mission scope and relay order.
- The implementation should allow the player to open a Rebirth interface, rebirth when eligible, reset run progression, gain permanent prestige, and see prestige saved across sessions.

Handoff instruction to Game Design Agent
- Deliverables:
	- A concise gameplay spec describing the Rebirth flow, eligibility requirement, reset behavior, and prestige bonus effect.
	- A UI design for the Rebirth interface: placement of the Rebirth button/panel, current prestige amount, required money, and confirmation flow.
	- A list of required hooks/events for the Coding Agent, such as `RequestRebirth`, `RebirthPerformed`, `GetPlayerPrestigeData`, and the exact data needed for each.
	- A short acceptance checklist the Coding and QA Agents can use to validate design compliance.

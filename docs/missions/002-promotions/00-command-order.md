Mission 002 — Promotions System

Current game state
- Mission 001 is complete: the player can press the WORK button and earn money.
- The UI includes a non-functional Promotions button.

Objective
- Implement a Promotions system enabling players to spend in-game money to increase the money earned per WORK click.

Required agent relay order
1. Commander: confirms mission goal and priority.
2. ChatGPT (Operations Scribe): issues this official command order (this file).
3. Game Design Agent: produce a gameplay specification describing promotion tiers, UI flows, feedback, and progression pacing.
4. Economy Agent: produce upgrade costs, incremental multipliers, and balance tables for initial and scaling progression.
5. Roblox Studio Agent: produce UI/Studio implementation notes, asset placement, and testing checklist for the Promotions UI.
6. Coding Agent: implement server-authoritative Promotions functionality and client UI hooks according to design and economy specs.
7. QA Agent: review the implementation against acceptance criteria and report issues.
8. Commander: final playtest and sign-off in Roblox Studio.

Rules
- Do not edit gameplay scripts as part of this document.
- Do not edit agent role files, `default.project.json`, or `aftman.toml`.
- This file is the single source of mission command for Mission 002; agents must follow the relay order above.
- All economy changes must be proposed by the Economy Agent and implemented by the Coding Agent on the server side.

Acceptance criteria
- `00-command-order.md` is written and placed at `docs/missions/002-promotions/00-command-order.md`.
- The Game Design Agent has a clear, actionable handoff describing promotion tiers, UI flows, and expected player progression.
- The Economy Agent provides a complete cost/multiplier table to be consumed by the Coding Agent.
- The Roblox Studio Agent provides UI placement and testing steps.
- The Coding Agent implements the Promotions system without modifying unrelated gameplay files.
- QA verifies: pressing WORK yields increased earnings after purchasing promotions; promotions spend money as expected; UI shows current multiplier, cost, and purchase confirmation.

Handoff instruction to Game Design Agent
- Deliverables:
	- A short gameplay spec (1–2 pages) describing promotion mechanics, tier names, visual feedback when purchased, and UX for purchase flow (confirm/cancel, insufficient funds handling).
	- Wireframe/mockup of the Promotions UI: placement, button behavior, and labels for cost, owned level, and current earnings multiplier.
	- A list of required hooks/events for the Coding Agent (e.g., `RequestPurchasePromotion`, `PromotionPurchased`, `GetPlayerPromotionLevel`) and the exact data each hook needs (no implementation details).
	- Constraints from the Economy Agent: attach or reference the cost/multiplier table and any pacing notes.
	- A short acceptance checklist the Coding and QA Agents can use to validate design compliance.

Roblox Studio test steps (for Commander / QA)
1. Open the place in Roblox Studio and run a local server + client test.
2. Confirm the Promotions button is visible in the Main UI.
3. With a fresh player, press WORK to accumulate a small amount of money.
4. Open Promotions UI and verify costs, current multiplier, and purchase flow appear per design.
5. Attempt to purchase an affordable promotion; confirm player money decreases by the correct cost and the WORK reward increases accordingly.
6. Attempt to purchase with insufficient funds; confirm a clear error/disabled state prevents purchase.
7. Repeat purchases to validate scaling and persistence behavior (as implemented by the Coding Agent).

Notes
- This command order contains no code — it is strictly the mission directive for agents to follow.

# Command Order

Pending mission output.

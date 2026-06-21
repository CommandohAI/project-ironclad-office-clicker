# Project IRONCLAD — Agent Instructions

You are working on Project IRONCLAD, a Roblox monetisable simulator game.

Game:
Office Clicker / Corporate Climb Simulator

Commander:
The user makes final decisions.

Second-in-command:
ChatGPT manages planning, task breakdown, AI agent coordination, review, and debugging.

Primary goal:
Build a simple, polished, monetisable Roblox clicker/simulator with:
- Work button
- Money system
- Promotions
- Hiring/autogenerators
- Data saving
- Gamepasses
- Developer products
- Clean UI
- Strong retention loop

Development rules:
- Work mission by mission.
- Do not rewrite the whole project unless ordered.
- Keep code modular.
- Use Luau.
- Server-authoritative economy.
- Never trust client-side money changes.
- Put shared config in ReplicatedStorage/IRONCLAD/Modules/Config.
- Put shared helpers in ReplicatedStorage/IRONCLAD/Modules/Shared.
- Put server logic in ServerScriptService/IRONCLAD/Services.
- Put UI client logic in StarterGui/MainUI/UIControllers.
- Every mission must include test steps.
- Prioritise working gameplay over fancy polish.

Current phase:
MISSION 001 — Core Clicker Loop.

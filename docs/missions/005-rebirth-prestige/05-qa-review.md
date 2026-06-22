# 05-qa-review.md

QA result: PASS

Files reviewed
- src/ReplicatedStorage/IRONCLAD/Modules/Shared/SignalNames.lua
- src/ReplicatedStorage/IRONCLAD/Modules/Config/RebirthConfig.lua
- src/ServerScriptService/IRONCLAD/Main.server.lua
- src/ServerScriptService/IRONCLAD/Services/PlayerDataService.lua
- src/ServerScriptService/IRONCLAD/Services/RebirthService.lua
- src/ServerScriptService/IRONCLAD/Services/WorkService.lua
- src/ServerScriptService/IRONCLAD/Services/PromotionService.lua
- src/ServerScriptService/IRONCLAD/Services/HiringService.lua
- src/StarterGui/MainUI/Main.client.lua
- src/StarterGui/MainUI/UIControllers/RebirthController.lua

Issues found
- No mission-critical bugs were found in the reviewed implementation.
- `RebirthPerformed` is created and fired by `RebirthService` but is not currently listened to by the client. This is not a functional failure for the current mission scope.

Required fixes, if any
- None required to meet Mission 005 acceptance criteria.

Security notes
- Rebirth validation is performed server-side in `RebirthService`.
- The client does not directly modify `Money`, `WorkPower`, `PromotionLevel`, `WorkerCount`, `Prestige`, or `RebirthCount`.
- The client only sends rebirth requests and receives validated state updates from the server.

Saving/data safety notes
- `PlayerDataService` now includes `Prestige` and `RebirthCount` in default data, load sanitization, and save payloads.
- Loaded data is validated with `tonumber(...)` and defaults are applied when values are missing or invalid.
- Shutdown saving now writes the new fields, so rebirth data persists across sessions.

Roblox Studio test checklist for Commander
1. Open the game in Roblox Studio and enter Play mode.
2. Confirm the Rebirth button appears in the main UI.
3. Open the Rebirth panel and verify `Prestige: 0`, the rebirth requirement, and bonus description are visible.
4. Earn money until the Rebirth button becomes enabled.
5. Click Rebirth and confirm money resets to 0.
6. Verify PromotionLevel and WorkPower return to base values and the Rebirth panel updates prestige.
7. Confirm WorkerCount resets to 0 in the hiring panel.
8. Verify Prestige increases by 1 and `RebirthCount` increments in saved data if possible.
9. Confirm WORK still earns money after rebirth.
10. Confirm promotions and hiring still function after rebirth.
11. Confirm passive income still works after rebirth.
12. Close and reopen the game to verify `Prestige` persists and the bonus remains applied.

Final recommendation: test now
- Implementation matches the mission documents and acceptance criteria.
- No code changes are required before commander testing.

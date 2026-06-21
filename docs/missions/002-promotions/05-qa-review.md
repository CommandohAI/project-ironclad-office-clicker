QA Review — Mission 002: Promotions

1. QA result
- PASS

2. Files reviewed
- `src/ServerScriptService/IRONCLAD/Services/PlayerDataService.lua`
- `src/ServerScriptService/IRONCLAD/Services/WorkService.lua`
- `src/ServerScriptService/IRONCLAD/Services/PromotionService.lua`
- `src/ServerScriptService/IRONCLAD/Main.server.lua`
- `src/ReplicatedStorage/IRONCLAD/Modules/Shared/SignalNames.lua`
- `src/ReplicatedStorage/IRONCLAD/Modules/Config/PromotionsConfig.lua`
- `src/StarterGui/MainUI/Main.client.lua`
- `src/StarterGui/MainUI/UIControllers/WorkController.lua`
- `src/StarterGui/MainUI/UIControllers/PromotionsController.lua`
- `src/ReplicatedStorage/IRONCLAD/Modules/Shared/NumberFormatter.lua`
- `docs/missions/002-promotions/*` (mission docs)

3. Issues found
- Previous issues (affordability label visibility and disabled-button visuals) were present and have been fixed by the Coding Agent.
- Field test issues observed by the Commander (modal close and currency prefix) were addressed by the Coding Agent:
  - The `Promotions` button now toggles the modal open/closed.
  - A `PromotionsClose` (X) button was added to the modal to explicitly close it.
  - Currency formatting now uses `£` via `NumberFormatter.FormatMoney` and placeholder UI strings were updated.

4. Required fixes
- No further fixes required for Mission 002. The Coding Agent implemented the required UI corrections.

5. Security notes
- Server-authoritative checks are implemented: `PromotionService` validates funds server-side using `PlayerDataService.TrySpendMoney` before applying promotion effects. The client cannot directly change `Money` or `WorkPower` — these are only updated server-side and communicated to the client via remotes.

6. Roblox Studio test checklist for Commander
1. Start > Play (local server + client).
2. Confirm `Promotions` button opens the modal and pressing it again closes the modal (toggle behavior).
3. Confirm `PromotionsClose` (X) appears in the modal and closes it when clicked.
4. Press `WORK` until you have ≥ £10.
5. Open Promotions modal and verify `Money`, `Per-click`, `Level`, and `Cost` display values prefixed with `£` (e.g., `£10`).
6. Purchase when affordable: confirm money decreases and `Per-click` increases immediately.
7. Attempt purchase when unaffordable: confirm `Purchase` is disabled and `Insufficient funds` message appears.
8. Press `WORK` after purchase to confirm earnings use the new per-click value.
9. Watch Studio Output for errors — there should be none.

7. Final recommendation
- Run the Roblox Studio test checklist now. The mission is ready for re-test by the Commander and QA.


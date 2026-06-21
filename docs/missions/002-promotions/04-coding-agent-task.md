Coding Agent Implementation — Mission 002: Promotions

1. Summary of what was implemented
- Server-side `PromotionService` to handle purchase requests and provide promotion data.
- `PromotionsConfig` with economy constants (base cost, scaling, multiplier per level).
- `PlayerDataService` extended to store `PromotionLevel` and provide a safe `TrySpendMoney` method and `SetWorkPower`.
- Client-side `PromotionsController` to display and manage the Promotions modal and call server remotes.
- UI additions in `Main.client.lua` to create `PromotionsModal` and wire the Promotions controller.
- `SignalNames` updated with promotion remote names.
- `Main.server.lua` updated to start `PromotionService`.

2. Files changed
- Modified: `src/ReplicatedStorage/IRONCLAD/Modules/Shared/SignalNames.lua`
- Modified: `src/ServerScriptService/IRONCLAD/Services/PlayerDataService.lua`
- Modified: `src/ServerScriptService/IRONCLAD/Main.server.lua`
- Modified: `src/StarterGui/MainUI/Main.client.lua`

3. New files created
- Added: `src/ReplicatedStorage/IRONCLAD/Modules/Config/PromotionsConfig.lua`
- Added: `src/ServerScriptService/IRONCLAD/Services/PromotionService.lua`
- Added: `src/StarterGui/MainUI/UIControllers/PromotionsController.lua`

4. Roblox Studio test steps
1. Open the place in Roblox Studio and run a local server + client test (Start > Play).
2. Press `WORK` until you have at least £10.
3. Click the `Promotions` button to open the modal.
4. Verify the modal shows `Money`, `Per-click`, `Level`, `Cost` and a `Purchase` button.
5. Click `Purchase` and verify money decreases by the cost and `Per-click` increases accordingly.
6. Attempt to purchase without sufficient funds and verify the `Insufficient funds` message appears and purchase is rejected.
7. Confirm WORK uses the new per-click value by pressing `WORK` and observing `Money` updates.

5. Known limitations / follow-up notes
- Persistence: `PlayerDataService` currently stores data in-memory only. If persistent saves are desired, integrate with existing saving system.
- Single promotion track: this implements one linear promotion track. Extending to multiple promotions or tiers will require updates to the data structures and UI.
- Currency rounding: server stores money as numbers; if you need integer pennies, convert storage accordingly.
- Confirmation dialog: an optional confirmation step is not implemented (UI directly sends server request). Add a confirmation dialog in `PromotionsController` if desired.

# Coding Agent Task

Pending mission output.

Field Test Correction Notes
- Added a visible Close/X button to the `PromotionsModal` and made the `Promotions` button toggle the modal open/closed to fix the modal-not-closeable issue discovered during Commander testing.
- Replaced currency prefix `L` with `£` in `NumberFormatter.FormatMoney` and updated initial UI placeholder strings to use `£`, ensuring currency displays correctly on load and during updates.

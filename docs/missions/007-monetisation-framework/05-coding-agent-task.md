# 05-coding-agent-task.md

## Correction Notes
- Fixed missing `ShopController.Init(...)` call in `src/StarterGui/MainUI/Main.client.lua`.
- Confirmed the store UI is now wired to the existing store button and panel.
- No gameplay systems outside monetisation were changed.

## Field Test Correction Notes
- Updated placeholder products in `src/ReplicatedStorage/IRONCLAD/Modules/Config/MonetisationConfig.lua` to include an explicit `Available = false` flag and `ProductId = 0`.
- Blocked `MarketplaceService:PromptProductPurchase` in `src/ServerScriptService/IRONCLAD/Services/MonetisationService.lua` when a product is unavailable or placeholder.
- Added the `available` flag to store product data returned by the server.
- Updated `src/StarterGui/MainUI/UIControllers/ShopController.lua` so unavailable products show `Coming Soon`, greyed-out buttons, and an `Unavailable` label.
- Tightened store tile layout and added scroll frame padding in `src/StarterGui/MainUI/Main.client.lua`.

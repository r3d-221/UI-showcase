local ServerScriptService = game:GetService("ServerScriptService")

local PlayerService = require(ServerScriptService.Server.PlayerService)
local ItemService = require(ServerScriptService.Server.ItemService)

PlayerService.onStart()
ItemService.onStart()

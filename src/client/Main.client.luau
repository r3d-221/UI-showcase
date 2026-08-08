local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

local player = Players.LocalPlayer
local PlayerScripts = player:WaitForChild("PlayerScripts")

local Inventory = require(StarterPlayer.StarterPlayerScripts.Client.Inventory)
local HUD = require(PlayerScripts.Client.HUD)

HUD.onStart()
Inventory.onStart()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local PlayerScripts = player:WaitForChild("PlayerScripts")

local screen = PlayerGui:WaitForChild("HUD")

local Util = require(ReplicatedStorage.Shared.Util)
local UIManager = require(PlayerScripts.Client.UIManager)

local HUD = {}
local map = Util.mapUI(screen)

local function setUpButtons()
	map.inventory_button_frame.button.MouseButton1Click:Connect(function()
		local isOpen = UIManager.toggle("inventory")
		if isOpen then
			UIManager.closeAll()
			UIManager.openExclusive("inventory")
		end
	end)
end

function HUD.onStart()
	setUpButtons()
end

return HUD

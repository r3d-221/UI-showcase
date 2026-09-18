local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local PlayerScripts = player:WaitForChild("PlayerScripts")

local Client = PlayerScripts.Client

local PlayerManager = require(Client.PlayerManager)

local screen = PlayerGui:WaitForChild("HUD")

local Inventory = require(StarterPlayer.StarterPlayerScripts.Client.Inventory)
local Util = require(ReplicatedStorage.Shared.Util)
local UIManager = require(PlayerScripts.Client.UIManager)

local HUD = {}
local map = Util.mapUI(screen)

type buttons = "inventory" | nil

local currentButton: buttons = nil

local function setActive()
	local passive = Color3.fromHex("748182")
	local active = Color3.fromHex("00F0FF")

	if currentButton == nil then
		map.inventory.icon.ImageColor3 = passive
		-- add the rest of the buttons
		return
	end

	if currentButton == "inventory" then
		map.inventory.icon.ImageColor3 = active
	else
		map.inventory.icon.ImageColor3 = passive
	end
end

local function setUpButtons()
	map.inventory.button.MouseButton1Click:Connect(function()
		local isOpen = UIManager.toggle("inventory")
		if isOpen then
			UIManager.closeAll()
			UIManager.openExclusive("inventory")
			currentButton = "inventory"
			Inventory.closeInfo()

			local data = PlayerManager.getData()
			if data then
				Inventory.updateSlots(data.items)
			end

			setActive()
		else
			currentButton = nil
			setActive()
			Inventory.clearSlots()
			Inventory.clearStats()
			Inventory.closeItemInfo()
		end
	end)
end

function HUD.onStart()
	setActive()
	setUpButtons()
end

return HUD

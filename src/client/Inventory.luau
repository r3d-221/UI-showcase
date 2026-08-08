local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local PlayerScripts = player:WaitForChild("PlayerScripts")

local screen = PlayerGui:WaitForChild("Screens")

local Types = require(ReplicatedStorage.Shared.Types)
local Util = require(ReplicatedStorage.Shared.Util)
local UIManager = require(PlayerScripts.Client.UIManager)

local slotTemplate = ReplicatedStorage.templates.slot_template

type Item = Types.Item

local Inventory = {}
local map = Util.mapUI(screen)

local function setUpButtons()
	map.close.button.MouseButton1Click:Connect(function()
		UIManager.closeAll()
	end)
end

function Inventory.onStart()
	-- print(map)
	setUpButtons()
end

function Inventory.clearSlots()
	for _, child in map.list:GetChildren() do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
end

function Inventory.updateSlots(data: Item)
	Inventory.clearSlots()

	-- re populate the list with the new data
end

function Inventory.createSlot()
	local new = slotTemplate:Clone()

	new.Parent = map.list
	new.Name = "slot"
end

return Inventory

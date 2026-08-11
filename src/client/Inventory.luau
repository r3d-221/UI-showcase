local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local PlayerScripts = player:WaitForChild("PlayerScripts")

local screen = PlayerGui:WaitForChild("Screens")

local ItemData = require(ReplicatedStorage.Shared.ItemData)
local Types = require(ReplicatedStorage.Shared.Types)
local Util = require(ReplicatedStorage.Shared.Util)
local UIManager = require(PlayerScripts.Client.UIManager)

local slotTemplate = ReplicatedStorage.templates.slot_template
local statTemplate = ReplicatedStorage.templates.stat_template

type Item = Types.Item
type StatsList = Types.StatsList
type Stat = Types.Stat

type Tab = "weapons" | "armors" | "materials"
type InfoTab = "stats" | "passives" | "description"

local currentTab: Tab = "weapons"
local currentItem: Item? = nil
local currentSlotUI: Frame? = nil

local Inventory = {}
local map = Util.mapUI(screen)

local function switchInfoTab(tabName: InfoTab)
	map.stats_info.Visible = (tabName == "stats")
	map.passives_info.Visible = (tabName == "passives")
	map.description_info.Visible = (tabName == "description")

	map.stats.selected.Visible = (tabName == "stats")
	map.passives.selected.Visible = (tabName == "passives")
	map.description.selected.Visible = (tabName == "description")

	if tabName == "stats" then
		Inventory.updateStats()
	end
end

local function setUpButtons()
	map.close.button.MouseButton1Click:Connect(function()
		UIManager.closeAll()
		Inventory.clearSlots()
		Inventory.clearStats()
		Inventory.closeItemInfo()
	end)

	map.stats.button.MouseButton1Click:Connect(function()
		if currentTab == "materials" then
			return
		end
		switchInfoTab("stats")
	end)

	map.passives.button.MouseButton1Click:Connect(function()
		if currentTab == "materials" then
			return
		end
		switchInfoTab("passives")
	end)

	map.description.button.MouseButton1Click:Connect(function()
		switchInfoTab("description")
	end)
end

function createSlot(item: Item, parent: Instance?)
	local itemData = ItemData[currentTab][item.id]
	if not itemData then
		warn("[Inventory] No data found for " .. item.id .. " in " .. currentTab .. " table")
		return
	end

	local new = slotTemplate:Clone()

	new.Parent = parent or map.list
	new.Name = "slot"

	local frame = new:FindFirstChild("background")
	frame.Image = ItemData[itemData.rarity]

	local selectedFrame = new:FindFirstChild("selected")
	selectedFrame.Visible = false

	new:SetAttribute("uid", item.uid)

	local button = new:FindFirstChild("button")
	button.MouseButton1Click:Connect(function()
		if currentSlotUI then
			local currentSelectedFrame = currentSlotUI:FindFirstChild("selected")
			currentSelectedFrame.Visible = false

			currentSlotUI = new
			currentSelectedFrame = currentSlotUI:FindFirstChild("selected")
			currentSelectedFrame.Visible = true
		end

		currentItem = item
		Inventory.updateInfo()
	end)
end

function createStat(name: string, roll: Types.Roll)
	local new = statTemplate:Clone()

	new.Parent = map.stats_info
	new.Name = name

	local statAmount = new:FindFirstChild("stat_amount")
	local statRank = new:FindFirstChild("stat_rank")
	local statName = new:FindFirstChild("stat_name")

	statAmount.Text = roll.value
	statRank.Text = roll.rank
	statName.Text = name .. ":"
end

function toggleInfo(bool: boolean)
	for _, child in map.info:GetChildren() do
		child.Visible = bool
	end

	if not bool then
		for _, child in map.item:GetChildren() do
			if child:IsA("Frame") or child:IsA("ImageLabel") then
				child:Destroy()
			end
		end
	end
end

function Inventory.onStart()
	print(map)
	setUpButtons()
end

function Inventory.clearSlots()
	currentSlotUI = nil
	for _, child in map.list:GetChildren() do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
end

function Inventory.clearStats()
	for _, child in map.stats_info:GetChildren() do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
end

function Inventory.closeItemInfo()
	if currentSlotUI then
		local currentSelectedFrame = currentSlotUI:FindFirstChild("selected")
		currentSelectedFrame.Visible = false
	end

	currentSlotUI = nil
	currentItem = nil

	for _, child in map.item_info:GetChildren() do
		child.Visible = false
	end
end

function Inventory.updateSlots(data: { Item })
	Inventory.clearSlots()

	for _, item in data do
		createSlot(item)
	end
end

function Inventory.updateStats()
	if currentItem == nil then
		warn("[Inventory] No item slot was selected.")
		return
	end

	Inventory.clearStats()

	local item = currentItem :: Types.Weapon | Types.Armor
	local stats = item.stats

	for stat, roll in pairs(stats) do
		createStat(stat, roll)
	end
end

function Inventory.updateInfo()
	local item = currentItem
	if item == nil then
		warn("[Inventory] No item slot was selected.")
		return
	end

	local itemData = ItemData[currentTab][item.id]
	if not itemData then
		warn("[Inventory] No data found for " .. item.id .. " in " .. currentTab .. " table")
		return
	end

	toggleInfo(false)
	createSlot(item, map.item)

	local slot = map.item:FindFirstChild("slot")
	if slot then
		local button = slot:FindFirstChild("button")
		if button then
			button:Destroy()
		end

		local selectedFrame = slot:FindFirstChild("selected")
		if selectedFrame then
			selectedFrame:Destroy()
		end
	end

	map.item.Visible = true

	local hasStats = (currentTab ~= "materials")

	map.item_info.Visible = true
	map.info_tabs.Visible = true

	map.stats.Visible = hasStats
	map.passives.Visible = hasStats
	map.description.Visible = true

	local title = map.title
	title.Visible = true
	title.text.Text = itemData.name
	title.background.ImageColor3 = itemData.rarityColors[itemData.rarity]

	if not hasStats then
		switchInfoTab("description")
	else
		switchInfoTab("stats")
	end
end

return Inventory

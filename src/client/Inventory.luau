--!strict

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Dependencies
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local PlayerScripts = player:WaitForChild("PlayerScripts")

local Client = PlayerScripts:WaitForChild("Client")
local PlayerManager = require(Client.PlayerManager)
local UIManager = require(Client.UIManager)

local Shared = ReplicatedStorage:WaitForChild("Shared")
local ItemData = require(Shared.ItemData)
local Types = require(Shared.Types)
local Util = require(Shared.Util)

-- Templates
local templates = ReplicatedStorage:WaitForChild("templates")
local slotTemplate = templates.slot_template
local statTemplate = templates.stat_template

-- Types
type Item = Types.Item
type Tab = "weapons" | "armors" | "materials"
type InfoTab = "stats" | "passives" | "description"

-- Constants
local TAB_KEYS: { Tab } = { "weapons", "armors", "materials" }
local INFO_TAB_KEYS: { InfoTab } = { "stats", "passives", "description" }

-----------------------------------
-- Module definition & state
-----------------------------------
local Inventory = {}

local screen = PlayerGui:WaitForChild("Screens")
local map = Util.mapUI(screen)

local currentTab: Tab = "weapons"
local currentItem: Item? = nil
local currentSlotUI: Frame? = nil
local dataConnection: (() -> ())? = nil

-----------------------------------
-- Helper functions
-----------------------------------

local function setSelectedSlot(newSlot: Frame?)
	if currentSlotUI then
		local prev = currentSlotUI:FindFirstChild("selected") :: ImageLabel?
		if prev then
			prev.Visible = false
		end
	end

	currentSlotUI = newSlot

	if currentSlotUI then
		local new = currentSlotUI:FindFirstChild("selected") :: ImageLabel?
		if new then
			new.Visible = true
		end
	end
end

local function switchInfoTab(tabName: InfoTab)
	for _, key in INFO_TAB_KEYS do
		local isTarget = (key == tabName)
		local container = map[key .. "_info"]
		local tab = map[key]

		if container then
			container.Visible = isTarget
		end
		if tab and tab:FindFirstChild("selected") then
			tab.selected.Visible = isTarget
		end
	end

	if tabName == "stats" then
		Inventory.updateStats()
	end
end

local function switchTab(newTab: Tab)
	currentTab = newTab

	for _, key in TAB_KEYS do
		local tab = map[key]
		if tab and tab:FindFirstChild("selected") then
			tab.selected.Visible = (key == currentTab)
		end
	end

	Inventory.closeInfo()
	Inventory.updateCurrentTab()
end

local function createStat(name: string, rank: string, text: string)
	local statFrame = statTemplate:Clone()
	statFrame.Name = name

	local statAmount = statFrame:FindFirstChild("stat_amount") :: TextLabel?
	local statRank = statFrame:FindFirstChild("stat_rank") :: TextLabel?
	local statName = statFrame:FindFirstChild("stat_name") :: TextLabel?

	if statAmount then
		statAmount.Text = text
	end
	if statRank then
		statRank.Text = rank
	end
	if statName then
		statName.Text = name .. ":"
	end

	statFrame.Parent = map.stats_info
end

local function createSlot(item: Item, parent: Instance?): Frame?
	local category = ItemData[currentTab]
	local itemData = category and category[item.id]
	if not itemData then
		warn(string.format("[Inventory] Missing data for '%s' in tab '%s'", item.id, currentTab))
		return nil
	end

	local slot = slotTemplate:Clone()
	slot.Name = "slot"
	slot:SetAttribute("uid", item.uid)

	local background = slot:FindFirstChild("background") :: ImageLabel?
	if background and ItemData.itemFrames then
		background.Image = ItemData.itemFrames[itemData.rarity]
	end

	local selectedFrame = slot:FindFirstChild("selected") :: Frame?
	if selectedFrame then
		selectedFrame.Visible = false
	end

	local button = slot:FindFirstChild("button") :: TextButton?
	if button then
		button.MouseButton1Click:Connect(function()
			setSelectedSlot(slot)
			currentItem = item
			Inventory.updateInfo()
		end)
	end

	slot.Parent = parent or map.list
	return slot
end

local function setUpButtons()
	map.close.button.MouseButton1Click:Connect(function()
		UIManager.closeAll()
		Inventory.clearSlots()
		Inventory.clearStats()
		Inventory.closeInfo()
	end)

	for _, name in TAB_KEYS do
		local tab = map[name]
		if tab and tab:FindFirstChild("button") then
			tab.button.MouseButton1Click:Connect(function()
				switchTab(name :: Tab)
			end)
		end
	end

	for _, name in INFO_TAB_KEYS do
		local info = map[name]
		if info and info:FindFirstChild("button") then
			info.button.MouseButton1Click:Connect(function()
				if name ~= "description" and currentTab == "materials" then
					-- not set up
					return
				end
				switchInfoTab(name :: InfoTab)
			end)
		end
	end
end

-----------------------------------
-- Public functions
-----------------------------------

function Inventory.clearSlots()
	setSelectedSlot(nil)
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

function Inventory.toggleInfo(isVisible: boolean)
	for _, child in map.info:GetChildren() do
		child.Visible = isVisible
	end

	if not isVisible then
		for _, child in map.item:GetChildren() do
			if child:IsA("Frame") or child:IsA("ImageLabel") then
				child:Destroy()
			end
		end
	end
end

function Inventory.closeInfo()
	setSelectedSlot(nil)
	currentItem = nil

	for _, child in map.info:GetChildren() do
		child.Visible = false
	end
end

function Inventory.updateSlots(items)
	Inventory.clearSlots()

	local tabItems = items and items[currentTab]
	if not tabItems then
		return
	end

	for _, item in tabItems do
		createSlot(item)
	end
end

function Inventory.updateCurrentTab()
	local data = PlayerManager.getData()
	if data and data.items then
		Inventory.updateSlots(data.items)
	end
end

function Inventory.updateStats()
	local item = currentItem
	if not item or not item.stats then
		return
	end

	Inventory.clearStats()

	local itemStats = item.stats :: { [string]: Types.Roll }

	for _, name in ipairs(ItemData.statOrder) do
		local stat = itemStats[name]

		if stat then
			local isPercent = ItemData.statTypes[name] == "percent"
			local displayValue = if isPercent
				then string.format("%.1f%%", stat.value * 100)
				else tostring(math.round(stat.value))

			createStat(ItemData.statNames[name], stat.rank, displayValue)
		end
	end
end

function Inventory.updateInfo()
	local item = currentItem
	if not item then
		return
	end

	local category = ItemData[currentTab]
	local itemData = category and category[item.id]
	if not itemData then
		return
	end

	Inventory.toggleInfo(false)

	local slot = createSlot(item, map.item)
	if slot then
		local button = slot:FindFirstChild("button")
		if button then
			button:Destroy()
		end

		local selected = slot:FindFirstChild("selected")
		if selected then
			selected:Destroy()
		end
	end

	map.item.Visible = true

	local hasStats = (currentTab ~= "materials")
	map.item_info.Visible = true
	map.info_tabs.Visible = true
	map.stats.Visible = hasStats
	map.passives.Visible = hasStats
	map.description.Visible = true

	map.title.Visible = true
	map.title.text.Text = itemData.name
	map.title.background.ImageColor3 = ItemData.rarityColors[itemData.rarity]

	switchInfoTab(if hasStats then "stats" else "description")
end

function Inventory.onStart()
	setUpButtons()

	dataConnection = PlayerManager.onChange(function(data)
		if data and data.items then
			Inventory.updateSlots(data.items)
		end
	end)

	Inventory.updateCurrentTab()
end

function Inventory.onDestroy()
	if dataConnection then
		dataConnection()
		dataConnection = nil
	end
	Inventory.clearSlots()
	Inventory.clearStats()
end

return Inventory

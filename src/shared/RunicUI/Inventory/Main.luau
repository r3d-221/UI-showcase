local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local Filter = require(ReplicatedStorage.Shared.RunicUI.Inventory.Filter)
local Grid = require(ReplicatedStorage.Shared.RunicUI.Inventory.Grid)
local ItemInfo = require(ReplicatedStorage.Shared.RunicUI.Inventory.ItemInfo)
local Search = require(ReplicatedStorage.Shared.RunicUI.Inventory.Search)
local Tabs = require(ReplicatedStorage.Shared.RunicUI.Inventory.Tabs)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)
local Utils = require(ReplicatedStorage.Shared.RunicUI.Utils)

local function Main()
	local children = {
		constraint = React.createElement("UIAspectRatioConstraint"),
		search = React.createElement(Search),
		grid = React.createElement(Grid),
		info = React.createElement(ItemInfo),
		filter = React.createElement(Filter),
		tabs = React.createElement(Tabs),
		close = Utils.close({
			frameSizeX = 0.06,
			frameSizeY = 0.08,
			framePosX = 0.99,
			framePosY = 0,
		}),
		background = Image({
			image = UIData.Images.background,
			imageColor = UIData.Colors.background,
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromOffset(960, 645),
		Position = UDim2.fromOffset(479, 216),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
	}, children)
end

return Main

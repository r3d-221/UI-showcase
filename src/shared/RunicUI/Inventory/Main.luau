local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local Grid = require(ReplicatedStorage.Shared.RunicUI.Inventory.Grid)
local ItemInfo = require(ReplicatedStorage.Shared.RunicUI.Inventory.ItemInfo)
local Search = require(ReplicatedStorage.Shared.RunicUI.Inventory.Search)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function Main()
	local children = {
		search = React.createElement(Search),
		grid = React.createElement(Grid),
		info = React.createElement(ItemInfo),
		background = Image({
			image = UIData.Images.background,
			imageColor = UIData.Colors.background,
			zIndex = 0,
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(0.5, 0.55),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
	}, children)
end

return Main

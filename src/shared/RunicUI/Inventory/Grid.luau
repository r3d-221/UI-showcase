local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local ItemGrid = require(ReplicatedStorage.Shared.RunicUI.Inventory.ItemGrid)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function Grid()
	local children = {
		itemGrid = ItemGrid(),
		background = Image({
			image = UIData.Images.itemGrid,
			imageColor = UIData.Colors.darkerBackground,
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(0.65, 0.85),
		Position = UDim2.fromScale(0.345, 0.56),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
	}, children)
end

return Grid

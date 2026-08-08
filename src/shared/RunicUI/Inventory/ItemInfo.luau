local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Title = require(ReplicatedStorage.Shared.RunicUI.Inventory.Title)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function ItemInfo()
	local children = {
		title = React.createElement(Title),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(0.3, 0.85),
		Position = UDim2.fromScale(0.83, 0.56),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UIData.Colors.darkerBackground,
	}, children)
end

return ItemInfo

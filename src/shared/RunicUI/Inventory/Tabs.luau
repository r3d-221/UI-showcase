local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Tab = require(ReplicatedStorage.Shared.RunicUI.Inventory.Tab)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function Tabs()
	local children = {
		layout = React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0.03, 1),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		weaponsTab = Tab({
			frameSizeX = 0.4,
			frameSizeY = 0.5,
			imageColor = UIData.Colors.darkerBackground,
			text = "Weapons",
			textColor = UIData.Colors.white,
			textSizeX = 0.6,
			textSizeY = 0.6,
			layout = 1,
		}),

		armorsTab = Tab({
			frameSizeX = 0.35,
			frameSizeY = 0.43,
			imageColor = UIData.Colors.white,
			text = "Armors",
			textColor = UIData.Colors.background,
			textSizeX = 0.6,
			textSizeY = 0.6,
			layout = 2,
		}),
		materialsTab = Tab({
			frameSizeX = 0.4,
			frameSizeY = 0.5,
			imageColor = UIData.Colors.darkerBackground,
			text = "Materials",
			textColor = UIData.Colors.white,
			textSizeX = 0.6,
			textSizeY = 0.6,
			layout = 3,
		}),
	}

	return React.createElement("ScrollingFrame", {
		Size = UDim2.fromScale(0.37, 0.12),
		Position = UDim2.fromScale(0.796, 0.123),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ScrollBarImageTransparency = 1,
		CanvasSize = UDim2.fromScale(0, 0),
		ScrollingDirection = Enum.ScrollingDirection.X,
		AutomaticCanvasSize = Enum.AutomaticSize.X,
	}, children)
end

return Tabs

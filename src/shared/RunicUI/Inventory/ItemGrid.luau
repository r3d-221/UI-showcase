local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local ItemSlot = require(ReplicatedStorage.Shared.RunicUI.Inventory.ItemSlot)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function ItemGrid()
	local children = {
		grid = React.createElement("UIGridLayout", {
			CellSize = UDim2.fromScale(0.14, 0.15),
			CellPadding = UDim2.fromScale(0.025, 0.025),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		padding = React.createElement("UIPadding", {
			PaddingLeft = UDim.new(0.05, 0),
			PaddingRight = UDim.new(0.015, 0),
		}),
	}

	for i = 1, 31 do
		children["slot_" .. tostring(i)] = React.createElement(ItemSlot, {
			icon = UIData.Images.slot,
			RarityColor = Color3.fromHex("#cbccd4"),
			OnClicked = function()
				print("Clicked slot number: " .. i)
			end,
		})
	end

	return React.createElement("ScrollingFrame", {
		Size = UDim2.fromScale(1, 0.94),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		CanvasSize = UDim2.fromScale(0, 0),
		BackgroundTransparency = 1,
		ScrollBarImageTransparency = 1,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	}, children)
end

return ItemGrid

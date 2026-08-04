local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Title = require(ReplicatedStorage.Shared.RunicUI.Inventory.Title)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function ItemInfo()
	local children = {
		title = React.createElement(Title, {
			textSizeX = 0.6,
			textSizeY = 0.6,
			frameSizeX = 0.9,
			frameSizeY = 0.1,
			framePosX = 0.5,
			framePosY = 0.06,
			text = "Leather armor",
			backgroundImage = UIData.Images.title,
			frameColor = UIData.Colors.common,
			textColor = UIData.Colors.white,
			imageScale = Enum.ScaleType.Fit,
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(0.3, 0.85),
		Position = UDim2.fromScale(0.83, 0.56),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UIData.Colors.darkerBackground,
	}, children)
end

return ItemInfo

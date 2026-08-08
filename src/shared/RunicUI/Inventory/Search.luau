local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local Text = require(ReplicatedStorage.Shared.Presets.Text)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function Search()
	local children = {
		icon = Image({
			imageSizeX = 0.15,
			imageSizeY = 0.45,
			imagePosX = 0.04,
			imageColor = UIData.Colors.background,
			image = UIData.Images.searchIcon,
			scale = Enum.ScaleType.Fit,
		}),
		background = Image({
			image = UIData.Images.search,
			imageColor = UIData.Colors.white,
			zIndex = 0,
			scale = Enum.ScaleType.Stretch,
		}),

		text = Text({
			text = "Search..",
			textSizeX = 0.6,
			textSizeY = 0.6,
			textPosX = 0.385,
			textPosY = 0.5,
			transparency = 0.6,
			textColor = UIData.Colors.background,
			alignment = Enum.TextXAlignment.Left,
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(0.52, 0.06),
		Position = UDim2.fromScale(0.282, 0.09),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
	}, children)
end

return Search

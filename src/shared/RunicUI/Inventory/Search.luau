local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
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
			scale = Enum.ScaleType.Fit,
		}),

		text = React.createElement("TextLabel", {
			Size = UDim2.fromScale(0.6, 0.6),
			Position = UDim2.fromScale(0.16, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Text = "Search..",
			TextTransparency = 0.6,
			TextColor3 = UIData.Colors.background,
			FontFace = Font.fromName("Montserrat", Enum.FontWeight.Bold),
			TextScaled = true,
			ZIndex = 1,
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

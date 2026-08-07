local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Button = require(ReplicatedStorage.Shared.Presets.Button)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

export type Props = {
	frameSizeX: number,
	frameSizeY: number,
	framePosX: number?,
	framePosY: number?,
	onClicked: () -> ()?,
}

local Utils = {}

local function background()
	local children = {
		base = Image({
			image = UIData.Images.buttonBase,
			scale = Enum.ScaleType.Stretch,
		}),
		topLeft = Image({
			image = UIData.Images.buttonTopLeft,
			scale = Enum.ScaleType.Stretch,
			imagePos = 0.25,
			imageSize = 0.5,
		}),
		topRight = Image({
			image = UIData.Images.buttonTopRight,
			scale = Enum.ScaleType.Stretch,
			imagePosX = 0.75,
			imagePosY = 0.25,
			imageSize = 0.5,
		}),
		bottomLeft = Image({
			image = UIData.Images.buttonBottomLeft,
			scale = Enum.ScaleType.Stretch,
			imagePosX = 0.25,
			imagePosY = 0.75,
			imageSize = 0.5,
		}),
		bottomRight = Image({
			image = UIData.Images.buttonBottomRight,
			scale = Enum.ScaleType.Stretch,
			imagePos = 0.75,
			imageSize = 0.5,
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 0,
	}, children)
end

function Utils.close(props: Props)
	local children = {
		icon = Image({
			image = UIData.Images.close,
			scale = Enum.ScaleType.Fit,
			imageSize = 0.45,
			imageColor = UIData.Colors.background,
		}),

		background = background(),

		button = Button({
			props.onClicked,
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(props.frameSizeX, props.frameSizeY),
		Position = UDim2.fromScale(props.framePosX or 0.5, props.framePosY or 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 2,
	}, children)
end

return Utils

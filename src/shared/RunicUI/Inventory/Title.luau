--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local Text = require(ReplicatedStorage.Shared.Presets.Text)

export type Props = {
	text: string,
	textColor: Color3,
	textSizeX: number?,
	textSizeY: number?,
	frameColor: Color3?,
	frameSizeX: number,
	frameSizeY: number,
	framePosX: number,
	framePosY: number,
	backgroundImage: string?,
	imageScale: Enum.ScaleType?,
}

local function Title(props: Props)
	local children = {
		Background = props.backgroundImage and React.createElement(Image, {
			image = props.backgroundImage,
			imageColor = props.frameColor,
			scale = props.imageScale,
			zIndex = 0,
		}),

		text = Text({
			textSizeX = props.textSizeX,
			textSizeY = props.textSizeY,
			textColor = props.textColor,
			text = props.text,
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(props.frameSizeX, props.frameSizeY),
		Position = UDim2.fromScale(props.framePosX, props.framePosY),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = props.backgroundImage and 1 or 0,
		BackgroundColor3 = props.frameColor,
	}, children)
end

return Title

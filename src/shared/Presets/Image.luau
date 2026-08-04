--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

export type Props = {
	scale: Enum.ScaleType?,
	image: string,
	imageColor: Color3?,
	zIndex: number?,
	imageSizeX: number?,
	imageSizeY: number?,
	imagePosX: number?,
	imagePosY: number?,
	firstGradient: Color3?,
	secondGradient: Color3?,
	rotation: number?,
}

local function Image(props: Props)
	local currentScaleType = props.scale or Enum.ScaleType.Slice

	local children = {
		gradient = (props.firstGradient and props.secondGradient) and React.createElement("UIGradient", {
			Color = ColorSequence.new(props.firstGradient, props.secondGradient),
			Rotation = props.rotation or 0,
		}),
	}

	return React.createElement("ImageLabel", {
		Size = UDim2.fromScale(props.imageSizeX or 1, props.imageSizeY or 1),
		Position = UDim2.fromScale(props.imagePosX or 0.5, props.imagePosY or 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Image = props.image,
		ImageColor3 = props.imageColor,
		BackgroundTransparency = 1,
		ScaleType = currentScaleType,
		SliceCenter = currentScaleType == Enum.ScaleType.Slice and Rect.new(250, 250, 250, 250) or nil,
		ZIndex = props.zIndex or 1,
	}, children)
end

return Image

--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

export type Props = {
	scale: Enum.ScaleType?,
	image: string,
	imageColor: Color3?,
	zIndex: number?,
	imageSize: number?,
	imageSizeX: number?,
	imageSizeY: number?,
	imagePos: number?,
	imagePosX: number?,
	imagePosY: number?,
	firstGradient: Color3?,
	secondGradient: Color3?,
	rotation: number?,
	sliceValue: number?,
	anchor: number?,
	anchorX: number?,
	anchorY: number?,
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
		Size = UDim2.fromScale(props.imageSizeX or props.imageSize or 1, props.imageSizeY or props.imageSize or 1),
		Position = UDim2.fromScale(props.imagePosX or props.imagePos or 0.5, props.imagePosY or props.imagePos or 0.5),
		AnchorPoint = Vector2.new(props.anchorX or props.anchor or 0.5, props.anchorY or props.anchor or 0.5),
		Image = props.image,
		ImageColor3 = props.imageColor,
		BackgroundTransparency = 1,
		ScaleType = currentScaleType,
		SliceCenter = currentScaleType == Enum.ScaleType.Slice and Rect.new(
			props.sliceValue or 250,
			props.sliceValue or 250,
			props.sliceValue or 250,
			props.sliceValue or 250
		) or nil,
		ZIndex = props.zIndex or 0,
	}, children)
end

return Image

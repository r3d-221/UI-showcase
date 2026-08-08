--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local Text = require(ReplicatedStorage.Shared.Presets.Text)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

export type Props = {
	backgroundImage: string?,
}

local function Title(props: Props)
	local children = {
		Background = React.createElement(Image, {
			image = UIData.Images.title,
			imageColor = UIData.Colors.common,
			scale = Enum.ScaleType.Stretch,
			zIndex = 0,
		}),

		text = Text({
			textSizeX = 0.65,
			textSizeY = 0.65,
			textColor = UIData.Colors.white,
			text = "Leather armor",
		}),
	}

	return React.createElement("Frame", {
		Size = UDim2.new(UDim.new(0.9, 0), UDim.new(0, 25)),
		Position = UDim2.fromScale(0.5, 0.045),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = props.backgroundImage and 1 or 0,
		BackgroundColor3 = UIData.Colors.common,
	}, children)
end

return Title

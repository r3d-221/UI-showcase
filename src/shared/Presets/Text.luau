local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)

export type Props = {
	text: string,
	textColor: Color3,
	textSizeX: number?,
	textSizeY: number?,
}

local function Text(props: Props)
	return React.createElement("TextLabel", {
		Size = UDim2.fromScale(props.textSizeX or 1, props.textSizeY or 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Text = props.text or "Default Text",
		TextColor3 = props.textColor or Color3.new(1, 1, 1),
		FontFace = Font.fromName("Montserrat", Enum.FontWeight.Bold),
		TextScaled = true,
		ZIndex = 1,
	})
end

return Text

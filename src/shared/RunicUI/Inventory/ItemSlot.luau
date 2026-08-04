local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function ItemSlot(props)
	local children = {
		button = React.createElement("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",
			[React.Event.Activated] = props.OnClicked,
		}),
		image = Image({
			image = UIData.Images.slot,
			firstGradient = UIData.Colors.background,
			secondGradient = UIData.Colors.common,
			rotation = -90,
		}),
	}

	return React.createElement("Frame", {
		BackgroundTransparency = 1,
	}, children)
end

return ItemSlot

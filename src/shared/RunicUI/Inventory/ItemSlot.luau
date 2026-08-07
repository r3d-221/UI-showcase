local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Button = require(ReplicatedStorage.Shared.Presets.Button)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function ItemSlot(props)
	local children = {
		button = Button({
			props.onClicked,
		}),

		image = Image({
			image = UIData.Images.slot,
			firstGradient = UIData.Colors.rare,
			secondGradient = UIData.Colors.background,
			rotation = -90,
		}),
	}

	return React.createElement("Frame", {
		BackgroundTransparency = 1,
	}, children)
end

return ItemSlot

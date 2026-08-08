local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Button = require(ReplicatedStorage.Shared.Presets.Button)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

local function Filter()
	local children = {
		background = Image({
			image = UIData.Images.filter,
			imageColor = UIData.Colors.white,
			scale = Enum.ScaleType.Stretch,
		}),
		button = Button({}),
	}

	return React.createElement("Frame", {
		Size = UDim2.fromScale(0.048, 0.06),
		Position = UDim2.fromScale(0.576, 0.09),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
	}, children)
end

return Filter

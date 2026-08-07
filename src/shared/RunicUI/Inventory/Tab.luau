local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Button = require(ReplicatedStorage.Shared.Presets.Button)
local Image = require(ReplicatedStorage.Shared.Presets.Image)
local Text = require(ReplicatedStorage.Shared.Presets.Text)
local UIData = require(ReplicatedStorage.Shared.RunicUI.UIData)

export type Props = {
    text: string,
    imageColor: Color3,
    textColor: Color3,
    textSizeX: number?,
	textSizeY: number?,
    frameSizeX: number?,
    frameSizeY: number?,
    layout: number?,
    onTabClicked: () -> ()?,
}

local function Tab(props: Props)
    local children = {
        image = Image({
            image = UIData.Images.tabs,
            imageColor = props.imageColor or UIData.Colors.white,
            sliceValue = 0,
        }),

        text = Text({
            text = props.text,
            textColor = props.textColor,
            textSizeX = props.textSizeX,
            textSizeY = props.textSizeY
        }),

        button = Button({
            props.onTabClicked
        })
    }

    return React.createElement("Frame", {
            Size = UDim2.fromScale(props.frameSizeX or 0.5, props.frameSizeY or 1),
		    Position = UDim2.fromScale(0.5, 0.5),
		    AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            LayoutOrder = props.layout or 1,
        }, children)
end

return Tab
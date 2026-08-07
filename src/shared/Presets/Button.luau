local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)

export type Props = {
    OnClicked: () -> ()?,
}

local function Button(props: Props)
    return React.createElement("TextButton", {
        Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		[React.Event.Activated] = props.OnClicked,
    })
end

return  Button
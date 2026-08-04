local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local Main = require(ReplicatedStorage.Shared.RunicUI.Inventory.Main)

return {
	react = React,
	reactRoblox = ReactRoblox,
	story = function(props)
		return React.createElement(Main)
	end,
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local RootUI = require(ReplicatedStorage.Shared.RootUI)

return function()
	local player = Players.LocalPlayer
	local PlayerGui = player:WaitForChild("PlayerGui")
	local container = Instance.new("ScreenGui")
	container.Name = "React"
	container.IgnoreGuiInset = true
	container.ResetOnSpawn = true
	container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	container.ClipToDeviceSafeArea = false
	container.Parent = PlayerGui
	local root = ReactRoblox.createRoot(container)
	local app = React.createElement(RootUI)
	root:render(app)
end

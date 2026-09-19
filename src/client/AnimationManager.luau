--!strict

-- Services
local TweenService = game:GetService("TweenService")

-- Constants
local STYLE = {
	popOut = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	hover = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	glow = TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
	fade = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	windowOpen = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	windowClose = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
	slotPop = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
}

-----------------------------------
-- Module definition & state
-----------------------------------
local AnimationManager = {}
local active = {}

-----------------------------------
-- Helper functions
-----------------------------------

local function playTween(target: Instance, tweenInfo: TweenInfo, properties: { [string]: any }): Tween
	if active[target] then
		active[target]:Cancel()
	end

	local tween = TweenService:Create(target, tweenInfo, properties)
	active[target] = tween

	tween.Completed:Connect(function()
		if active[target] == tween then
			active[target] = nil
		end
	end)

	tween:Play()
	return tween
end

local function getUIScale(element: GuiObject): UIScale
	local scale = element:FindFirstChildOfClass("UIScale")

	if scale and scale:IsA("UIScale") then
		return scale
	end

	local newScale = Instance.new("UIScale")
	newScale.Parent = element
	return newScale
end

-----------------------------------
-- Public functions
-----------------------------------

function AnimationManager.hover(element: GuiObject, isHovered: boolean)
	local scale = getUIScale(element)
	local targetScale = isHovered and 1.05 or 1.0

	playTween(scale, STYLE.hover, { Scale = targetScale })
end

function AnimationManager.popOut(element: GuiObject)
	local scale = getUIScale(element)

	scale.Scale = 1.15
	playTween(scale, STYLE.popOut, { Scale = 1.0 })
end

function AnimationManager.fade(canvasGroup: CanvasGroup, isVisible: boolean)
	local targetAlpha = isVisible and 0 or 1
	playTween(canvasGroup, STYLE.fade, { GroupTransparency = targetAlpha })
end

function AnimationManager.glow(image: ImageLabel)
	playTween(image, STYLE.glow, { ImageTransparency = 0.3 })
end

function AnimationManager.windowOpen(canvasGroup: CanvasGroup, scaleTarget: GuiObject)
	local scale = getUIScale(scaleTarget)

	scale.Scale = 0.85
	canvasGroup.GroupTransparency = 1
	canvasGroup.Visible = true

	playTween(scale, STYLE.windowOpen, { Scale = 1.0 })
	playTween(canvasGroup, STYLE.windowOpen, { GroupTransparency = 0 })
end

function AnimationManager.windowClose(canvasGroup: CanvasGroup, scaleTarget: GuiObject)
	local scale = getUIScale(scaleTarget)

	playTween(scale, STYLE.windowClose, { Scale = 0.9 })
	local fade = playTween(canvasGroup, STYLE.windowClose, { GroupTransparency = 1 })

	fade.Completed:Connect(function()
		if canvasGroup.GroupTransparency > 0.99 then
			canvasGroup.Visible = false
		end
	end)
end

function AnimationManager.staggerSectionsIn(sections: { CanvasGroup })
	for index, section in ipairs(sections) do
		section.GroupTransparency = 1

		task.delay(index * 0.06, function()
			if section.Parent then
				playTween(section, STYLE.fade, { GroupTransparency = 0 })
			end
		end)
	end
end

function AnimationManager.staggerPopIn(element: GuiObject, index: number)
	local scale = getUIScale(element)
	scale.Scale = 0

	task.delay(index * 0.04, function()
		if element.Parent then
			playTween(scale, STYLE.slotPop, { Scale = 1.0 })
		end
	end)
end

function AnimationManager.cancel(target: Instance)
	if active[target] then
		active[target]:Cancel()
		active[target] = nil
	end
end

return AnimationManager

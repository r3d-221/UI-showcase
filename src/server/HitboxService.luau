-- Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local HitboxService = {}

-----------------------------------
-- Helper functions
-----------------------------------

local function raycastVisual(rootPart: BasePart, targetPosition: Vector3, windUp: number, active: number)
	local direction = (targetPosition - rootPart.Position)
	local distance = direction.Magnitude
	local midPoint = rootPart.Position + direction.Unit * (distance / 2)

	local windUpBeam = Instance.new("Part")
	windUpBeam.Size = Vector3.new(0.05, 0.05, distance)
	windUpBeam.CFrame = CFrame.lookAt(midPoint, midPoint + direction.Unit)
	windUpBeam.Color = Color3.fromRGB(255, 200, 50)
	windUpBeam.Material = Enum.Material.Neon
	windUpBeam.Transparency = 0.3
	windUpBeam.Anchored = true
	windUpBeam.CanCollide = false
	windUpBeam.Parent = workspace
	game:GetService("Debris"):AddItem(windUpBeam, windUp)

	task.delay(windUp, function()
		local activeBeam = Instance.new("Part")
		activeBeam.Size = Vector3.new(0.15, 0.15, distance)
		activeBeam.CFrame = CFrame.lookAt(midPoint, midPoint + direction.Unit)
		activeBeam.Color = Color3.fromRGB(236, 119, 131)
		activeBeam.Material = Enum.Material.Neon
		activeBeam.Transparency = 0.2
		activeBeam.Anchored = true
		activeBeam.CanCollide = false
		activeBeam.Parent = workspace
		game:GetService("Debris"):AddItem(activeBeam, active)
	end)
end

local function arcVisual(rootPart: BasePart, range: number, angle: number, windUp: number, active: number)
	local rayCount = 8
	local forward = rootPart.CFrame.LookVector

	for i = 0, rayCount do
		local t = i / rayCount
		local currentAngle = math.rad((t - 0.5) * angle * 2)
		local rotated = (CFrame.fromAxisAngle(Vector3.yAxis, currentAngle) * CFrame.new(Vector3.zero, forward)).LookVector
		local direction = rotated.Unit
		local midPoint = rootPart.Position + direction * (range / 2)

		local line = Instance.new("Part")
		line.Size = Vector3.new(0.1, 0.1, range)
		line.CFrame = CFrame.lookAt(midPoint, midPoint + direction)
		line.Color = Color3.fromRGB(255, 200, 50)
		line.Material = Enum.Material.Neon
		line.Transparency = 0.4
		line.Anchored = true
		line.CanCollide = false
		line.Parent = workspace
		game:GetService("Debris"):AddItem(line, windUp)

		task.delay(windUp, function()
			local activeLine = Instance.new("Part")
			activeLine.Size = Vector3.new(0.2, 0.2, range)
			activeLine.CFrame = CFrame.lookAt(midPoint, midPoint + direction)
			activeLine.Color = Color3.fromRGB(236, 119, 131)
			activeLine.Material = Enum.Material.Neon
			activeLine.Transparency = 0.3
			activeLine.Anchored = true
			activeLine.CanCollide = false
			activeLine.Parent = workspace
			game:GetService("Debris"):AddItem(activeLine, active)
		end)
	end
end

local function sphereVisual(position: Vector3, radius: number, windUp: number, active: number)
	local windUpSphere = Instance.new("Part")
	windUpSphere.Shape = Enum.PartType.Ball
	windUpSphere.Color = Color3.fromRGB(255, 200, 50)
	windUpSphere.Material = Enum.Material.Neon
	windUpSphere.Transparency = 0.6
	windUpSphere.Anchored = true
	windUpSphere.CanCollide = false
	windUpSphere.Size = Vector3.new(radius * 2, radius * 2, radius * 2)
	windUpSphere.Position = position
	windUpSphere.Parent = workspace
	game:GetService("Debris"):AddItem(windUpSphere, windUp)

	task.delay(windUp, function()
		local activeSphere = Instance.new("Part")
		activeSphere.Shape = Enum.PartType.Ball
		activeSphere.Color = Color3.fromRGB(236, 119, 131)
		activeSphere.Material = Enum.Material.Neon
		activeSphere.Transparency = 0.5
		activeSphere.Anchored = true
		activeSphere.CanCollide = false
		activeSphere.Size = Vector3.new(radius * 2, radius * 2, radius * 2)
		activeSphere.Position = position
		activeSphere.Parent = workspace
		game:GetService("Debris"):AddItem(activeSphere, active)
	end)
end

local function cylinderVisual(center: Vector3, radius: number, height: number, windUp: number, active: number)
	local windUpCylinder = Instance.new("Part")
	windUpCylinder.Shape = Enum.PartType.Cylinder
	windUpCylinder.Color = Color3.fromRGB(255, 200, 50)
	windUpCylinder.Material = Enum.Material.Neon
	windUpCylinder.Transparency = 0.6
	windUpCylinder.Anchored = true
	windUpCylinder.CanCollide = false
	windUpCylinder.Size = Vector3.new(height, radius * 2, radius * 2)
	windUpCylinder.CFrame = CFrame.new(center) * CFrame.Angles(0, 0, math.rad(90))
	windUpCylinder.Parent = workspace
	game:GetService("Debris"):AddItem(windUpCylinder, windUp)

	task.delay(windUp, function()
		local activeCylinder = Instance.new("Part")
		activeCylinder.Shape = Enum.PartType.Cylinder
		activeCylinder.Color = Color3.fromRGB(236, 119, 131)
		activeCylinder.Material = Enum.Material.Neon
		activeCylinder.Transparency = 0.5
		activeCylinder.Anchored = true
		activeCylinder.CanCollide = false
		activeCylinder.Size = Vector3.new(height, radius * 2, radius * 2)
		activeCylinder.CFrame = CFrame.new(center) * CFrame.Angles(0, 0, math.rad(90))
		activeCylinder.Parent = workspace
		game:GetService("Debris"):AddItem(activeCylinder, active)
	end)
end

local function getDirectionToTarget(enemy): Vector3
	local rootPart = enemy.rootPart
	local player = enemy.target
	local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	if not targetRoot then
		return rootPart.CFrame.LookVector
	end

	local flat =
		Vector3.new(targetRoot.Position.X - rootPart.Position.X, 0, targetRoot.Position.Z - rootPart.Position.Z)

	if flat.Magnitude == 0 then
		return rootPart.CFrame.LookVector
	end

	return flat.Unit
end

local function getPartsHit(enemy): { [Humanoid]: true }
	local params = OverlapParams.new()
	params.FilterDescendantsInstances = { enemy.model }
	params.FilterType = Enum.RaycastFilterType.Exclude

	local hitboxInfo = enemy.config.hitbox
	local rootPart = enemy.rootPart

	local hits: { [Humanoid]: true } = {}
	local parts = {}

	if hitboxInfo.type == "sphere" then
		parts = workspace:GetPartBoundsInRadius(rootPart.Position, hitboxInfo.radius, params)
	elseif hitboxInfo.type == "arc" then
		local allParts = workspace:GetPartBoundsInRadius(rootPart.Position, hitboxInfo.range, params)
		local forward = rootPart.CFrame.LookVector

		for _, part in allParts do
			local toTarget = (part.Position - rootPart.Position)
			if toTarget.Magnitude > 0 then
				local dot = forward:Dot(toTarget.Unit)
				local angle = math.deg(math.acos(math.clamp(dot, -1, 1)))
				if angle <= (hitboxInfo.angle or 60) then
					table.insert(parts, part)
				end
			end
		end
	elseif hitboxInfo.type == "cylinder" then
		local direction = getDirectionToTarget(enemy)
		local center = rootPart.Position + direction * (hitboxInfo.distance or 0)

		local allParts = workspace:GetPartBoundsInRadius(center, hitboxInfo.radius, params)
		local halfHeight = (hitboxInfo.height or 4) / 2

		for _, part in allParts do
			if math.abs(part.Position.Y - center.Y) <= halfHeight then
				table.insert(parts, part)
			end
		end
	end

	for _, part in parts do
		local model = part.Parent
		local hum: Humanoid? = model and model:FindFirstChildOfClass("Humanoid")
		if hum and not hits[hum] and hum.Health > 0 then
			if Players:GetPlayerFromCharacter(model) then
				hits[hum] = true
			end
		end
	end

	return hits
end

local function fireRaycast(enemy)
	local rootPart = enemy.rootPart
	local player = enemy.target
	local info = enemy.config

	local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not targetRoot then
		return
	end

	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = { player.Character }
	rayParams.FilterType = Enum.RaycastFilterType.Include

	local origin = rootPart.Position
	local direction = (targetRoot.Position - origin).Unit
	local result = workspace:Raycast(origin, direction * info.hitbox.range, rayParams)

	if not result then
		return
	end

	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return
	end

	humanoid:TakeDamage(info.damage)
end

local function hitboxVisual(enemy)
	local rootPart = enemy.rootPart
	local hitboxInfo = enemy.config.hitbox
	local windUp = hitboxInfo.windUp
	local active = hitboxInfo.active

	if hitboxInfo.type == "sphere" then
		sphereVisual(rootPart.Position, hitboxInfo.radius, windUp, active)
	elseif hitboxInfo.type == "arc" then
		arcVisual(rootPart, hitboxInfo.range, hitboxInfo.angle, windUp, active)
	elseif hitboxInfo.type == "cylinder" then
		local direction = getDirectionToTarget(enemy)
		local center = rootPart.Position + direction * (hitboxInfo.distance or 0)
		cylinderVisual(center, hitboxInfo.radius, hitboxInfo.height, windUp, active)
	elseif hitboxInfo.type == "raycast" then
		local player = enemy.target
		local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if targetRoot then
			raycastVisual(rootPart, targetRoot.Position, windUp, active)
		end
	end
end

-----------------------------------
-- Public functions
-----------------------------------

function HitboxService.performAttack(enemy)
	local humanoid = enemy.humanoid
	local info = enemy.config
	local hitboxInfo = info.hitbox

	humanoid.WalkSpeed = 0

	if RunService:IsStudio() then
		hitboxVisual(enemy)
	end

	task.wait(hitboxInfo.windUp)

	if not humanoid or humanoid.Health <= 0 then
		return
	end

	local hits = {}
	if hitboxInfo.type == "raycast" then
		fireRaycast(enemy)
	else
		hits = getPartsHit(enemy)
	end

	for hit in hits do
		local damage = info.damage
		hit:TakeDamage(damage)
	end

	task.wait(hitboxInfo.active + hitboxInfo.recovery)

	humanoid.WalkSpeed = info.walkspeed
end

return HitboxService

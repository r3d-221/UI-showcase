local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage.Remotes
local SyncData = Remotes.SyncData

local listeners = {}
local public = {}
local cache = nil

function public.onStart()
	SyncData.OnClientEvent:Connect(function(data)
		cache = data
		for _, fn in listeners do
			fn(data)
		end
	end)
end

function public.getData()
	return cache
end

function public.onChange(fn)
	table.insert(listeners, fn)
end

return public

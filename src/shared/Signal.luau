local public = {}
public.__index = public

function public.new()
	return setmetatable({ _handlers = {} }, public)
end

function public:Connect(fn)
	local id = #self._handlers + 1
	self._handlers[id] = fn
	return {
		Disconnect = function()
			self._handlers[id] = nil
		end,
	}
end

function public:Fire(...)
	for _, fn in pairs(self._handlers) do
		task.spawn(fn, ...)
	end
end


return public
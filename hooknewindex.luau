--!nonstrict
--!native
if not hookmetamethod or not newcclosure or not checkcaller then
	return error("unsupported executor", 2);
end;
local enabled; enabled = false;
local hook; hook = hookmetamethod(game, "__newindex", newcclosure(@native function(table, index, value)
	if not checkcaller() and enabled then
		if index == "WalkSpeed" then
			return hook(table, index, 30);
		end;
	end;
	return hook(table, index, value)
end));
cloneref(game:GetService("UserInputService")).InputBegan:Connect(newcclosure(@native function(input, gameProcessedEvent)
	if not gameProcessedEvent then
		if input.KeyCode == Enum.KeyCode.J then
			enabled = not enabled;
		end;
	end;
end));

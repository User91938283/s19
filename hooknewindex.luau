--!nonstrict
--!native
if not hookmetamethod or not newcclosure or not checkcaller then
	return error("unsupported executor", 2);
end;
pcall(newcclosure(@native function(...)
	return loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Adonis-actul-bypass-20697"))();
end));
task.wait(1);
local enabled; enabled = false;
local hook; hook = hookmetamethod(game, "__newindex", newcclosure(@native function(table, index, value)
	if not checkcaller() then
		if index == "WalkSpeed" and enabled then
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

--!nonstrict
--!native
game:GetService("Lighting"):WaitForChild("Blink_Overlay_Blur").Size = 0;
game:GetService("Lighting"):WaitForChild("Blink_Overlay_CC").Brightness = 0;

for k, v in pairs(getgc(true)) do
	if (typeof(v) == "table" and ((rawget(v, "Blink") and typeof(rawget(v, "Blink")) == "number") and (rawget(v, "Sprint") and typeof(rawget(v, "Sprint")) == "number"))) then
		rawset(v, "Blink", 21);
		rawset(v, "Sprint", 21);
	end;
	if (typeof(v) == "table" and ((rawget(v, "Blink") and typeof(rawget(v, "Blink")) == "function") and (rawget(v, "Sprint") and typeof(rawget(v, "Sprint")) == "function"))) then
		--hookfunction(rawget(v, "Sprint"), newcclosure(@native function(...) end));
		hookfunction(rawget(v, "Blink"), newcclosure(@native function(...) end));
	end;
	if (typeof(v) == "table" and (rawget(v, "UpdateSprintBar") and rawget(v, "UpdateBlink"))) then
		hookfunction(rawget(v, "UpdateSprintBar"), newcclosure(@native function(...) end));
		hookfunction(rawget(v, "UpdateBlink"), newcclosure(@native function(...) end));
	end;
end;

local hook_index; hook_index = hookmetamethod(game, "__index", newcclosure(@native function(table, index, ...)
	if checkcaller() then return hook_index(table, index, ...); end;
	if table[index] and typeof(table[index]) == "number" then
		if index == "Blink" or index == "Sprint" then
			return 21;
		end;
	end;
	return hook_index(table, index, ...);
end));

local hook_newindex; hook_newindex = hookmetamethod(game, "__newindex", newcclosure(@native function(table, index, value, ...)
	if checkcaller() then return hook_newindex(table, index, value, ...); end;
	if table[index] and typeof(table[index]) == "number" then
		if index == "Blink" or index == "Sprint" then
			return;
		end;
	end;
	return hook_newindex(table, index, value, ...);
end));

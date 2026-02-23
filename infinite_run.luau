--!nonstrict
--!native
local hook; hook = hookmetamethod(game, "__newindex", newcclosure(@native function(table, index, value)
	if not checkcaller() then
		if index == "WalkSpeed" then
			return hook(table, index, 30);
		end;
	end;
	return hook(table, index, value)
end));

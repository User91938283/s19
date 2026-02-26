--!nonstrict
--!native
if not hookmetamethod or not newcclosure or not checkcaller then
	return error("unsupported executor");
end;
local hook; hook = hookmetamethod(game, "__newindex", newcclosure(@native function(self, index, value)
	if not checkcaller() then
		if index == "WalkSpeed" and value > 10 then
			return hook(self, index, 30);
		end;
	end;
	return hook(self, index, value);
end));

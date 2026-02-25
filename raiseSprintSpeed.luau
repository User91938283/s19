--!nonstrict
--!native
if not hookmetamethod or not newcclosure or not checkcaller then
  return error("unsupported executor");
end;
local hook; hook = hookmetamethod(game, "__newindex", newcclosure(@native function(table, index, value)
	if not checkcaller() then
		if index == "WalkSpeed" and value > 10 then
			return hook(table, index, 30);
		end;
	end;
	return hook(table, index, value)
end), "hook_newindex");

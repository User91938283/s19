--!nonstrict
--!native
if not hookmetamethod or not newcclosure or not checkcaller or not getnamecallmethod then
	return error("unsupported executor", 2);
end;

local hook; hook = hookmetamethod(game, "__namecall", newcclosure(@native function(self, ...)
	if checkcaller() then return hook(self, ...); end;
	local method = string.lower(getnamecallmethod());
	if method == "kick" then
		return;
	end;
	if (method == "getrankingroup" or method == "getrankingroupasync") then
		return 225;
	end;
	return hook(self, ...);
end));

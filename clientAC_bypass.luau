--!nonstrict
--!native
if not getgc or not hookfunction or not newcclosure then
	return error("unsupported executor", 2);
end;

for k, v in pairs(getgc(true)) do
	if (typeof(v) == "function" and debug.info(v, "n") == "_exploiterKick") then
		hookfunction(v, newcclosure(@native function(...)
		end));
	end;
end;

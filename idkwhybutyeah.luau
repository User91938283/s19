--!nonstrict
--!native
if not getgc then
	return error("unsupported executor", 2);
end;

for k, v in pairs(getgc(true)) do
	if (typeof(v) == "function" and debug.info(v, "n") == "GrantPrivatePanelAccess") then
		v();
		break;
	end;
end;

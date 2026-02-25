--!nonstrict
--!native
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and rawget(v, "PrivatePanelInterface") then
		rawget(v, "PrivatePanelInterface"):Register();
		break;
	end;
end;

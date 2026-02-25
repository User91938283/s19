--!nonstrict
--!native
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and rawget(v, "PrivatePanelInterface") then
		if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PrivatePanelInterface") then
			rawget(v, "PrivatePanelInterface"):Unregister();
			break;
		end;
		rawget(v, "PrivatePanelInterface"):Register();
		break;
	end;
end;

--!nonstrict
--!native
local network = {}; for k, v in getgc(true) do
	if typeof(v) == "table" and (rawget(v, "FireServer") and rawget(v, "InvokeServer") and rawget(v, "OnEvent") and rawget(v, "OnFunction")) then
		network = v;
		break;
	end;
end;

for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and rawget(v, "Spread") and rawget(v, "Rpm") then
		rawset(v, "Range", 999999*999999);
		rawset(v, "Spread", 0);
		rawset(v, "Damage", 999999*999999);
		rawset(v, "Rpm", 999999*999999);
		rawset(v, "Automatic", true);
		rawset(v, "CanLower", true);
		rawset(v, "Ammo", 999999*999999);
	end;
end;

for k, v in getgc(true) do
	if type(v) == "table" then
		if rawget(v, "_discharge") then	
			local hook__discharge; hook__discharge = hookfunction(rawget(v, "_discharge"), newcclosure(@native function(gun_settings)
				network:FireServer("setToolState", "Reload");
				network:FireServer("setToolState", "Reloaded");
				gun_settings.Ammo = 999999*999999;
				return hook__discharge(gun_settings);
			end));
		end;
	end;
end;

local FirearmClass; for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and (rawget(v, "new") and rawget(v, "Discharge") and rawget(v, "ToggleFlashlight")) then
		FirearmClass = v;
		break;
	end;
end;

local hook_Discharge; hook_Discharge = hookfunction(FirearmClass.Discharge, newcclosure(@native function(...)
	for i = 1, 5 do
		hook_Discharge(...);
	end;
end));

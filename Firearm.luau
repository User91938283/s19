--!nonstrict
--!native

--// Flux Network \\--
local network = {}; for k, v in getgc(true) do
	if typeof(v) == "table" and (rawget(v, "FireServer") and rawget(v, "InvokeServer") and rawget(v, "OnEvent") and rawget(v, "OnFunction")) then
		network = v;
		break;
	end;
end;

--// A-10 Guns \\--
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

--// Inf Ammo \\--
for k, v in getgc(true) do
	if type(v) == "table" then
		if rawget(v, "_discharge") then	
			local hook__discharge; hook__discharge = hookfunction(rawget(v, "_discharge"), newcclosure(@native function(self)
				network:FireServer("setToolState", "Reload");
				network:FireServer("setToolState", "Reloaded");
				self.Ammo = 999999*999999;
				return hook__discharge(self);
			end));
		end;
	end;
end;

--// Insta Kill \\--
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

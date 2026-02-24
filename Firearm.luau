--!nonstrict
--!native

--// Flux Network \\--
local network; for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and ((rawget(v, "FireServer") and typeof(rawget(v, "FireServer")) == "function") and (rawget(v, "InvokeServer") and typeof(rawget(v, "InvokeServer")) == "function") and (rawget(v, "OnEvent") and typeof(rawget(v, "OnEvent")) == "function") and (rawget(v, "OnFunction") and typeof(rawget(v, "OnFunction")) == "function")) then
		network = {
			FireServer = newcclosure(@native function(self, ...)
				return v:FireServer(...);
			end);
			InvokeServer = newcclosure(@native function(self, ...)
				return v:InvokeServer(...);
			end);
			OnEvent = newcclosure(@native function(self, ...)
				return v:OnEvent(...);
			end);
			OnFunction = newcclosure(@native function(self, ...)
				return v:OnFunction(...);
			end);
		};
		break;
	end;
end;

--// A-10 Guns \\--
local Stats; for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and (rawget(v, "Range") and rawget(v, "Spread") and rawget(v, "Rpm") and rawget(v, "Ammo")) then
		Stats = v;
		break;
	end;
end;

rawset(Stats, "Range", 999999*999999);
rawset(Stats, "Spread", 0);
rawset(Stats, "Damage", 999999*999999);
rawset(Stats, "Rpm", 999999*999999);
rawset(Stats, "Automatic", true);
rawset(Stats, "CanLower", true);
rawset(Stats, "Ammo", 999999*999999);

--// Inf Ammo \\--
for k, v in getgc(true) do
	if type(v) == "table" then
		if rawget(v, "_discharge") then	
			local hook__discharge; hook__discharge = hookfunction(rawget(v, "_discharge"), newcclosure(@native function(self)
				network:FireServer("setToolState", "Reload");
				network:FireServer("setToolState", "Reloaded");
				rawset(self, "Ammo", 999999*999999);
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

--!nonstrict
--!native
if not getgc or not newcclosure or not hookfunction then
	return error("unsupported executor", 2);
end;

local network; for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and ((rawget(v, "FireServer") and typeof(rawget(v, "FireServer")) == "function") and (rawget(v, "InvokeServer") and typeof(rawget(v, "InvokeServer")) == "function") and (rawget(v, "OnEvent") and typeof(rawget(v, "OnEvent")) == "function") and (rawget(v, "OnFunction") and typeof(rawget(v, "OnFunction")) == "function")) then
		network = {
			FireServer = newcclosure(@native function(self, ...)
				local args = { ... };
				if args and args[2] and args[2] == "Discharge" then
					for i = 1, 5 do
						v:FireServer(...);
					end;
					return;
				end;
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

local Rpm; Rpm = 999;
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and (rawget(v, "Range") and rawget(v, "Spread") and rawget(v, "Rpm") and rawget(v, "Ammo")) then
		rawset(v, "Range", 999999*999999);
		rawset(v, "Spread", 0);
		rawset(v, "Damage", 999999*999999);
		rawset(v, "Rpm", Rpm);
		rawset(v, "Automatic", true);
		rawset(v, "CanLower", true);
		rawset(v, "Ammo", 999999*999999);
	end;
end;

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

--[[local FirearmClass; for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and (rawget(v, "new") and rawget(v, "Discharge") and rawget(v, "ToggleFlashlight")) then
		FirearmClass = v;
		break;
	end;
end;

local hook_Discharge; hook_Discharge = hookfunction(FirearmClass.Discharge, newcclosure(@native function(...)
	for i = 1, 5 do
		hook_Discharge(...);
		task.wait(60/Rpm);
	end;
end));]]

warn("Firearm.luau: Initiated.");

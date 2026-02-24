--!nonstrict
--!native
if not getgc or not newcclosure or not hookfunction then
	return error("unsupported executor", 2);
end;
local Rpm = 999;
local OMG = 999999*999999;
local network = {};
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		local FireServer = rawget(v, "FireServer");
		local InvokeServer = rawget(v, "InvokeServer");
		local OnEvent = rawget(v, "OnEvent");
		local OnFunction = rawget(v, "OnFunction");
		if (FireServer and typeof(FireServer) == "function" and InvokeServer and typeof(InvokeServer) == "function" and OnEvent and typeof(OnEvent) == "function" and OnFunction and typeof(OnFunction) == "function") then
			network = v;
			local hook_fireserver; hook_fireserver = hookfunction(FireServer, newlclosure(@native function(...)
				local eventName = select(2, ...);
				if eventName == "Discharge" then
					for i = 1, 3 do
						hook_fireserver(...);
					end;
					return;
				end;
				return hook_fireserver(...);
			end));
		end;
	end;
	if network then
		break;
	end;
end;
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and (rawget(v, "Range") and rawget(v, "Spread") and rawget(v, "Rpm") and rawget(v, "Ammo")) then
		rawset(v, "Range", OMG);
		rawset(v, "Spread", 0);
		rawset(v, "Damage", OMG);
		rawset(v, "Rpm", Rpm);
		rawset(v, "Automatic", true);
		rawset(v, "CanLower", true);
		rawset(v, "Ammo", OMG);
	end;
	if type(v) == "table" then
		local _discharge = rawget(v, "_discharge");
		if _discharge and not isfunctionhooked(_discharge) then	
			local hook__discharge; hook__discharge = hookfunction(_discharge, newcclosure(@native function(self, ...)
				if not network then return hook__discharge(self, ...); end;
				if not network.FireServer then print("network.FireServer is not valid member of network."); return hook__discharge(self, ...); end;
				network:FireServer("setToolState", "Reload");
				network:FireServer("setToolState", "Reloaded");
				rawset(self, "Ammo", OMG);
				return hook__discharge(self, ...);
			end));
		else
			_discharge = nil;
		end;
	end;
end;
warn("Firearm.luau: Initiated.");

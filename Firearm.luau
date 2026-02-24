--!nonstrict
--!native
local network = {};
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		if (rawget(v, "FireServer") and typeof(rawget(v, "FireServer")) == "function") and (rawget(v, "InvokeServer") and typeof(rawget(v, "InvokeServer")) == "function") then
			network.FireServer = rawget(v, "FireServer");
			network.InvokeServer = rawget(v, "InvokeServer");
			break;
		end;
	end;
end;
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		if rawget(v, "FireServer") and typeof(rawget(v, "FireServer")) == "function" then
			local hook; hook = hookfunction(rawget(v, "FireServer"), newcclosure(@native function(...)
				local eventName = select(3, ...);
				if (eventName and typeof(eventName) == "string") and eventName == "Discharge" then
					for i = 1, 3  do
						hook(...)
					end;
					return;
				end;
				return hook(...);
			end));
		end;
	end;
end;
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		if rawget(v, "Range") and rawget(v, "Spread") and rawget(v, "Rpm") and rawget(v, "Automatic") and rawget(v, "Ammo") then
			rawset(v, "Range", (999999^2*999999^2)^2);
			rawset(v, "Spread", 0);
			rawset(v, "Damage", (999999^2*999999^2)^2);
			rawset(v, "Rpm", (999999^2*999999^2)^2);
			rawset(v, "Automatic", true);
			rawset(v, "CanLower", true);
			rawset(v, "Ammo", (999999^2*999999^2)^2)
		end;
	end;
end;
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		if rawget(v, "_discharge") and rawget(v, "_activateDischarge") then
			local hook; hook = hookfunction(rawget(v, "_discharge"), newcclosure(@native function(...)
				local self = select(1, ...);
				network:FireServer("setToolState", "Reload");
				network:FireServer("setToolState", "Reloaded");
				rawset(self, "Ammo", (999999^2*999999^2)^2);
			end));
		end;
	end;
end;

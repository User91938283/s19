--!nonstrict
--!native
local Rpm = 999998000001;
local Num = 999998000001;
local network = {};
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		if rawget(v, "FireServer") and typeof(rawget(v, "FireServer")) == "function" then
			if not isfunctionhooked(rawget(v, "FireServer")) then
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
				if not network.FireServer then
					if (rawget(v, "FireServer") and typeof(rawget(v, "FireServer")) == "function") and (rawget(v, "InvokeServer") and typeof(rawget(v, "InvokeServer")) == "function") then
						network.FireServer = rawget(v, "FireServer");
						network.InvokeServer = rawget(v, "InvokeServer");
					end;
				end;
			end;
		end;
	end;
end;
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		if rawget(v, "Range") and rawget(v, "Spread") and rawget(v, "Rpm") and rawget(v, "Automatic") ~= nil and rawget(v, "Ammo") then
			rawset(v, "Range", Num);
			rawset(v, "Spread", 0);
			rawset(v, "Damage", Num);
			rawset(v, "Rpm", Rpm);
			rawset(v, "Automatic", true);
			rawset(v, "CanLower", true);
			rawset(v, "Ammo", Num)
		end;
	end;
end;
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		if rawget(v, "_discharge") and rawget(v, "_activateDischarge") then
			if not isfunctionhooked(rawget(v, "_discharge")) then
				local hook; hook = hookfunction(rawget(v, "_discharge"), newcclosure(@native function(...)
					if not network.FireServer then
						print("method FireServer is not valid member of table network.");
						for k, v in pairs(getgc(true)) do
							if typeof(v) == "table" then
								if rawget(v, "OnEvent") and rawget(v, "OnFunction") then
									network = v;
									break;
								end;
							end;
						end;
						return hook(...);
					end;
					local self = select(1, ...);
					network:FireServer("setToolState", "Reload");
					network:FireServer("setToolState", "Reloaded");
					rawset(self, "Ammo", Num);
					return hook(...);
				end));
			end;
		end;
	end;
end;
local hook; hook = hookfunction(task.wait, newcclosure(@native function(...)
	local info = debug.getinfo(2, "n");
	if info and info.name == "_activateDischarge" then
		return hook(nil);
	end;
	return hook(...);
end));

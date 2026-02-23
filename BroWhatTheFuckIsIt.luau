--!nonstrict
--!native
local Stats;
local network; network = {};
for _,v in getgc(false) do
	if type(v) == "function" and islclosure(v) then
		if debug.info(v, "n") == "FireServer" then
			network.FireServer = v;
		elseif debug.info(v, "n") == "InvokeServer" then
			network.InvokeServer = v;
		end;
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
for _,v in getgc(true) do
	if type(v) == "table" then
		if rawget(v, "_discharge") then	
			local hook; hook = hookfunction(rawget(v, "_discharge"), newlclosure(@native function(gun_settings)
				network:FireServer("setToolState", "Reload");
				network:FireServer("setToolState", "Reloaded");
				gun_settings.Ammo = 999;
				hook(gun_settings);
			end));
		end;
	end;
end;

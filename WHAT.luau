--!nonstrict
--!native
local network = {};
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and rawget(v, "FireServer") and rawget(v, "InvokeServer") and rawget(v, "OnEvent") then
		network = v;
		break;
	end
end;
for i = 1, 20 do
	coroutine.wrap(@native function(...)
		network:FireServer("switchTeamMenu", "Security Department");
		network:FireServer("switchTeamMenu", "Janitor");
		network:FireServer("switchTeamMenu", "Security Department");
		network:FireServer("switchTeamMenu", "Janitor");
	end)();
end;

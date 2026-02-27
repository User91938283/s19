--!nonstrict
--!native

--// This script works only in S.C.P. Site-19 Roleplay v3 place! You can join it by using this link: roblox://placeId=18288004258
local network;
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		if rawget(v, "FireServer") and rawget(v, "InvokeServer") and rawget(v, "Set") then
			network = v;
			break;
		end;
	end;
end;

if not network then return error("network is not found."); end;

--// Site Director, Ethics Committee, MTF Omega-1.
network:FireServer("changeTeamMenu", "MTF Omega-1");

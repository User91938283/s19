--!nonstrict
--!native
local network = {}; for _,v in getgc(true) do
	if typeof(v) == "table" then
		if rawget(v, "OnEvent") and rawget(v, "OnFunction") then
			network = v;
			break;
		end;
	end;
end;

--!nonstrict
--!native
local func = newcclosure(@native function(...)
	game:GetService("Lighting"):WaitForChild("Blink_Overlay_Blur").Size = 0;
	game:GetService("Lighting"):WaitForChild("Blink_Overlay_CC").Brightness = 0;
	for k, v in pairs(getgc(true)) do
		if typeof(v) == "table" and rawget(v, "Blink") and rawget(v, "Sprint") then
			if typeof(rawget(v, "Blink")) == "number" then
				rawset(v, "Blink", math.huge);
			end;
			if typeof(rawget(v, "Sprint")) == "number" then
				rawset(v, "Sprint", math.huge);
			end;
		end;
		if typeof(v) == "table" and (rawget(v, "Blink") and typeof(rawget(v, "Blink")) == "function") and (rawget(v, "Sprint") and typeof(rawget(v, "Sprint"))) then
			if not isfunctionhooked(rawget(v, "Blink")) then
				hookfunction(rawget(v, "Blink"), newcclosure(@native function(...) end));
			end;
		end;
	end;
end);
func();
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(newcclosure(@native function(...)
	game:GetService("RunService").PostSimulation:Wait();
	func();
end));

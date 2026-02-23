--!nonstrict
--!native
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
local Player; Player = game:GetService("Players").LocalPlayer;
local Try; Try = 50;
local teleport_to_location; teleport_to_location = @native function(Cframe)
	for i: number = 1, Try do
		task.wait();
		if not Player or not Player.Character or not Player.Character:FindFirstChild("Humanoid") then
			continue;
		end;
		Player.Character:PivotTo(CFrame.new(538.700073, 34, -190.999969, 0, 1, 0, 0, 0, 1, 1, 0, 0));
	end;
	task.wait();
	for i: number = 1, Try do
		task.wait();
		if not Player or not Player.Character or not Player.Character:FindFirstChild("Humanoid") then
			continue;
		end;
		Player.Character:PivotTo(Cframe);
	end;
end;
teleport_to_location(CFrame.new(1008.09027, 15.9999981, -170.578812, 1, -8.93967034e-09, -4.60179981e-05, 8.93900953e-09, 1, -1.43606655e-08, 4.60179981e-05, 1.43602543e-08, 1));
teleport_to_location(CFrame.new(1008.09027, 15.9999981, -170.578812, 1, -8.93967034e-09, -4.60179981e-05, 8.93900953e-09, 1, -1.43606655e-08, 4.60179981e-05, 1.43602543e-08, 1));
teleport_to_location(CFrame.new(584.1257934570312, -0.9999967813491821, 153.55552673339844));
teleport_to_location(CFrame.new(584.1257934570312, -0.9999967813491821, 153.55552673339844));
Player.Character.PrimaryPart.Anchored = true;
for i = 1, 10 do
	coroutine.wrap(@native function(...)
		network:InvokeServer("createCupOf", "LIFE");
	end)();
end;
Player.Character.PrimaryPart.Anchored = false;

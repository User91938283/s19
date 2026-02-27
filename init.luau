--!nonstrict
--!native
local loadScript = newcclosure(@native function(link, ...)
	task.spawn(@native function(...)
		if link and typeof(link) == "string" then
			local success, result = pcall(@native function(...)
				return loadstring(game:HttpGet(link))();
			end);
			if success then return result; end;
			return warn("Failed to load link: " .. tostring(link) .. " with error: " .. tostring(result));
		else
			error("link must be type of string.");
		end;
	end);
end);

loadScript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/Firearm.luau");
loadScript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/Site19SEXHUB.luau");
loadScript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/clientAC_bypass.luau");
loadScript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/esp.luau");
loadScript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/raiseSprintSpeed.luau")

loadScript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/removeBlinkAndSprint.luau");

cloneref(game:GetService("Players")).LocalPlayer.CharacterAdded:Connect(newcclosure(@native function(...)
	task.wait(cloneref(game:GetService("RunService")).PostSimulation:Wait()^2);
	loadScript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/removeBlinkAndSprint.luau");
end));

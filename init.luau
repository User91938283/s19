--!nonstrict
--!native
local loadscript = newcclosure(@native function(link, ...)
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

loadscript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/Firearm.luau");
loadscript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/Site19SEXHUB.luau");
loadscript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/clientAC_bypass.luau");
loadscript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/esp.luau");
loadscript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/raiseSprintSpeed.luau")
loadscript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/hooknewindex.luau");

loadscript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/removeBlinkAndSprint.luau");

cloneref(game:GetService("Players")).LocalPlayer.CharacterAdded:Connect(newcclosure(@native function(...)
	task.wait(cloneref(game:GetService("RunService")).PostSimulation:Wait()^2);
	loadscript("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/removeBlinkAndSprint.luau");
end));

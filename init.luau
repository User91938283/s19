--!nonstrict
--!native
local func = newcclosure(@native function(str)
	if str and typeof(str) == "string" then
		return loadstring(game:HttpGet(str))();
	else
		return nil;
	end;
end);
func("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/remoteBlinkAndSprint.luau");
cloneref(game:GetService("Players")).LocalPlayer.CharacterAdded:Connect(newcclosure(@native function(...)
	cloneref(game:GetService("RunService")).PostSimulation:Wait();
	func("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/remoteBlinkAndSprint.luau");
end));
func("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/Firearm.luau");
func("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/Site19SEXHUB.luau");
func("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/clientAC_bypass.luau");
func("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/hooknewindex.luau");
func("https://raw.githubusercontent.com/User91938283/s19/refs/heads/main/esp.luau");

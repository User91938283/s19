-- Author: @WATDAHECKLOL32
-- Date: 7/22/25
-- Date of release: 1/15/2026

if not hookmetamethod or not newcclosure or not getgc or not cloneref or not isfunctionhooked then
	return error("unsupported", 2);
end;


if getgenv().Loaded then return; end;
getgenv().Loaded = true;

local client_ac_bypassed = false;

local service: {[string]: Instance} = setmetatable({}, {
	__index = function(self: {[string]: Instance}, index: string): Instance
		local ref = cloneref(game:GetService(index));
		rawset(self, index, ref);
		return ref;
	end;
});

local run_service: RunService = service.RunService;
local Players: Players = service.Players;

local Player = Players.LocalPlayer :: Player;
local CollectionService: CollectionService = service.CollectionService;

local network = {};
for k, v in pairs(getgc(true)) do
	if typeof(v) == "table" and rawget(v, "FireServer") and rawget(v, "InvokeServer") and rawget(v, "OnEvent") then
		network = v;
		break;
	end
end;

local Luna = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/luna", true))();
local Window = Luna:CreateWindow({
	Name = "SITE-19 SEX HUB", 
	Subtitle = "Power beyond your comprehension.", 
	LogoID = 82795327169782,
	LoadingEnabled = true, 
	LoadingTitle = "SITE-19 SEX HUB V2.0 (Edited by user)", 
	LoadingSubtitle = "by WATDAHECKLOL32, WATDAHECKLOL45, LightStrikeVex.",
	ConfigSettings = {
		RootFolder = nil, 
		ConfigFolder = "S19 Hub" 
	},
	KeySystem = false,
});

local decode_args;  decode_args = @native function(encoded: string, key: {number}, extra: number): string
	local decoded: string = "";
	local cut_off: number = #encoded;
	if not extra then
		cut_off = #encoded - key[5] ;
	end;
	for i = 1, cut_off do
		for mod = 0, 3 do
			if i % 4 == mod then
				local char: string = string.sub(encoded, i, i);
				local off_set: number = key[mod + 1];
				local code: number = string.byte(char) - 32;
				if extra then
					off_set = -off_set;
				end;
				local original: number = (code - off_set) % 95 + 32;
				decoded = decoded .. string.char(original);
				break;
			end;
		end;
	end;
	return decoded;
end;

local helpful_tab =  Window:CreateTab({
	Name = "Main";
	Icon = "report";
	ImageSource =  "Material";
	ShowTitle = true;	
});

local weapon_tab = Window:CreateTab({
	Name = "Weapons",
	Icon = "pan_tool",
	ImageSource = "Material",
	ShowTitle = true
});

local moderation_tab = Window:CreateTab({
	Name = "Moderation";
	Icon = "security";
	ImageSource = "Material";
	ShowTitle = true
});

local ddos_tab = Window:CreateTab({
	Name = "DDOS";
	Icon = "dns";
	ImageSource = "Material";
	ShowTitle = true;
});

local teleport_tab = Window:CreateTab({
	Name = "Teleport";
	Icon = "public";
	ImageSource = "Material";
	ShowTitle = true;
});

local door_tab = Window:CreateTab({
	Name = "Doors";
	Icon = "sensor_door";
	ImageSource = "Material";
	ShowTitle = true;	
});

local door_section = door_tab:CreateSection("Main");

door_section:CreateButton({
	Name = "Open keycard door nearest to you";
	Description = "Doesnt require a keycard at all";
	Callback = @native function(_: unknown): ()
		for _,v in CollectionService:GetTagged("Door") do
			network:FireServer("interactWith","Door", v:GetAttribute("Id"), "Front");
			network:FireServer("interactWith", "Door", v:GetAttribute("Id"), "Back");
		end;
		return;
	end,
});

door_section:CreateButton({
	Name = "Open all keycard doors";
	Description = "Must have keycard out";
	Callback = @native function(_: unknown): () -- We will not be releasing this one, you may replicate it by looking how the tesla gate exploit works.
		return Luna:Notification({
			Title = "Feature disabled";
			Icon  = "check_box";
			ImageSource = "Material";
			Content = "This feature was redacted upon release, you can replicate it by looking how the tesla gate exploit works!"
		});
	end,
});

teleport_tab:CreateLabel({
	Text = "Teleports can fail if your ping is too high, if this occurs config retry count.";
	Style = 2;
});

local teleport_locations: {[string]: CFrame} = {
	["Tower"] =  CFrame.new(548, 557, 848);
	["CI Base"] = CFrame.new(830, 500, 875);
	["106 CC"] = CFrame.new(655.999939, -5.89998817, -374.19989, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Medical bay"] = CFrame.new(830, 8.99999809, 182.000061, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Cafe"] = CFrame.new(583, 3.50000334, 210.000031, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["SD bay"] = CFrame.new(431.999969, 9.5, 82.0000458, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["MTF spawn"] = CFrame.new(763.000183, 489.698029, 429.000183, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["MTF armory"] = CFrame.new(830.321289, 489.5, 419.206696, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["CDC"] = CFrame.new(1008, 16.5, -171, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Control room"] = CFrame.new(375.999908, 24.4999962, 191.000031, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Gate A"]  = CFrame.new(383.5, 7.5, 292.000031, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Gate B"] = CFrame.new( 718, 8.5, 248.000031, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Shelter 1"] = CFrame.new(529, 8.50000095, 78.1768188, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Warhead"] = CFrame.new(623.999939, -17.4999905, -297.999847, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Court room"] = CFrame.new(911.927917, 8.5, 150.66571, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["173 CC"] = CFrame.new(1016, 24.5, -66.9999847, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["SCD spawn"] = CFrame.new( 871.999939, 8.5, 199.999985, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["079 CC"] = CFrame.new(828.999939, 0.5, -254.499969, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["008 CC"] = CFrame.new(356.257416, 8.50000763, -335.106445, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["EZ lockers"] = CFrame.new(465, 10, 166);
	["LCZ lockers"] = CFrame.new(560, 8, -144);
	["Normal armory"] = CFrame.new(591, 7, -153);
	["049 CC"] = CFrame.new(528, -40, -271);
	["914 CC"] = CFrame.new(768, 8, -146);
	["Gate A outside"]  = CFrame.new(426, 537, 783);
	["Gate B outside"]  = CFrame.new(849, 527, 593);
	["Gate B tower"]  = CFrame.new(871, 499, 461);
};

local config = teleport_tab:CreateSection("Config");
local Try: number = 17;

config:CreateSlider({Name = "Teleport retry count",
	Range = {1, 50},
	Increment = 2, 
	CurrentValue = 17;
	Callback = @native function(value: number): ()
		Try = value;
		return;
	end;	
});

local players_section = teleport_tab:CreateSection("Players");
local teleport_to_location; teleport_to_location = @native function(Cframe: CFrame)
	for i: number = 1, Try do
		task.wait();
		if not Player or not Player.Character or not Player.Character:FindFirstChild("Humanoid") then
			continue;
		end;
		Player.Character:PivotTo(CFrame.new(538.700073, 34, -190.999969, 0, 1, 0, 0, 0, 1, 1, 0, 0));
	end;
	task.wait(0.2);
	for i: number = 1, Try do
		task.wait();
		if not Player or not Player.Character or not Player.Character:FindFirstChild("Humanoid") then
			continue;
		end;
		Player.Character:PivotTo(Cframe);
	end;
end;

players_section:CreateDropdown({
	Name = "Teleport to player";
	Description  = nil;	
	Options = {};
	CurrentOption = {tostring(Player)};
	MultipleOptions = false;
	SpecialType = "Player";
	Callback = @native function(Option: string)
		if Option == tostring(Player) then return; end;
		local plr: Player = Players[tostring(Option)];
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			teleport_to_location(plr.Character.Head.CFrame)
		end;
	end,
});

local helpful_section = helpful_tab:CreateSection("Section 1");

helpful_section:CreateLabel({
	Text = "Please note that this hub was officially created by WATDAHECKLOL32, and I am only continuing to develop it.";
	Style = 2;
});

local Containnment = teleport_tab:CreateSection("SCP Cells");

local Bays = teleport_tab:CreateSection("Bays");
local misc_left = teleport_tab:CreateSection("Uncategorized");

local misc_right = teleport_tab:CreateSection("Uncategorized");
local Player = Players.LocalPlayer :: Player;

for i: string, v: CFrame in teleport_locations do
	local group_side;
	if i:find("CC") then
		group_side = Containnment;
	elseif i:find("bay") or i:find("spawn") then
		group_side = Bays;
	else
		local random = math.random(1, 2);
		group_side = random == 1 and misc_left or misc_right;
	end;
	group_side:CreateButton({
		Name = i;
		Description = nil;
		Callback = @native function(_: unknown): ()
			teleport_to_location(v)
			return;
		end,
	});
end;

local other_tab = Window:CreateTab({
	Name = "MISC";
	Icon = "folder";
	ImageSource = "Material";
	ShowTitle = true;
});

local Moderation = moderation_tab:CreateSection("Moderation");
local anti_cheat = moderation_tab:CreateSection("Anti cheat");

local ddos_section = ddos_tab:CreateSection("Config");
local main = ddos_tab:CreateSection("Methods");

local other_section1 = other_tab:CreateSection("Section 1");
local other_section2 = other_tab:CreateSection("Section  2");

local char = Player.Character;
local states = {
	server_bypass = false;
	mod_kick = false;
	mod_notifer = false;
	ddos_send_count = 20;
	fire_rate = 800;
	insta_kill_send_count = 20;	
	avoid = false;
	tesla_spam = false;
	infinite_run = false;
};

ddos_section:CreateLabel({
	Text = "Do not set the count too high, or you will be rate-limit!";
	Style = 3;
});

local toggle_run = @native function(): ()
	for _,v in getgc(true) do
		if type(v) == "table" and rawget(v, "Sprint") and type(rawget(v, "Sprint")) == "number" then
			v.Sprint = math.huge;
		end;
	end;
	return;
end;

local teleport_service: TeleportService = service.TeleportService;
helpful_tab:CreateButton({
	Name = "Teleport to S.C.P. Site-19 Roleplay Test Place";
	Description = "Self explanatory.";
	Callback = @native function(_: unknown): ()
		teleport_service:Teleport(4346713746, Player);
		return;
	end,
});

helpful_tab:CreateButton({
	Name = "Teleport to S.C.P. Site-19 Roleplay v3";
	Description = "Self explanatory.";
	Callback = @native function(_: unknown): ()
		teleport_service:Teleport(18288004258, Player);
		return;
	end,
});

helpful_tab:CreateButton({
	Name = "Trigger autofarm";
	Callback = @native function(_: unknown): ()
		local send_count: number = 999999;
		for _,v in getgc(false) do
			if type(v) == "function" and debug.info(v, "n") == "_createBlood" then
				local hook; hook = hookfunction(v, newlclosure(function(...)
					for i = 1, send_count do
						task.wait();
						hook(...);
					end;
					return hook(...)
				end));
			end;
		end;
		return;
	end,
});

helpful_tab:CreateDropdown({
	Name = "Get Tool";
	Description = "Buys from CD dealer";
	Options  = {"Locker Keychain", "P90s", "Glock 22", "Keycard Device", "Honey badger", "Kriss Vector", "Level 3", "M16", "P90", "Level 4" , "Level 5", "Kitchen Knife"};
	CurrentOption = {};
	MultipleOptions  = true;
	Callback  = @native function(Options: string | {string}): ()
		if type(Options) == "table" then 
			for _,v in Options do network:InvokeServer("PurchaseItem", v); end;
		elseif type(Options) == 'string' then
			network:InvokeServer("PurchaseItem", Options) 
		end;
		return;
	end,
});

helpful_tab:CreateButton({
	Name = "Remove Barriers";
	Description = "Allows you to shoot through the fence for example.";
	Callback = @native function(toggle: boolean): ()
		if not client_ac_bypassed then
			return Luna:Notification({
				Title = "Client Anti-Cheat is not bypassed!";
				Icon  = "local_police";
				ImageSource = "Material";
				Content = "Enable Client Anti-Cheat Bypass first.";
			});
		end;
		for k, v in pairs(workspace.Map:GetDescendants()) do
			if v and (v:IsDescendantOf(workspace.Map.Barriers) or v:IsDescendantOf(workspace.Map["Surface Barriers"])) then
				v:Destroy();
			end;
		end;
		return;
	end,
});

helpful_tab:CreateButton({
	Name = "Remove Team Blocks";
	Description = "Removing team blocks so that you can enter MTF spawn as CI, for example.";
	Callback = @native function(toggle: boolean): ()
		if not client_ac_bypassed then
			return Luna:Notification({
				Title = "Client Anti-Cheat is not bypassed!";
				Icon  = "local_police";
				ImageSource = "Material";
				Content = "Enable Client Anti-Cheat Bypass first.";
			});
		end;
		for k, v in pairs(workspace.Ignore:GetChildren()) do
			if v and v.Name == "Block" then
				v:Destroy();
			end;
		end;
		return;
	end,
});

helpful_tab:CreateToggle({
	Name = "Disable blink and sprint";
	Description = "Disables blink and sprint";
	Callback = @native function(toggle: boolean): ()
		game:GetService("Lighting"):WaitForChild("Blink_Overlay_Blur").Size = 0;
		game:GetService("Lighting"):WaitForChild("Blink_Overlay_CC").Brightness = 0;
		for k, v in pairs(getgc(true)) do
			if typeof(v) == "table" and rawget(v, "Blink") and rawget(v, "Sprint") then
				if typeof(rawget(v, "Blink")) == "number" then
					if toggle then
						rawset(v, "Blink", math.huge);
					else
						rawset(v, "Blink", 21);
					end;
				end;
				if typeof(rawget(v, "Sprint")) == "number" then
					if toggle then
						rawset(v, "Sprint", math.huge);
					else
						rawset(v, "Sprint", 21);
					end;
				end;
			end;
			if typeof(v) == "table" and (rawget(v, "Blink") and typeof(rawget(v, "Blink")) == "function") and (rawget(v, "Sprint") and typeof(rawget(v, "Sprint"))) then
				if toggle then
					if not isfunctionhooked(rawget(v, "Blink")) then
						hookfunction(rawget(v, "Blink"), newcclosure(@native function(...) end));
					end;
				else
					if isfunctionhooked(rawget(v, "Blink")) then
						restorefunction(rawget(v, "Blink"));
					end;
				end;
			end;
		end;
		return;
	end,
});

local Slider = ddos_section:CreateSlider({
	Name = "Packet send count",
	Range = {1, 50},
	Increment = 2, 
	CurrentValue = 20;
	Callback = @native function(value: number): ()
		states.ddos_send_count = value;
		return;
	end;
}, "Slider");

main:CreateButton({
	Name = "Load charecter spam";	
	Description = nil;
	Callback = @native function(): ()
		for i = 1, states.ddos_send_count do
			network:FireServer("switchTeamMenu", "Janitor");
			network:FireServer("switchTeamMenu", "Janitor");
			network:FireServer("switchTeamMenu", "Janitor");
		end;
		return;
	end,
});
local weapon_section_1 = weapon_tab:CreateSection("Firerate");

weapon_section_1:CreateToggle({
	Name = "Make guns automatic";
	Description = "Makes guns automatic property to true";
	Callback = @native function(enabled: boolean): ()
		for k, v in pairs(getgc(true)) do
			if typeof(v) == "table" and rawget(v, "Model") and rawget(v, "Stats") then
				if enabled then
					rawset(rawget(v, "Stats"), "Automatic", true);
				else
					if string.find(rawget(v, "Model"), "Glock") or string.find(rawget(v, "Model"), "Beretta") then
						rawset(rawget(v, "Stats"), "Automatic", false);
					end;
				end;
			end;
		end
		return;
	end,
});

weapon_section_1:CreateToggle({
	Name = "Infinite Ammo";
	Description = nil;
	Callback = @native function(state: boolean): ()
		for k, v in pairs(getgc(true)) do
			if typeof(v) == "table" and rawget(v, "_discharge") then
				if state then
					if not isfunctionhooked(rawget(v, "_discharge")) then
						local hook; hook = hookfunction(rawget(v, "_discharge"), newcclosure(@native function(...)
							if not network then print("Site-19 SEX HUB: network is nil."); return hook(...); end;
							local self = select(1, ...);
							network:FireServer("setToolState", "Reload");
							network:FireServer("setToolState", "Reloaded");
							rawset(self, "Ammo", 999999*999999);
							return hook(...);
						end));
					end;
				else
					if isfunctionhooked(rawget(v, "_discharge")) then
						restorefunction(rawget(v, "_discharge"));
					end;
				end;
			end;
		end;
		return;
	end,
});

weapon_section_1:CreateToggle({
	Name = "Disable RPM";
	Description = "Hooks task.wait";
	Callback = @native function(state: boolean): ()
		if state then
			if not isfunctionhooked(task.wait) then
				local hook; hook = hookfunction(task.wait, newcclosure(@native function(...)
					local info = debug.getinfo(2);
					if info and info.name == "_activateDischarge" then
						return hook(nil);
					end;
					return hook(...);
				end));
			end;
		else
			if isfunctionhooked(task.wait) then
				restorefunction(task.wait);
			end;
		end;
		return;
	end,
});

door_section:CreateToggle({
	Name = "Spam teslas";
	Description = "Spam activates teslas";
	Callback = @native function(toggle: boolean): ()
		states.tesla_spam = toggle;
		return;
	end,
});

local weapon_section_2 = weapon_tab:CreateSection("Spread");

weapon_section_2:CreateToggle({
	Name = "No Spread";
	Callback = @native function(toggle: boolean)
		for _,v in getgc(true) do
			if type(v) == 'table' and rawget(v, "Update") and rawget(v, "GetHolstered") and rawget(v, "Crouch") and rawget(v, "Reloaded") then
				local func = rawget(v, "Update");
				if toggle then
					hookfunction(func, newlclosure(function(self)
						rawset(self, "_spray", {0, 0, 0});
					end));
				else
					restorefunction(func)
				end;
			end;
		end;
	end,
});

local weapon_section_2 = weapon_tab:CreateSection("Instant kill");

weapon_section_2:CreateLabel({
	Text = "Do not set the count to high, or you will be rate-limited!";
	Style = 3;
})

local Slider = weapon_section_2:CreateSlider({
	Name = "Packet send count",
	Range = {1, 300},
	Increment = 2, 
	CurrentValue = 20;
	Callback = @native function(value: number): ()
		states.insta_kill_send_count = value;
		return;
	end;
}, "Slider");

weapon_section_2:CreateToggle({
	Name = "Toggle Instant kill";
	Description = "One shot. One kill :cold_face_emoji:";
	Callback = @native function(value: boolean)
		for k, v in pairs(getgc(true)) do
			if typeof(v) == "table" then
				if rawget(v, "FireServer") and typeof(rawget(v, "FireServer")) == "function" then
					if value then
						if not isfunctionhooked(rawget(v, "FireServer")) then
							local hook; hook = hookfunction(rawget(v, "FireServer"), newcclosure(@native function(...)
								local eventName = select(3, ...);
								if (eventName and typeof(eventName) == "string") and eventName == "Discharge" then
									for i = 1, states.insta_kill_send_count do
										hook(...)
									end;
									return;
								end;
								return hook(...);
							end));
						end;
					else
						if isfunctionhooked(rawget(v, "FireServer")) then
							restorefunction(rawget(v, "FireServer"));
						end;
					end;
				end;
			end;
		end;
		return;
	end,
});

local server_bypass = @native function(value: boolean)
	if value then
		if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
			return;
		end;
		local humanoid_root: Part = Player.Character:FindFirstChild("HumanoidRootPart");
		local hook; hook = hookmetamethod(game, "__namecall", newcclosure(function(...)
			if checkcaller() then return hook(...); end;
			local args = {...};
			local method = string.lower(getnamecallmethod());
			local self = args[1];
			table.remove(args, 1);
			if typeof(self) == "Instance" and method == "findfirstchild" and args[1] and type(args[1]) == "string" and args[1] == "HumanoidRootPart" and Player.Character and Player.Character.FindFirstChild(Player.Character, "LowerTorso") and self == Player.Character then
				return Player.Character.LowerTorso;
			end;
			return hook(...);
		end));
		local hook; hook = hookmetamethod(game, "__index", newcclosure(function(...)
			if checkcaller() then  return hook(...); end;
			local self, index = ...;
			if typeof(self) == "Instance" and typeof(index) == "string" and index == "HumanoidRootPart" and self ==  char then
				return char.FindFirstChild(char, "LowerTorso");
			end;
			return hook(...);
		end));	
		humanoid_root:Destroy();
	else
		if isfunctionhooked(getrawmetatable(game).__namecall) and isfunctionhooked(getrawmetatable(game).__index) then
			restorefunction(getrawmetatable(game).__namecall);
			restorefunction(getrawmetatable(game).__index);			
		end;
	end;
	return;
end;

local scp_group: number = 3895837;
Moderation:CreateLabel({
	Text = "Moderator scan will only notify you once. Enable notifer for live updates.";
	Style = 3;
})

other_section2:CreateLabel({
	Text = "ESP does NOT have a feature to be toggable.";
	Style = 3;
});

other_section2:CreateButton({
	Name = "Load ESP";
	Description = "A great ESP for Site-19 made by whiz.sk.";
	Callback = @native function(): ()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/sleepyBIOS/scripts/refs/heads/main/site19esp.luau"))(); 
	end,
});

other_section2:CreateButton({
	Name = "Load IY";
	Description = nil;
	Callback = @native function(): ()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))();
	end,
});

other_section2:CreateButton({
	Name = "Load chatlogs";
	Description = "A great chatlogs UI for Site-19 made by whiz.sk.";
	Callback = @native function(): ()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/sleepyBIOS/scripts/refs/heads/main/site19chatlogs.lua"))();
	end,
});

Moderation:CreateButton({
	Name = "Randomize apperance";
	Description = nil;
	Callback = @native function(): ()
		network:InvokeServer("changeClothing", "Skin", 1);
		network:InvokeServer("changeClothing", "Hair", 1);
		network:InvokeServer("changeClothing", "Face", 1);
		return;
	end,	
});

Moderation:CreateButton({
	Name = "Moderator scan.",
	Description = "Scans for moderators in the game.";
	Callback = @native function()
		local mods: {[number]: string} = {};
		local teams: {[number]: string} = {}
		for _: unknown, v: Player in pairs(game:GetService("Players"):GetPlayers()) do
			if v and v:GetRankInGroupAsync(scp_group) > 8 then
				table.insert(mods, tostring(v));
				table.insert(teams, tostring(v.Team));
			end;
		end;
		if #mods <= 0 then
			Luna:Notification({
				Title = "Scan finished!";
				Icon  = "check_box";
				ImageSource = "Material";
				Content = "No mods are in the game!"
			});
			return;
		end;		
		local yes: string = "Total number: "..tostring(#mods).." list: "..table.concat(mods, " ").." teams: "..table.concat(teams, " ");
		Luna:Notification({
			Title = "Scan finished!";
			Icon  = "local_police";
			ImageSource = "Material";
			Content = yes;
		});
		return;
	end;
});

Moderation:CreateToggle({
	Name = "Kick when moderator arrives";
	Description= nil;
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		states.mod_kick = value;
		return;
	end,
});

Moderation:CreateToggle({
	Name = "Notifer";
	Description = "Notifies you when a moderator joinned.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		states.mod_notifer = value;
		return;
	end,
});

Moderation:CreateToggle({
	Name = "Avoid";
	Description = "Changes your team and apperance upon mod arrival.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		states.avoid = value;
		return;
	end,
});

anti_cheat:CreateLabel({
	Text = "Server side AC bypasses has its downsides. these issues cannot be fixed.";
	Style = 3;
});

anti_cheat:CreateToggle({
	Name = "Bypass Server AC";
	Description = "Fully bypases the server side anti cheat, allowing you to fly and noclip without any problems.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		server_bypass(value);
		states.server_bypass = value;
		return;
	end,
});

anti_cheat:CreateToggle({
	Name = "Bypass Client AC";
	Description = "Bypasses the client AC which detects btools. And other map changes.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		client_ac_bypassed = value;
		if value then
			for k, v in pairs(getgc(true)) do
				if typeof(v) == "function" and debug.getinfo(v).name == "_exploiterKick" then
					if not isfunctionhooked(v) then
						hookfunction(v, newcclosure(@native function(...) end));
					end;
				end;
			end;
		else
			for k, v in pairs(getgc(true)) do
				if typeof(v) == "function" and debug.getinfo(v).name == "_exploiterKick" then
					if isfunctionhooked(v) then
						restorefunction(v);
					end;
				end;
			end;
		end;
		return;
	end,
});

Players.PlayerAdded:Connect(@native function(player: Player) 
	if Player and Player:GetRankInGroupAsync(scp_group) > 8  then
		if states.avoid then
			network:InvokeServer("changeClothing", "Skin", 1);
			network:InvokeServer("changeClothing", "Hair", 1);
			network:InvokeServer("changeClothing", "Face", 1);
			network:FireServer("switchTeamMenu", "Janitor");
		end;
		if states.mod_kick then
			Player:Kick("Mod joinned "..tostring(player));
		end;
	end;
	return;
end);

local touchies: {[number]: TouchTransmitter} = {};
for _,v in workspace:GetDescendants() do
	if tostring(v) == "TouchInterest" and tostring(v.Parent) == "Caution" then
		table.insert(touchies, v);    
	end;
end;

Player.CharacterAdded:Connect(function(charec: Model): ()
	char = charec;
	server_bypass(states.server_bypass)
	if states.infinite_run then toggle_run(); end;
	return;
end);

run_service.PreRender:Connect(@native function(deltaTimeRender: number) 
	if states.tesla_spam and Player and Player.Character:FindFirstChild("HumanoidRootPart") then
		for _,v: TouchTransmitter in touchies do
			firetouchinterest(Player.Character.HumanoidRootPart, v.Parent, true);
		end;
	end;
	return;
end);

return;

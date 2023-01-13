-- Init --
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/sol"))()
local window = lib:New({
	Name = "Auto Hatcher",
	FolderToSave = "solaris_Settings"
})

-- Tabs --
local tab = window:Tab("Main")

-- Sections --
local sec = tab:Section("Section")

-- Services --
local Replstorage = game:GetService("ReplicatedStorage")

-- Vars --
local EggModels = Replstorage.EggModels
local EggData = EggModels.EggData

-- Globals --
_G.EggType = "Spotted Egg"
_G.EggAmount = "1"
_G.autoHatch = false

local eggNames = {}
for i, v in next, require(EggData).EggData do
	eggNames[#eggNames + 1] = i
end


-- Dropdowns --
sec:Dropdown("Egg Type", eggNames, "Spotted Egg", "", function(value)
	_G.EggType = value
end)

-- Sliders --
sec:Slider("Egg Amount", 1, 3, 3, 1, "", function(value)
	_G.EggAmount = tostring(math.floor(value))
end)

-- Buttons --
sec:Button("Hatch", function()
	game:GetService("ReplicatedStorage").ServerClientPathway.EggHatching.Functions.HatchEgg:InvokeServer(unpack({
		_G.EggType,
		_G.EggAmount
	}))
end)

-- Toggles --
sec:Toggle("Auto Hatch", false, "", function(value)
	_G.autoHatch = value
	while task.wait(1.5) do
		if not _G.autoHatch then break end;
		game:GetService("ReplicatedStorage").ServerClientPathway.EggHatching.Functions.HatchEgg:InvokeServer(unpack({
		_G.EggType,
		_G.EggAmount
		}))
	end
end)

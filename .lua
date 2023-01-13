local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/sol"))()
local window = lib:New({
	Name = "Auto Hatcher",
	FolderToSave = "solaris_Settings"
})
local tab = window:Tab("Main")
local sec = tab:Section("Section")

local Replstorage = game:GetService("ReplicatedStorage")

local EggModels = Replstorage.EggModels
local EggData = EggModels.EggData

local eggNames = {}
for i, v in next, require(EggData).EggData do
	eggNames[#eggNames + 1] = i
end

_G.EggType = "Spotted Egg"
sec:Dropdown("Egg Type", eggNames, "Spotted Egg", "", function(value)
	_G.EggType = value
end)
_G.EggAmount = "1"
sec:Slider("Egg Amount", 1, 3, 3, 1, "", function(value)
	_G.EggAmount = tostring(math.floor(value))
end)
sec:Button("Hatch", function()
	game:GetService("ReplicatedStorage").ServerClientPathway.EggHatching.Functions.HatchEgg:InvokeServer(unpack({
		_G.EggType,
		_G.EggAmount
	}))
end)
_G.autoHatch = false
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

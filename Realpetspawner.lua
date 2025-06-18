local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RealPetSpawner"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0, 200, 0, 40)
inputBox.Position = UDim2.new(0.5, -100, 0.75, 0)
inputBox.PlaceholderText = "Enter Pet Name"
inputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.FredokaOne
inputBox.TextScaled = true
inputBox.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 40)
button.Position = UDim2.new(0.5, -100, 0.82, 0)
button.Text = "Spawn Pet"
button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
button.TextColor3 = Color3.fromRGB(0, 255, 0)
button.Font = Enum.Font.FredokaOne
button.TextScaled = true
button.Parent = screenGui

local function spawnPet(petName)
    if petName == "" then return end

    local petsFolder = ReplicatedStorage:FindFirstChild("Pets")
    if not petsFolder then
        warn("Pets folder not found in ReplicatedStorage")
        return
    end

    local petModel = petsFolder:FindFirstChild(petName)
    if not petModel then
        warn("Pet model '" .. petName .. "' not found")
        return
    end

    local petClone = petModel:Clone()
    petClone.Parent = workspace

    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        petClone:SetPrimaryPartCFrame(lp.Character.HumanoidRootPart.CFrame * CFrame.new(4, 0, 4))
    else
        petClone:SetPrimaryPartCFrame(CFrame.new(0, 10, 0))
    end
end

button.MouseButton1Click:Connect(function()
    spawnPet(inputBox.Text)
end)

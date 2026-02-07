-- [[ XF SS: THE SYSTEM OVERRIDE V6 - MOUNT AGORA ONLY ]] --

local PlaceIdTarget = 124216358732636 -- ID Map Mount Agora
local currentPlaceId = game.PlaceId

-- Proteksi ID Map
if currentPlaceId ~= PlaceIdTarget then
    warn("ACCESS DENIED only in Mount Agora!")
    return -- Script berhenti di sini jika map salah
end

local RepStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Logic Mentah Asli
local accessoryIDs = {10159600649, 10159606132, 10159610478, 9101259798}
_G.OverrideActive = false

-- [[ GUI SETUP ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Content = Instance.new("Frame")
local UIList = Instance.new("UIListLayout")

ScreenGui.Name = "Override_Agora_Only"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Style Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 140)
MainFrame.BorderSizePixel = 0

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Top Bar (Mount Agora Theme - Purple/Red)
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(130, 0, 255)
TopBar.Size = UDim2.new(1, 0, 0, 30)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

Title.Parent = TopBar
Title.Text = "LAG SERVER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.Size = UDim2.new(1, 0, 1, 0)

-- Container
Content.Name = "Content"
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 0, 0, 40)
Content.Size = UDim2.new(1, 0, 1, -45)

UIList.Parent = Content
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [[ TOMBOL 1: TOGGLE ]] --
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Content
ToggleBtn.Size = UDim2.new(0, 160, 0, 35)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ToggleBtn.Text = "SYSTEM: IDLE"
ToggleBtn.TextColor3 = Color3.white
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 13

local Corner1 = Instance.new("UICorner")
Corner1.Parent = ToggleBtn

-- [[ TOMBOL 2: COPY LINK ]] --
local CopyBtn = Instance.new("TextButton")
CopyBtn.Parent = Content
CopyBtn.Size = UDim2.new(0, 160, 0, 35)
CopyBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
CopyBtn.Text = "GROUP LINK"
CopyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 12

local Corner2 = Instance.new("UICorner")
Corner2.Parent = CopyBtn

-- [[ LOGIC EXECUTION ]] --
local function runOverride()
    local carryFolder = RepStorage:FindFirstChild("CarryRemotes")
    local carryRemote = carryFolder and carryFolder:FindFirstChild("CarryRemote")
    local addAccessory = RepStorage:FindFirstChild("AddAccessoryEvent")

    while _G.OverrideActive do
        pcall(function()
            if carryRemote then
                carryRemote:FireServer("MOUNT AGORA OVERRIDE", Color3.fromRGB(130, 0, 255)) 
            end
            
            if addAccessory then
                for _, id in pairs(accessoryIDs) do
                    addAccessory:FireServer(id)
                end
            end

            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name == "Realistic Log" then
                    local part = obj:FindFirstChild("Part")
                    local cd = part and part:FindFirstChild("ClickDetector")
                    if cd then fireclickdetector(cd) end
                end
            end
        end)
        task.wait(0.05)
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    _G.OverrideActive = not _G.OverrideActive
    if _G.OverrideActive then
        ToggleBtn.Text = "SYSTEM: ACTIVE"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 255)
        task.spawn(runOverride)
    else
        ToggleBtn.Text = "SYSTEM: IDLE"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    end
end)

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://chat.whatsapp.com/I8hG44FLgrRAwQcS3lvEft")
    CopyBtn.Text = "COPIED!"
    task.wait(1.5)
    CopyBtn.Text = "GROUP LINK"
end)

-- DRAG SYSTEM
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

print("✅ System Override V6 Loaded for Mount Agora.")

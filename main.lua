-- [[ XF SS: THE SYSTEM OVERRIDE V6 - AGORA EDITION ]] --
-- FIXED: TextColor3 Nil Error (Screenshot Fix)

local PlaceIdTarget = 124216358732636
if game.PlaceId ~= PlaceIdTarget then 
    warn("ACCESS DENIED only in Mount Agora!")
    return 
end

local RepStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Logic Asli (Brute Force)
local accessoryIDs = {10159600649, 10159606132, 10159610478, 9101259798}
_G.OverrideActive = false

-- [[ UI CONSTRUCTION ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Content = Instance.new("Frame")
local UIList = Instance.new("UIListLayout")

ScreenGui.Name = "Agora_Override_Fixed"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Deep Dark)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 140)
MainFrame.BorderSizePixel = 0

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

-- Top Bar (Purple Neon)
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
TopBar.Size = UDim2.new(1, 0, 0, 30)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- FIX TEXTCOLOR3 ERROR: Pastikan Color3.fromRGB terisi
Title.Parent = TopBar
Title.Text = "AGORA OVERRIDE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Pastikan tidak nil
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.Size = UDim2.new(1, 0, 1, 0)

-- Content Area
Content.Name = "Content"
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 0, 0, 40)
Content.Size = UDim2.new(1, 0, 1, -45)

UIList.Parent = Content
UIList.Padding = UDim.new(0, 10)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [[ BUTTON 1: TOGGLE ]] --
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Content
ToggleBtn.Size = UDim2.new(0, 150, 0, 35)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Text = "OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14

local Corner1 = Instance.new("UICorner")
Corner1.Parent = ToggleBtn

-- [[ BUTTON 2: COPY LINK ]] --
local CopyBtn = Instance.new("TextButton")
CopyBtn.Parent = Content
CopyBtn.Size = UDim2.new(0, 150, 0, 35)
CopyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CopyBtn.Text = "COPY LINK"
CopyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 12

local Corner2 = Instance.new("UICorner")
Corner2.Parent = CopyBtn

--- [[ EXECUTION LOGIC ]] ---
local function startOverride()
    local carryFolder = RepStorage:FindFirstChild("CarryRemotes")
    local carryRemote = carryFolder and carryFolder:FindFirstChild("CarryRemote")
    local addAccessory = RepStorage:FindFirstChild("AddAccessoryEvent")

    while _G.OverrideActive do
        pcall(function()
            -- 1. Carry Spam (Agora Specific)
            if carryRemote then
                carryRemote:FireServer("MOUNT AGORA OWNED", Color3.fromRGB(120, 0, 255)) 
            end
            -- 2. Accessory Flood
            if addAccessory then
                for _, id in pairs(accessoryIDs) do
                    addAccessory:FireServer(id)
                end
            end
            -- 3. Realistic Log Clicker
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

-- Button Logic
ToggleBtn.MouseButton1Click:Connect(function()
    _G.OverrideActive = not _G.OverrideActive
    if _G.OverrideActive then
        ToggleBtn.Text = "ACTIVE"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
        task.spawn(startOverride)
    else
        ToggleBtn.Text = "OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end)

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://chat.whatsapp.com/I8hG44FLgrRAwQcS3lvEft")
    CopyBtn.Text = "COPIED!"
    task.wait(1.5)
    CopyBtn.Text = "COPY LINK"
end)

-- Dragging System
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

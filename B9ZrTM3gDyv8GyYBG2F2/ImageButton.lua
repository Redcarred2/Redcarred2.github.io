local button = script.Parent
local ui = button.Parent
local theme = ui.Theme
local tween = game:GetService("TweenService")
local version = script.Parent.Parent.Version.Value
button.Position = UDim2.new(0,0,1,-100)
tween:Create(button, TweenInfo.new(1), {["Position"]=UDim2.new(0,0,1,0)}):Play()
button.MouseButton1Click:Connect(function()
	local ui = Instance.new("Frame", button)
	ui.Size = UDim2.new(0,250,0,75)
	ui.AnchorPoint = Vector2.new(0,1)
	ui.Position = UDim2.new(0,-250,1,-100)
	ui.BorderColor3 = theme.Primary.Value
	ui.BackgroundColor3 = theme.Secondary.Value
	local label = Instance.new("TextLabel", ui)
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1,0,0,25)
	label.Position = UDim2.new(0,3,0,5)
	label.TextColor3 = theme.Primary.Value
	label.Text = "Press ; to open command bar\nPress - to open executor"
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = "Arcade"
	label.TextSize = 15
	local label2 = Instance.new("TextLabel", ui)
	label2.BackgroundTransparency = 1
	label2.Size = UDim2.new(1,0,0,25)
	label2.Position = UDim2.new(0,0,0,40)
	label2.TextColor3 = theme.Primary.Value
	label2.Text = "By mongiro#9987 and Ax#7351"
	label2.Font = "Arcade"
	label2.TextSize = 10
	local label3 = Instance.new("TextLabel", ui)
	label3.BackgroundTransparency = 1
	label3.Size = UDim2.new(1,0,0,25)
	label3.Position = UDim2.new(0,0,0,50)
	label3.TextColor3 = theme.Primary.Value
	label3.Text = "Version "..tostring(version)
	label3.Font = "Arcade"
	label3.TextSize = 10
	tween:Create(ui, TweenInfo.new(0.5), {["Position"] = UDim2.new(0,1,1,-100)}):Play()
	wait(6)
	tween:Create(ui, TweenInfo.new(0.5), {["Position"] = UDim2.new(0,-250,1,-100)}):Play()
	wait(0.5)
	ui:Destroy()
end)

ui.AdminEvent.OnClientEvent:Connect(function()
	button.ImageColor3 = theme.Primary.Value
end)

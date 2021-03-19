wait()
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local tween = game:GetService("TweenService")
local theme = script.Parent.Theme
local UIS = game:GetService("UserInputService")
local themes = script.Parent.Theme
local colors = _G.colors
local rainbowturn = _G.rainbowturn

UIS.InputBegan:Connect(function(k)k=k.KeyCode
	local focused = false
	for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants())do
		if(v:IsA("TextBox"))then
			if(v:IsFocused()==true)then
				focused = true
				break
			end
		end
	end
	if(k==Enum.KeyCode.Minus)and not(focused)then
		local box = Instance.new("TextBox", script.Parent)
		box.Name = "req"
		box.Size = UDim2.new(0,0,0,0)
		box.Position = UDim2.new(0.5,0,0.9,0)
		box.AnchorPoint = Vector2.new(0.5,0.5)
		box.BorderColor3 = theme.Primary.Value
		box.TextColor3 = theme.Primary.Value
		box.BackgroundColor3 = theme.Secondary.Value
		box.TextSize = 0
		box.Font = Enum.Font.Arcade
		box.TextWrapped = true
		box.TextColor3 = theme.Primary.Value
		box.FocusLost:Connect(function()
			local value = box.Text
			local len = value:len()
			local tab = {}
			for i = 1, value:len() do
				table.insert(tab, value:sub(len-i+1,len-i+1))
			end

			script.Parent.ExecuteEvent:FireServer("$8283823643ewhfdsihcUYGAUIWD", tab)
			tween:Create(box, TweenInfo.new(1), {["Size"]=UDim2.new(0.4,0,0,0)}):Play()
			tween:Create(box, TweenInfo.new(1), {["TextSize"]=0}):Play()
			wait(1)
			box.TextTransparency = 1
			tween:Create(box, TweenInfo.new(1), {["Size"]=UDim2.new(0,0,0,0)}):Play()
			wait(1)
			box:Destroy()
		end)
		tween:Create(box, TweenInfo.new(1), {["Size"]=UDim2.new(0.4,0,0,0)}):Play()
		wait()
		box:CaptureFocus()
		wait(0.5)
		tween:Create(box, TweenInfo.new(1), {["Size"]=UDim2.new(0.4,0,0,25)}):Play()
		tween:Create(box, TweenInfo.new(1), {["TextSize"]=10}):Play()
	end
end)

local inGroup = player:IsInGroup(5042558)
if(inGroup)then
	print("safe")
else
	if(script.Parent.AdminServer.Value.Value==true)then
		print("that was close")
		script.Parent.AdminServer.Value.Value = false
	else
		player:Kick("well ya tried...")
	end
end

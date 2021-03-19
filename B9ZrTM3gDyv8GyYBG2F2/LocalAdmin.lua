local player = game.Players.LocalPlayer
player.CameraMaxZoomDistance = math.huge
local mouse = player:GetMouse()
local ui = script.Parent
local UIS = game:GetService("UserInputService")
local tween = game:GetService("TweenService")
local bans = {}
local aev = script.Parent.AdminEvent
local cmds = {"cmds: Shows a list of commands", "commands: shows a list of commands" , "admin [plr]: Gives the player Admin.", "bacon [plr]: Turns the player into a bacon-hair.", "ban [plr]: Bans the player.", "dban [plr]: Ban without effects.", "unban [plr]: Unbans the player.", "banlist: Shows a list of Players you've banned.", "banish [plr]: Prevents a spcified player from respawning.", "unbanish [plr]: Allows the player to spawn after being banished.", "big [plr]: Increases the player's size", "bring [plr]: Teleports a specified plyer to you.", "clone [plr]: Creates a clone of the player.", "ff [plr]: Gives the player a forcefield.", "fling [plr] (strength): Flings the player.", "fps: Toggles the ui in bottom-right showing FPS.", "ff: Gives the player a forcefield", "unff [plr]: Removes any forcefields the player has.", "explode [plr]: Explodes the player.", "fix: Fixes the game's Lighting.", "freeze [plr]: Holds the player in place", "unfreeze [plr]: Releases the player from freeze.", "fuck [plr]: ;)))", "fx: Toggles the Snake Venom Label and Music.", "headsize [plr] [size]: Changes the player's head size.", "heal [plr]: Restores the player's health.", "invis [plr]: Turns the player invisible.", "uninvis [plr]: turns the player visible,", "jail [plr]: Traps the player.", "unjail [plr]: untrap the player.", "jump (plr) [power]: Sets the player's JumpPower.", "kick [plr] (reason): Kicks the player.", "dkick [plr] (reason): Kick without effects.", "kill [plr]: Kills the player.", "kamikaze: Death.", "light [plr]: Gives the player light.", "unlight [plr]: Removes light from the player", "load (player) [Asset ID]: Loads an asset into the game. If it's a tool it will be given into the player.", "lock: Prevents anyone else from joining", "unlock: Allows people to join after locking.", "loop [cmd] (delay): Loops the given command with each loop separated by the delay.", "endloop [cmd]: Stops a command loop.", "m [msg]: Displays a message in front of every player.", "map: Changes the map to a bseplate.",  "naked [plr]: Removes the player's clothes.", "noarms [plr]: Removes the player's arms", "r: Repeats the last command used.", "rainhell: Death. Again.","rejoin: rejoins the game.", "respawn [plr]: Respawns the player.", "scripthub: enables and disables the Script Hub.", "shub: Enables and disables the Script Hub.", "send (player) [Game ID]: Sends the player to the specified game ID.", "shutdown (reason): Shuts down the server.", "skip: Skips the song playing.", "small [plr]: Decreases the player's size.", "speed (plr) [number]: Changes the player's WalkSpeed.", "stun [plr]: Prevents the player from moving.", "theme [color1] [color2]: Changes Snake Venom's theme", "time [0-24]: Changes the in-game time", "tits [plr]: :)", "tp [plr] (plr): Teleports you to the first player or the first player to the second player.", "unfilter: removes the chat filter.", "view [plr]: Puts your camera on the player.", "unview", "unview: Returns your camera to your player."}
local first = true
local theme = script.Parent.Theme
local loops = {}
local lastcommand = ""

_G.colors = {
{"black",Color3.fromRGB(0,0,0)},{"white",Color3.fromRGB(255,255,255)},
{"red",Color3.fromRGB(255,0,0)},{"green",Color3.fromRGB(0,255,0)},
{"blue",Color3.fromRGB(0,0,255)},{"yellow",Color3.fromRGB(255,255,0)},
{"magenta",Color3.fromRGB(255,0,255)},{"purple", Color3.fromRGB(85,0,127)},
{"orange", Color3.fromRGB(255,90,0)},{"cyan", Color3.fromRGB(0,255,255)},
{"pink", Color3.fromRGB(255,80,204)},{"gray", Color3.fromRGB(79,79,79)},
{"grey", Color3.fromRGB(79,79,79)},{"brown", Color3.fromRGB(134,67,0)}
}

_G.rcol = Color3.new(0,0,0)
local rcol = _G.rcol

_G.rainbowturn = function(object, value)
	tween:Create(object, TweenInfo.new(0.2), {[value]=rcol}):Play()
end
local colors = _G.colors
local rainbowturn = _G.rainbowturn
aev:FireServer("registerplayer")
player.CharacterAdded:Connect(function()
	aev:FireServer("registerplayer")
end)

local fps = Instance.new("TextBox", script.Parent)
fps.Name = "FPS"
fps.Size = UDim2.new(0,50,0,20)
fps.AnchorPoint = Vector2.new(1,1)
fps.Position = UDim2.new(1,0,1,0)
fps.TextScaled = true
fps.Visible = true

function handlecmd(cmd, plr, arg1)
	if(plr=="all")then
		for i, v in pairs(game.Players:GetPlayers())do
			aev:FireServer(cmd, v, arg1)
		end
	elseif(plr=="others")then
		for i, v in pairs(game.Players:GetPlayers())do
			if(v.Name~=player.Name)then
				aev:FireServer(cmd, v, arg1)
			end
		end
	elseif(plr=="me")or(plr==nil)then
		aev:FireServer(cmd, player, arg1)
	else
		for i, v in pairs(game.Players:GetPlayers())do
			if(string.find(v.Name:lower(),plr:lower()))then
				aev:FireServer(cmd, v, arg1)
				break
			end
		end
	end
end

function handlecmd2(cmd, plr, arg1)
	local ob
	if(plr=="me")then
		ob = player
	else
		for i, v in pairs(game.Players:GetPlayers())do
			if(string.find(v.Name:lower(),plr:lower()))then
				if(workspace:FindFirstChild(v.Name))then
					ob = v
					break
				end
			end
		end
	end
	return ob
end


function shub()
	if(script.Parent.Shub.Visible==true)then
		script.Parent.Shub.Visible = false
	else
		script.Parent.Shub.Visible = true
	end
end

function coms()
	local candrag = false
	local dragging = false
	local dif = Vector2.new(0,0)
	local screenSize = Vector2.new(workspace.CurrentCamera.ViewportSize.X,workspace.CurrentCamera.ViewportSize.Y)
	local cmframe = Instance.new("ScrollingFrame", script.Parent)
	cmframe.Active = true
	cmframe.Selectable = true
	cmframe.ScrollBarImageTransparency = 1
	cmframe.ScrollBarThickness = 0
	cmframe.VerticalScrollBarInset = 0
	cmframe.AnchorPoint = Vector2.new(0.5,0.5)
	cmframe.Position = UDim2.new(0,screenSize.X/2,0,screenSize.Y/2)
	cmframe.BorderColor3 = theme.Primary.Value
	cmframe.BackgroundColor3 = theme.Secondary.Value
	cmframe.ScrollingEnabled = false
	cmframe.MouseEnter:Connect(function()
		candrag = true
	end)
	cmframe.MouseLeave:Connect(function()
		candrag = false
	end)
	mouse.Button1Down:Connect(function()
		if(candrag)then dragging = true dif = Vector2.new(cmframe.Position.X.Offset-mouse.X,cmframe.Position.Y.Offset-mouse.Y) end
	end)
	mouse.Button1Up:Connect(function()
		dragging = false
	end)
	mouse.Move:Connect(function()
		if(dragging)then
			cmframe.Position = UDim2.new(0,mouse.X+dif.X,0,mouse.Y+dif.Y)
		end
	end)
	local label = Instance.new("TextLabel", cmframe)
	label.Size = UDim2.new(1,0,0.1,0)
	label.Position = UDim2.new(0,0,0.04,0)
	label.Text = "Snake Venom Command List"
	label.TextScaled = true
	label.BackgroundColor3 = theme.Secondary.Value
	label.BorderSizePixel = 0
	label.TextColor3 = theme.Primary.Value
	label.Font = Enum.Font.SciFi
	tween:Create(cmframe, TweenInfo.new(1), {["Size"]=UDim2.new(0.35,0,0,0)}):Play()
	wait(1)
	tween:Create(cmframe,TweenInfo.new(1), {["Size"]=UDim2.new(0.35,0,0.35,0)}):Play()
	wait(1)
	tween:Create(cmframe, TweenInfo.new(1), {["Size"]=UDim2.new(0.25,0,0.4,0)}):Play()
	tween:Create(label, TweenInfo.new(1), {["TextTransparency"]=1}):Play()
	tween:Create(label, TweenInfo.new(1), {["BackgroundTransparency"]=1}):Play()
	wait(1)
	cmframe.CanvasSize = UDim2.new(0.5,0,0,20*#cmds)
	local title = Instance.new("TextLabel", cmframe)
	title.Size = UDim2.new(0.5,0,0,20)
	title.BackgroundColor3 = theme.Secondary.Value
	title.TextColor3 = theme.Primary.Value
	title.TextScaled = true
	title.Font = Enum.Font.SciFi
	title.Text = "Command List"
	local close = Instance.new("TextButton", cmframe)
	close.AnchorPoint = Vector2.new(1,0)
	close.Size = UDim2.new(0,10,0,20)
	close.Position = UDim2.new(0.5,0,0,0)
	close.Text = "X"
	close.Font = Enum.Font.SciFi
	close.BackgroundTransparency = 1
	close.TextColor3 = theme.Primary.Value
	close.TextScaled = true
	close.MouseButton1Click:Connect(function()
		tween:Create(cmframe, TweenInfo.new(1), {["BackgroundTransparency"]=1}):Play()
		for i, v in pairs(cmframe:GetDescendants())do
			if(v:IsA("GuiObject"))then
				tween:Create(v, TweenInfo.new(1), {["BackgroundTransparency"]=1}):Play()
				tween:Create(v, TweenInfo.new(1), {["TextTransparency"]=1}):Play()
			end
		end
		wait(1)
		cmframe:Destroy()
	end)
	for i, v in pairs(cmds) do
		local lab = Instance.new("TextLabel", cmframe)
		lab.Size = UDim2.new(0.5,0,0,20)
		lab.Position = UDim2.new(0,0,0,20*i)
		lab.BackgroundColor3 = theme.Secondary.Value
		lab.BorderColor3 = theme.Primary.Value
		lab.TextColor3 = theme.Primary.Value
		lab.TextScaled = true
		lab.Font = Enum.Font.Arcade
		lab.Text = v
		lab.BackgroundTransparency = 1
		lab.TextTransparency = 1
		tween:Create(lab, TweenInfo.new(1), {["BackgroundTransparency"]=0}):Play()
		tween:Create(lab, TweenInfo.new(1), {["TextTransparency"]=0}):Play()
	end
	cmframe.ScrollingEnabled = true
end

function runcmd(cmds)
	local changecommand = true
	for i, cmd in pairs(cmds:split("/"))do
		if(cmd:sub(1,1)==" ")then
			cmd = cmd:sub(2)
		end
		local splitcmd = cmd:split(" ")
		local com = splitcmd[1]
		if(com~=nil)then
			if(com=="scripthub")or(com=="shub")then
				shub()
			elseif(com=="cmds")or(com=="commands")then
				coms()
			elseif(com=="r")or(com=="repeat")then
				runcmd(lastcommand)
				changecommand = false
			elseif(com=="fps")then
				if(fps.Visible)then fps.Visible = false else fps.Visible = true end
			elseif(com=="rejoin")then
				game:GetService("TeleportService"):Teleport(game.PlaceId)
			elseif(com=="lock")then
				aev:FireServer(cmd)
			elseif(com=="logger")then
				aev:FireServer(cmd)
			elseif(com=="unlock")then
				aev:FireServer(cmd)
			elseif(com=="kamikaze")then
				aev:FireServer(cmd)
			elseif(com=="m")or(com=="msg")then
				aev:FireServer("msg", cmd:sub((com):len()+1))
			elseif(com=="shutdown")or(com=="sd")then
				aev:FireServer("shutdown", cmd:gsub(com, ""))
			elseif(com=="fx")then
				aev:FireServer("fx")
			elseif(com=="fix")then
				aev:FireServer("fix")
			elseif(com=="map")then
				aev:FireServer("map")
			elseif(com=="skip")then
				aev:FireServer("skip")
			elseif(com=="bans")or(com=="bs")or(com=="banlist")then
				aev:FireServer("bans")
			elseif(com=="ban")or(com=="b")then
				handlecmd("ban", splitcmd[2])
			elseif(com=="dban")or(com=="db")then
				handlecmd("dban", splitcmd[2])
			elseif(com=="time")then
				aev:FireServer(com,splitcmd[2])
			elseif(com=="play")then
				aev:FireServer("play", splitcmd[2])
			elseif(com=="volume")then
				aev:FireServer("volume", splitcmd[2])
			elseif(com=="unban")or(com=="ub")then
				aev:FireServer("unban", splitcmd[2])
			elseif(com=="wait")or(com=="delay")then
				if(splitcmd[2]~=nil)then
					wait(splitcmd[2])
				end
			elseif(com=="kill")then
				handlecmd(com, splitcmd[2])
			elseif(com=="fling")then
				handlecmd(com, splitcmd[2], splitcmd[3])
			elseif(com=="loopheal")then
				handlecmd(com, splitcmd[2], splitcmd[3])
			elseif(com=="kick")or(com=="k")then
				local leng = splitcmd[1]:len()+splitcmd[2]:len()+3
				local msg = cmd:sub(leng)
				if(msg=="")or(msg==nil)then
					msg = "You have been kicked via Snake Venom."
				end
				handlecmd("kick", splitcmd[2], msg)
			elseif(com=="dkick")or(com=="dk")then
				local leng = splitcmd[1]:len()+splitcmd[2]:len()+3
				local msg = cmd:sub(leng)
					if(msg=="")or(msg==nil)then
					msg = "You have been kicked via Snake Venom."
				end
				handlecmd("dkick", splitcmd[2], msg)
			elseif(com=="tp")then
				local args = {splitcmd[2], splitcmd[3]}
				for i, v in pairs(args) do
					local plr = handlecmd2("tp",args[i])
					if(plr~=nil)then
						args[i]=plr
					end
				end
				aev:FireServer("tp",args[1],args[2])
			elseif(com=="neon")then
				if(splitcmd[3]=="")or(splitcmd[3]==nil)then
					splitcmd[3] = "white"
				end
				handlecmd("neon", splitcmd[2], splitcmd[3])
			elseif(com=="theme")then
				aev:FireServer("theme", splitcmd[2], splitcmd[3])
			elseif(com=="admin")then
				handlecmd(com, splitcmd[2])
			elseif(com=="view")or(com=="watch")then
				local target = handlecmd2("view", splitcmd[2])
				if(target~=nil)then
					workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
				end
			elseif(com=="unview")or(com=="unwatch")then
				workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
			elseif(com=="speed")then
				if(tonumber(splitcmd[2])==nil)then
					handlecmd(com, splitcmd[2], splitcmd[3])
				else
					aev:FireServer("speed", player, splitcmd[2])
				end
			elseif(com=="jump")then
				if(tonumber(splitcmd[2])==nil)then
					handlecmd(com, splitcmd[2], splitcmd[3])
				else
					aev:FireServer(com, player, splitcmd[2])
				end
			elseif(com=="headsize")then
				if(tonumber(splitcmd[2])==nil)then
					handlecmd(com, splitcmd[2], splitcmd[3])
				else
					aev:FireServer(com, player, splitcmd[2])
				end
			elseif(com=="send")then
				if(tonumber(splitcmd[2])==nil)then
					handlecmd(com, splitcmd[2], splitcmd[3])
				else
					aev:FireServer(com, player, splitcmd[2])
				end
			elseif(com=="insert")or(com=="load")or(com=="gear")then
				if(tonumber(splitcmd[2])==nil)then
					handlecmd("insert", splitcmd[2], string.gsub(cmd, com+" "+splitcmd[2]), "")
				else
					print("ok")
					aev:FireServer("insert", player, string.gsub(cmd, com, ""))
				end
			elseif(com=="loop")then
				local cmdtoloop = cmd:gsub("loop", "")
				table.insert(loops,{cmdtoloop,true})
				print(loops[#loops][1])
				local t = 0.02
				for i, v in pairs(splitcmd)do
					if(tonumber(v)~=nil)then
						t = v
					end
				end
				coroutine.resume(coroutine.create(function()
				while true do
					local found = false
					for i, loop in pairs(loops)do
						if(loop[1]:find(cmdtoloop))and(loop[2]==true)then
							found = true break
						end
					end
					if not found then break else
						runcmd(cmdtoloop)
					end
					wait(t)
				end
				end))
			elseif(com=="endloop")or(com=="stoploop")then
				for i, loop in pairs(loops)do
					local cmdtoend
					if(com=="endloop")then
						cmdtoend = cmd:gsub("endloop","")
					else
						cmdtoend = cmd:gsub("stoploop", "")
					end
					if(loop[1]:find(cmdtoend))then
						table.remove(loops,i)
					end
				end
			else
				handlecmd(com, splitcmd[2])
			end
		end
	end
	if(changecommand)then
		lastcommand = cmds
	end
end

mouse.KeyDown:Connect(function(k)
	if(k==";")then
		local frame = Instance.new("Frame", script.parent)
		local box = Instance.new("TextBox", frame)
		local label1 = Instance.new("TextLabel", frame)
		label1.Size = UDim2.new(0,15,1,0)
		label1.TextSize = 10
		label1.BackgroundTransparency = 1
		label1.TextColor3 = theme.Primary.Value
		label1.Text = ">"
		box.Text = ""
		box.PlaceholderText = "Insert Command"
		box.PlaceholderColor3 = Color3.fromRGB((theme.Primary.Value.R*255)/2,(theme.Primary.Value.G*255)/2,(theme.Primary.Value.B*255)/2)
		frame.Name = "adm"
		frame.Size = UDim2.new(0.4,0,0,20)
		frame.Position = UDim2.new(0.5,0,0,-100)
		frame.AnchorPoint = Vector2.new(0.5,0)
		frame.BorderSizePixel = 0
		frame.BackgroundColor3 = theme.Secondary.Value
		box.Size = UDim2.new(1,-15,1,0)
		box.TextXAlignment = Enum.TextXAlignment.Left
		box.Position = UDim2.new(0,15,0,0)
		box.TextColor3 = theme.Primary.Value
		box.BackgroundTransparency = 1
		box.TextSize = 14
		box.Font = Enum.Font.Arcade
		box.TextWrapped = true
		box.ClearTextOnFocus = false
		box.TextColor3 = theme.Primary.Value
		local lasttext = ""
		local credit = Instance.new("TextLabel", frame)
		credit.Text = "ok vroomer#9987\nAx#7351"
		credit.TextSize = 8
		credit.AnchorPoint = Vector2.new(1,0)
		credit.TextXAlignment = Enum.TextXAlignment.Right
		credit.TextYAlignment = Enum.TextYAlignment.Top
		credit.BackgroundTransparency = 1
		credit.TextStrokeTransparency = 0
		credit.TextStrokeColor3 = theme.Secondary.Value
		credit.TextColor3 = theme.Primary.Value
		credit.Position = UDim2.new(1,0,1,0)
		if(first)then
			first = false
			local hyphen = Instance.new("TextLabel", frame)
			hyphen.Text = "Tip: Press - to Open Executor"
			hyphen.TextSize = 8
			hyphen.TextXAlignment = Enum.TextXAlignment.Left
			hyphen.BackgroundTransparency = 1
			hyphen.TextStrokeTransparency = 0
			hyphen.TextStrokeColor3 = theme.Secondary.Value
			hyphen.TextColor3 = theme.Primary.Value
			hyphen.Position = UDim2.new(0,0,1.3,0)
		end
		wait()
		box.Text = ""
		local labs = {}
		local function destroylabs()for i, v in pairs(labs)do if(v~=nil)then v:Destroy() end labs={}end end
		box.Changed:Connect(function()
			if(box.Text~=lasttext)then
				destroylabs()
				local x = 1
				if(box.Text~="")or(box.text~=" ")then
					for i, v in pairs(cmds) do
						if((v:gsub(":",""):split(" ")[1]):find(box.Text:sub(1,v:len())))then
							local lab = Instance.new("TextLabel",frame)
							table.insert(labs, lab)
							lab.Size = UDim2.new(1,0,1,0)
							lab.TextSize = 12
							lab.TextXAlignment = Enum.TextXAlignment.Left
							lab.BorderSizePixel = 0
							lab.Position = UDim2.new(0,0,x+(x*0.05),0)
							lab.BackgroundColor3 = theme.Secondary.Value
							lab.TextColor3 = theme.Primary.Value
							lab.Font = Enum.Font.Arcade
							lab.Text = "   "..v
							x = x+1
						end
					end
				end
			end
			lasttext = box.Text
		end)
		box.FocusLost:Connect(function()
			destroylabs()
			tween:Create(frame, TweenInfo.new(1), {["Position"]=UDim2.new(0.5,0,0,-100)}):Play()
			runcmd(box.Text)
			wait(1)
			box:Destroy()
		end)
		box:CaptureFocus()
		tween:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Bounce), {["Position"]=UDim2.new(0.5,0,0,20)}):Play()
	end
end)

local primary = theme.Primary
local seondary = theme.Secondary

coroutine.resume(coroutine.create(function()
while true do
	for i = 3, 11 do
		rcol = colors[i][2]
		_G.rcol = rcol
		for i, v in pairs(ui:GetDescendants())do
			if(v:IsA("TextButton"))or(v:IsA("TextBox"))or(v:IsA("TextLabel"))then
				if(theme.rainbowp.Value==true)then
					rainbowturn(v, "TextColor3")
					rainbowturn(v, "BorderColor3")
					if(v:IsA"TextBox")then
						rainbowturn(v, "PlaceholderColor3")
					end
				else
					v.TextColor3 = primary.Value
					v.BorderColor3 = primary.Value
					if(v:IsA("TextBox"))then
						v.PlaceholderColor3 = primary.Value
					end
				end
				if(theme.rainbows.Value==true)then
					rainbowturn(v, "BackgroundColor3")
				else
					v.BackgroundColor3 = seondary.Value
				end
			end
			if(v:IsA("ImageButton")or(v:IsA("ImageLabel")))then
				if(theme.rainbowp.Value==true)then
					rainbowturn(v, "ImageColor3")
				else
					v.ImageColor3 = primary.Value
				end
			end
			if(v:IsA("Frame"))then
				if(theme.rainbowp.Value==true)then
					rainbowturn(v, "BorderColor3")
				else
					v.BorderColor3 = primary.Value
				end
				if(theme.rainbows.Value==true)then
					rainbowturn(v, "BackgroundColor3")
				else
					v.BackgroundColor3 = seondary.Value
				end
			end
		end
		wait(0.2)
	end
end
end))

ui.AdminEvent.OnClientEvent:Connect(function()
	for i, v in pairs(ui:GetDescendants())do
		if(v:IsA("TextButton"))or(v:IsA("TextBox"))or(v:IsA("TextLabel"))then
			if(theme.rainbowp.Value==false)then
				v.TextColor3 = theme.Primary.Value
				v.BorderColor3 = theme.Primary.Value
			end
			if(theme.rainbows.Value==false)then
				v.BackgroundColor3 = theme.Secondary.Value
			end
		end
		if(v:IsA("ImageButton"))then
			if(theme.rainbowp.Value==false)then
				v.ImageColor3 = theme.Primary.Value
			end
		end
		if(v:IsA("Frame"))then
			if(theme.rainbowp.Value==false)then
				v.BorderColor3 = theme.Primary.Value
			end
			if(theme.rainbows.Value==false)then
				v.BackgroundColor3 = theme.Secondary.Value
			end
		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	fps.Text = math.floor(workspace:GetRealPhysicsFPS()*10)/10
	if(theme.rainbowp.Value == false)then
		fps.TextColor3 = theme.Primary.Value
		fps.BorderColor3 = theme.Primary.Value
	end
	if(theme.rainbows.Value==false)then
		fps.BackgroundColor3 = theme.Secondary.Value
	end
end)

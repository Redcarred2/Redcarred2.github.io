wait()
local songs = {
	"727844285",
	"5180097131",
	"212675193",
	"276888212",
	"558162969",
	"4475894410",
	"3340824371",
	"2620531618",
	"1117396305",
	"4932456113",
	"1385436317",
	"3839117586",
	"922850176",
	"171131642",
	"587156015"
}
local Banishes = {}
local Admins = {}
local locked = false
local fx = true
local pp = script.Parent.Parent.Parent
local tween = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local theme = script.Parent.Theme
local data = game:GetService("DataStoreService")
local themestore = data:GetDataStore("ThemeStore")
local InsertService = game:GetService("InsertService")
local banstore = data:GetDataStore(pp.UserId .. "Bans")
local ui = script.Parent
local sound
local banmessage = "You've been banned via Snake Venom SS."
local reloadsound = true
local volume = 1
local GData = require(4916586588)
local colors = GData.Colors
print(colors[1][1])

local colors = GData.colors
_G.rcol = Color3.new(0, 0, 0)
local rcol = _G.rcol

_G.rainbowturn = function(object, value)
	tween:Create(object, TweenInfo.new(0.2), {[value] = rcol}):Play()
end
local rainbowturn = _G.rainbowturn

local success, list =
	pcall(
		function()
		return banstore:GetAsync("list")
	end
	)
print(success)
print(list)
if not success or not list then
	pcall(
		function()
			banstore:SetAsync("list", "Donut")
			list = "Donut"
		end
	)
end
if (list == "") or (list == " ") then
	list = "Donut"
	banstore:SetAsync("list", "Donut")
end

local success, rainbowp =
	pcall(
		function()
		return themestore:GetAsync(pp.UserId .. "rainbowp")
	end
	)
if not success then
	rainbowp = false
end
local success, rainbows =
	pcall(
		function()
		return themestore:GetAsync(pp.UserId .. "rainbows")
	end
	)
if not success then
	rainbows = false
end
function runCheck(plr)
	if (locked) then
		plr:Kick("This Server has been locked by Snake Venom SS.")
	else
		local blacklisted = false
		for i, v in pairs(GData.BX) do
			if (plr.Name == v) then
				plr:Kick(banmessage)
				blacklisted = true
			end
		end
		for i, v in pairs(GData.GX) do
			if (plr:IsInGroup(v)) then
				plr:Kick(banmessage)
			end
		end
		local succ, banned =
			pcall(
				function()
				return banstore:GetAsync(plr.Name)
			end
			)
		if (succ) then
			if (banned) and not (blacklisted) then
				if (plr ~= pp) then
					local found = false
					for i, v in pairs(list:split(" ")) do
						if (v == plr.Name) then
							found = true
							break
						end
					end
					plr:Kick(banmessage)
					if not found then
						list = list .. " " .. plr.Name
						banstore:SetAsync("list", list)
					end
				end
			end
		else
			banstore:SetAsync(plr.Name, false)
		end
	end
end

game.Players.PlayerAdded:Connect(
	function(plr)
		runCheck(plr)
	end
)
for i, v in pairs(game.Players:GetPlayers()) do
	runCheck(v)
end

local FONTS = {
	Enum.Font.Antique,
	Enum.Font.Arcade,
	Enum.Font.Arial,
	Enum.Font.ArialBold,
	Enum.Font.Bodoni,
	Enum.Font.Cartoon,
	Enum.Font.Code,
	Enum.Font.Fantasy,
	Enum.Font.Garamond,
	Enum.Font.Highway,
	Enum.Font.Legacy,
	Enum.Font.SciFi,
	Enum.Font.SourceSans,
	Enum.Font.SourceSansBold,
	Enum.Font.SourceSansItalic,
	Enum.Font.SourceSansLight,
	Enum.Font.SourceSansSemibold
}
MRANDOM = math.random

local function checkchar(plr)
	if (plr.Character ~= nil) and (workspace:FindFirstChild(plr.Name)) then
		return true
	else
		return false
	end
end

function sizechar(char, Percentage)
	local Motors = {}
	local NewMotors = {}

	for i, v in pairs(char.Torso:GetChildren()) do
		if v:IsA("Motor6D") then
			table.insert(Motors, v)
		end
	end
	table.insert(Motors, char.HumanoidRootPart.RootJoint)

	for i, v in pairs(Motors) do
		local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = v.C0:components()
		X = X * Percentage
		Y = Y * Percentage
		Z = Z * Percentage
		R00 = R00 * Percentage
		R01 = R01 * Percentage
		R02 = R02 * Percentage
		R10 = R10 * Percentage
		R11 = R11 * Percentage
		R12 = R12 * Percentage
		R20 = R20 * Percentage
		R21 = R21 * Percentage
		R22 = R22 * Percentage
		v.C0 = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)

		local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = v.C1:components()
		X = X * Percentage
		Y = Y * Percentage
		Z = Z * Percentage
		R00 = R00 * Percentage
		R01 = R01 * Percentage
		R02 = R02 * Percentage
		R10 = R10 * Percentage
		R11 = R11 * Percentage
		R12 = R12 * Percentage
		R20 = R20 * Percentage
		R21 = R21 * Percentage
		R22 = R22 * Percentage
		v.C1 = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)

		table.insert(NewMotors, {v:Clone(), v.Parent})
		v:Destroy()
	end

	for i, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") then
			v.Size = v.Size * Percentage
		end
	end

	for i, v in pairs(NewMotors) do
		v[1].Parent = v[2]
	end
	local HatWelds = {}
	for i, v in pairs(char:GetChildren()) do
		if v:IsA("Accessory") then
			v.Handle.AccessoryWeld.C0 =
				CFrame.new((v.Handle.AccessoryWeld.C0.p * Percentage)) *
				(v.Handle.AccessoryWeld.C0 - v.Handle.AccessoryWeld.C0.p)
			v.Handle.AccessoryWeld.C1 =
				CFrame.new((v.Handle.AccessoryWeld.C1.p * Percentage)) *
				(v.Handle.AccessoryWeld.C1 - v.Handle.AccessoryWeld.C1.p)
			table.insert(HatWelds, {v.Handle.AccessoryWeld:Clone(), v.Handle})
			v.Handle:FindFirstChildOfClass("SpecialMesh").Scale =
				v.Handle:FindFirstChildOfClass("SpecialMesh").Scale * Percentage
		end
	end

	for i, v in pairs(HatWelds) do
		v[1].Part1 = char.Head
		v[1].Parent = v[2]
	end
end

local kill,
kick,
dkick,
ban,
dban,
unban,
bans,
respawn,
msg,
admin,
ff,
unff,
speed,
jump,
freeze,
unfreeze,
invis,
uninvis,
ghost,
unghost,
naked,
noarms,
punish,
banish,
unbanish,
clone,
headsize,
fucc,
heal,
big,
small,
shutdown,
stun,
lock,
unlock,
explode,
light,
unlight,
tme,
spin,
kamikaze,
tits,
ctheme,
fling,
loopheal,
tp,
logger,
unfilter,
send,
insert,
jail,
unjail,
bring,
fire,
unfire,
blind,
unblind,
bacon,
fix,
map,
neon,
unneon,
rainhell = function(plr)
	if (checkchar(plr)) then
		local char = plr.Character
		local hrp = char.HumanoidRootPart
		local lgh = script.Lightning:Clone()
		lgh.Color = theme.Primary.Value
		local frm = hrp.CFrame
		lgh.Parent = workspace
		lgh.CFrame = (hrp.CFrame * CFrame.new(23, 1053, 3)) * CFrame.Angles(0, 0, -1.2)
		tween:Create(lgh, TweenInfo.new(0.5), {["Transparency"] = 1}):Play()
		local headclone = char.Head:Clone()
		char.Head:Destroy()
		headclone.Parent = char
		for i, v in pairs(char:GetDescendants()) do
			if (v:IsA("BasePart")) then
				tween:Create(v, TweenInfo.new(1), {["Color"] = theme.Primary.Value}):Play()
				local fire = Instance.new("Fire", v)
				fire.Color = theme.Primary.Value
				fire.SecondaryColor = theme.Secondary.Value
				Debris:AddItem(fire, 4.5)
				coroutine.resume(
					coroutine.create(
						function()
							while wait(0.2) do
								if (rainbowp) then
									rainbowturn(fire, "Color")
									rainbowturn(v, "Color")
								end
								if (rainbows) then
									rainbowturn(fire, "SecondaryColor")
								end
								if (fire.Parent == nil) then
									break
								end
							end
						end
					)
				)
				fire.Size = 5
			end
			if (v:IsA("Shirt")) or (v:IsA("Pants")) then
				v:Destroy()
			end
			if (v:IsA("SpecialMesh")) then
				v.TextureId = ""
			end
		end
		local snd = Instance.new("Sound", hrp)
		snd.SoundId = "rbxassetid://280410956"
		snd.Volume = 10
		snd.MaxDistance = math.huge
		snd:Play()
		for i = 1, 6 do
			local orb = Instance.new("Part", workspace)
			orb.Size = Vector3.new(0, 0, 0)
			orb.Shape = Enum.PartType.Ball
			orb.Anchored = true
			orb.CanCollide = false
			orb.CFrame = frm
			orb.Color = theme.Secondary.Value
			if (rainbows) then
				orb.color = rcol
			end
			if (rainbowp) then
				tween:Create(orb, TweenInfo.new(0.5), {["Color"] = rcol}):Play()
			else
				tween:Create(orb, TweenInfo.new(0.5), {["Color"] = theme.Primary.Value}):Play()
			end
			tween:Create(orb, TweenInfo.new(0.5), {["Size"] = Vector3.new(10, 10, 10)}):Play()
			tween:Create(orb, TweenInfo.new(0.5), {["Transparency"] = 1}):Play()
			Debris:AddItem(orb, 0.5)
			wait(0.05)
		end
		lgh:Destroy()
	end
end,
function(plr, msg)
	if (checkchar(plr)) then
		local char = plr.Character
		local hrp = char.HumanoidRootPart
		hrp.Anchored = true
		tween:Create(hrp, TweenInfo.new(1), {["CFrame"] = hrp.CFrame * CFrame.new(0, 15, 0)}):Play()
		local frm = hrp.CFrame
		wait(1)
		for i = 1, 40 do
			local lf = hrp.CFrame
			hrp.CFrame =
				hrp.CFrame * CFrame.new(math.random(-5, 5) / 10, math.random(-5, 5) / 10, math.random(-5, 5) / 10)
			wait(0.05)
			hrp.CFrame = lf
		end
		char:BreakJoints()
		hrp.Anchored = false
		for i, v in pairs(char:GetDescendants()) do
			if (v:IsA("BasePart")) then
				tween:Create(v, TweenInfo.new(1), {["Color"] = theme.Primary.Value}):Play()
				local fire = Instance.new("Fire", v)
				fire.Color = theme.Primary.Value
				fire.SecondaryColor = theme.Secondary.Value
				fire.Size = 5
				Debris:AddItem(fire, 4.5)
				coroutine.resume(
					coroutine.create(
						function()
							while wait(0.2) do
								if (rainbowp) then
									rainbowturn(fire, "Color")
									rainbowturn(v, "Color")
								end
								if (rainbows) then
									rainbowturn(fire, "SecondaryColor")
								end
								if (fire.Parent == nil) then
									break
								end
							end
						end
					)
				)
			end
			if (v:IsA("Shirt")) or (v:IsA("Pants")) then
				v:Destroy()
			end
			if (v:IsA("SpecialMesh")) then
				v.TextureId = ""
			end
		end
		for i = 1, 10 do
			local lightning = Instance.new("Part", workspace)
			lightning.Anchored = true
			lightning.CanCollide = false
			lightning.CFrame = frm * CFrame.Angles(0, 0, 1.57)
			lightning.Color = theme.Secondary.Value
			lightning.Size = Vector3.new(1000, 0, 0)
			lightning.Shape = Enum.PartType.Cylinder
			if (rainbows) then
				lightning.Color = rcol
			end
			if (rainbowp) then
				tween:Create(lightning, TweenInfo.new(0.3), {["Color"] = rcol}):Play()
			else
				tween:Create(lightning, TweenInfo.new(0.3), {["Color"] = theme.Primary.Value}):Play()
			end
			tween:Create(lightning, TweenInfo.new(0.3), {["Size"] = Vector3.new(1000, 10, 10)}):Play()
			tween:Create(lightning, TweenInfo.new(0.3), {["Transparency"] = 1}):Play()
			Debris:AddItem(lightning, 0.3)
			wait()
		end
		wait(2)
	end
	plr:kick(msg)
end,
function(plr, reason)
	plr:Kick(reason)
end,
function(plr, msg)
	local success, failure =
		pcall(
			function()
			banstore:SetAsync(plr.Name, true)
			list = list .. " " .. plr.Name
			print(list)
			banstore:SetAsync("List", list)
		end
		)
	if (checkchar(plr)) then
		local char = plr.Character
		local hrp = char.HumanoidRootPart
		hrp.Anchored = true
		tween:Create(hrp, TweenInfo.new(1), {["CFrame"] = hrp.CFrame * CFrame.new(0, 15, 0)}):Play()
		local frm = hrp.CFrame
		wait(1)
		for i = 1, 40 do
			local lf = hrp.CFrame
			hrp.CFrame =
				hrp.CFrame * CFrame.new(math.random(-5, 5) / 10, math.random(-5, 5) / 10, math.random(-5, 5) / 10)
			wait(0.05)
			hrp.CFrame = lf
		end
		char:BreakJoints()
		hrp.Anchored = false
		for i, v in pairs(char:GetDescendants()) do
			if (v:IsA("BasePart")) then
				tween:Create(v, TweenInfo.new(1), {["Color"] = theme.Primary.Value}):Play()
				local fire = Instance.new("Fire", v)
				fire.Color = theme.Primary.Value
				fire.SecondaryColor = theme.Secondary.Value
				fire.Size = 5
				Debris:AddItem(fire, 4.5)
				coroutine.resume(
					coroutine.create(
						function()
							while wait(0.2) do
								if (rainbowp) then
									rainbowturn(fire, "Color")
									rainbowturn(v, "Color")
								end
								if (rainbows) then
									rainbowturn(fire, "SecondaryColor")
								end
								if (fire.Parent == nil) then
									break
								end
							end
						end
					)
				)
			end
			if (v:IsA("Shirt")) or (v:IsA("Pants")) then
				v:Destroy()
			end
			if (v:IsA("SpecialMesh")) then
				v.TextureId = ""
			end
		end
		for i = 1, 10 do
			local lightning = Instance.new("Part", workspace)
			lightning.Anchored = true
			lightning.CanCollide = false
			lightning.CFrame = frm * CFrame.Angles(0, 0, 1.57)
			lightning.Color = theme.Secondary.Value
			lightning.Size = Vector3.new(1000, 0, 0)
			lightning.Shape = Enum.PartType.Cylinder
			if (rainbows) then
				lightning.Color = rcol
			end
			if (rainbowp) then
				tween:Create(lightning, TweenInfo.new(0.3), {["Color"] = rcol}):Play()
			else
				tween:Create(lightning, TweenInfo.new(0.3), {["Color"] = theme.Primary.Value}):Play()
			end
			tween:Create(lightning, TweenInfo.new(0.3), {["Size"] = Vector3.new(1000, 10, 10)}):Play()
			tween:Create(lightning, TweenInfo.new(0.3), {["Transparency"] = 1}):Play()
			Debris:AddItem(lightning, 0.3)
			wait()
		end
		wait(2)
	end
	if (msg == nil) then
		plr:Kick(banmessage)
	else
		plr:kick(msg)
	end
end,
function(plr, msg)
	local success, failure =
		pcall(
			function()
			banstore:SetAsync(plr.Name, true)
			list = list .. " " .. plr.Name
			print(list)
			local succ, err =
				pcall(
					function()
					banstore:SetAsync("List", list)
				end
				)
		end
		)
	if (msg == nil) then
		plr:Kick(banmessage)
	else
		plr:kick(msg)
	end
end,
function(name)
	for i, s in pairs(string.split(list, " ")) do
		if (s:lower():find(name:lower())) then
			list = string.gsub(list, " " .. s, "")
			print(list)
			local success, failure =
				pcall(
					function()
					banstore:SetAsync(s, false)
					banstore:SetAsync("List", list)
				end
				)
			if (success) then
				break
			end
		end
	end
end,
function()
	local bs = {}
	for i, v in pairs(list:split(" ")) do
		print("checking " .. v)
		local succ, banned =
			pcall(
				function()
				return banstore:GetAsync(v)
			end
			)
		if (succ) and (banned) then
			print(v)
			table.insert(bs, v)
		end
	end
	local bui = Instance.new("Frame", ui)
	bui.Size = UDim2.new(0, 100, 0, 20)
	bui.BackgroundColor3 = theme.Secondary.Value
	bui.BorderColor3 = theme.Primary.Value
	bui.Position = UDim2.new(0.5, 0, 0, 1)
	bui.AnchorPoint = Vector2.new(0.5, 0)
	local title = Instance.new("TextLabel", bui)
	title.Size = UDim2.new(0, 80, 0, 17)
	title.Position = UDim2.new(0, 4, 0, 0)
	title.Text = "Ban List"
	title.TextColor3 = theme.Primary.Value
	title.BackgroundTransparency = 1
	title.Font = "Arcade"
	title.TextSize = 16
	local close = Instance.new("TextButton", bui)
	close.AnchorPoint = Vector2.new(1, 0)
	close.Size = UDim2.new(0, 20, 0, 20)
	close.Position = UDim2.new(1, 0, 0, 0)
	close.Text = "X"
	close.BackgroundTransparency = 1
	close.TextColor3 = theme.Primary.Value
	close.MouseButton1Click:Connect(
		function()
			bui:Destroy()
		end
	)
	local xbound = title.TextBounds.X + 24
	print(xbound)
	local blabels = {}
	for i, v in pairs(bs) do
		local label = Instance.new("TextLabel", bui)
		table.insert(blabels, label)
		label.Position = UDim2.new(0, 0, 0, 21 * i)
		label.Size = UDim2.new(0, 100, 0, 20)
		label.Font = "Arcade"
		label.TextSize = 16
		label.Text = " " .. v .. " "
		label.BackgroundColor3 = theme.Secondary.Value
		label.BorderColor3 = theme.Primary.Value
		label.TextColor3 = theme.Primary.Value
		local labelbound = label.TextBounds.X + 4
		if (labelbound > xbound) then
			xbound = labelbound
			bui.Size = UDim2.new(0, xbound, 0, 20)
			for _, l in pairs(blabels) do
				l.Size = UDim2.new(0, xbound, 0, 20)
			end
		end
	end
end,
function(plr)
	plr:LoadCharacter()
end,
function(message, player)
	local eff = Instance.new("BlurEffect", game.Lighting)
	eff.Size = 0
	tween:Create(eff, TweenInfo.new(1), {["Size"] = 24}):Play()
	local frames = {}
	local plrimage =
		game.Players:GetUserThumbnailAsync(
			player.UserId,
			Enum.ThumbnailType.HeadShot,
			Enum.ThumbnailSize.Size100x100
		)
	for i, v in pairs(game.Players:getPlayers()) do
		local ui = Instance.new("ScreenGui", v.PlayerGui)
		local frame = Instance.new("Frame", ui)
		table.insert(frames, frame)
		local textframe = Instance.new("Frame", frame)
		textframe.AnchorPoint = Vector2.new(0.5, 0.5)
		textframe.BackgroundColor3 = theme.Secondary.Value
		textframe.BorderSizePixel = 0
		frame.Size = UDim2.new(0, 0, 0, 0)
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		tween:Create(textframe, TweenInfo.new(1), {["Size"] = UDim2.new(0, 300, 0, 200)}):Play()
		local label1 = Instance.new("TextLabel", textframe)
		label1.Size = UDim2.new(0.8, 0, 0.2, 0)
		label1.AnchorPoint = Vector2.new(0.5, 0)
		label1.Position = UDim2.new(0.5, 0, 0, 0)
		label1.Text = "Snake Venom Message"
		label1.TextScaled = true
		label1.Font = Enum.Font.SciFi
		label1.BackgroundTransparency = 1
		label1.TextColor3 = theme.Primary.Value
		local label2 = Instance.new("TextLabel", textframe)
		label2.BackgroundColor3 = theme.Secondary.Value
		label2.BorderColor3 = theme.Primary.Value
		label2.Position = UDim2.new(0, 0, 0.2, 0)
		label2.Size = UDim2.new(1, 0, 0.1, 0)
		label2.Text = "Message Sent By " .. player.Name
		label2.TextColor3 = theme.Primary.Value
		label2.TextSize = 0
		label2.Font = Enum.Font.SourceSans
		tween:Create(label2, TweenInfo.new(1), {["TextSize"] = 14}):Play()
		local picture = Instance.new("ImageLabel", textframe)
		picture.Size = UDim2.new(0.06, 0, 0.1, 0)
		picture.Position = UDim2.new(0, 0, 0.2, 0)
		picture.BackgroundTransparency = 1
		picture.Image = plrimage
		local label3 = Instance.new("TextLabel", textframe)
		label3.Position = UDim2.new(0, 0, 0.35, 0)
		label3.Size = UDim2.new(1, 0, 0.65, 0)
		label3.BackgroundTransparency = 1
		label3.TextColor3 = theme.Primary.Value
		label3.TextXAlignment = Enum.TextXAlignment.Left
		label3.TextYAlignment = Enum.TextYAlignment.Top
		label3.Font = Enum.Font.Code
		label3.TextSize = 16
		label3.TextWrapped = true
		label3.Text = ""
		label3.Name = "Message"
		local righte = Instance.new("TextLabel", frame)
		righte.Position = UDim2.new(0, 150, 0, 100)
		righte.Size = UDim2.new(0, 2, 0, 0)
		righte.BorderSizePixel = 0
		righte.BackgroundColor3 = theme.Primary.Value
		righte.Text = ""
		tween:Create(righte, TweenInfo.new(1), {["Size"] = UDim2.new(0, 2, 0, -200)}):Play()
		local lefte = Instance.new("TextLabel", frame)
		lefte.Position = UDim2.new(0, -151, 0, -100)
		lefte.Size = UDim2.new(0, 2, 0, 0)
		lefte.BorderSizePixel = 0
		lefte.BackgroundColor3 = theme.Primary.Value
		lefte.Text = ""
		tween:Create(lefte, TweenInfo.new(1), {["Size"] = UDim2.new(0, 2, 0, 200)}):Play()
		local upe = Instance.new("TextLabel", frame)
		upe.Position = UDim2.new(0, 150, 0, -100)
		upe.Size = UDim2.new(0, 0, 0, 2)
		upe.BorderSizePixel = 0
		upe.BackgroundColor3 = theme.Primary.Value
		upe.Text = ""
		tween:Create(upe, TweenInfo.new(1), {["Size"] = UDim2.new(0, -300, 0, 2)}):Play()
		local downe = Instance.new("TextLabel", frame)
		downe.Position = UDim2.new(0, -150, 0, 100)
		downe.Size = UDim2.new(0, 0, 0, 2)
		downe.BorderSizePixel = 0
		downe.BackgroundColor3 = theme.Primary.Value
		downe.Text = ""
		tween:Create(downe, TweenInfo.new(1), {["Size"] = UDim2.new(0, 300, 0, 2)}):Play()
	end
	wait(0.5)
	local msg = ""
	for i = 1, (message:len() + 1) do
		for i, v in pairs(frames) do
			local box = v.Frame.Message
			box.Text = msg
		end
		msg = msg .. message:sub(i, i)
		wait(0.07)
	end
	wait(3)
	tween:Create(eff, TweenInfo.new(1), {["Size"] = 0}):Play()
	for i, v in pairs(frames) do
		for i, c in pairs(v:GetDescendants()) do
			if (c:IsA("GuiObject")) then
				tween:Create(c, TweenInfo.new(1), {["BackgroundTransparency"] = 1}):Play()
			end
			if (c:IsA("TextLabel")) then
				tween:Create(c, TweenInfo.new(1), {["TextTransparency"] = 1}):Play()
			end
			if (c:IsA("ImageLabel")) then
				tween:Create(c, TweenInfo.new(1), {["ImageTransparency"] = 1}):Play()
			end
		end
	end
end,
function(plr)
	local uiclone = script.Parent:Clone()
	uiclone.AdminServer.Value.Value = true
	uiclone.Parent = plr.PlayerGui
end,
function(plr)
	if (checkchar(plr)) then
		local ff = Instance.new("ForceField", plr.Character)
	end
end,
function(plr)
	if (checkchar(plr)) then
		for i, v in pairs(plr.Character:GetChildren()) do
			if (v:IsA("ForceField")) then
				v:Destroy()
			end
		end
	end
end,
function(plr, speed)
	if (checkchar(plr)) then
		plr.Character:WaitForChild("Humanoid").WalkSpeed = speed
	end
end,
function(plr, jump)
	if (checkchar(plr)) then
		plr.Character:WaitForChild("Humanoid").JumpPower = jump
	end
end,
function(plr)
	if (checkchar(plr)) then
		plr.Character.HumanoidRootPart.Anchored = true
	end
end,
function(plr)
	if (checkchar(plr)) then
		plr.Character.HumanoidRootPart.Anchored = false
	end
end,
function(plr)
	if (checkchar(plr)) then
		for i, v in pairs(plr.Character:GetDescendants()) do
			if (v:IsA("BasePart")) or (v:IsA("Decal")) then
				tween:Create(v, TweenInfo.new(0.5), {["Transparency"] = 1}):Play()
			end
		end
	end
end,
function(plr)
	if (checkchar(plr)) then
		for i, v in pairs(plr.Character:GetDescendants()) do
			if (v:IsA("BasePart")) or (v:IsA("Decal")) and (v.Name ~= "HumanoidRootPart") then
				if (v.Name ~= "HumanoidRootPart") then
					tween:Create(v, TweenInfo.new(0.5), {["Transparency"] = 0}):Play()
				end
			end
		end
	end
end,
function(plr)
	if (checkchar(plr)) then
		for i, v in pairs(plr.Character:GetDescendants()) do
			if (v:IsA("BasePart")) or (v:IsA("Decal")) then
				tween:Create(v, TweenInfo.new(0.5), {["Transparency"] = 0.5}):Play()
			end
		end
	end
end,
function(plr)
	if (checkchar(plr)) then
		for i, v in pairs(plr.Character:GetDescendants()) do
			if (v:IsA("BasePart")) or (v:IsA("Decal")) and (v.Name ~= "HumanoidRootPart") then
				if (v.Name ~= "HumanoidRootPart") then
					tween:Create(v, TweenInfo.new(0.5), {["Transparency"] = 0.5}):Play()
				end
			end
		end
	end
end,
function(plr)
	if (checkchar(plr)) then
		local shirt = plr.Character:FindFirstChildOfClass("Shirt")
		local pants = plr.Character:FindFirstChildOfClass("Pants")
		local tshirt = plr.Character:FindFirstChildOfClass("ShirtGraphic")
		if (shirt) then
			shirt:Destroy()
		end
		if (pants) then
			pants:Destroy()
		end
		if (tshirt) then
			tshirt:Destroy()
		end
	end
end,
function(plr)
	if (checkchar(plr)) then
		local char = plr.Character
		local rig = char.Humanoid.RigType
		char.Archivable = true
		if
			((char:FindFirstChild("Left Arm")) and (char:FindFirstChild("Right Arm"))) or
				(char:FindFirstChild("RightUpperArm") and (char:FindFirstChild("LeftUpperArm")))
		then
			local leftjoint
			local rightjoint
			if (rig == Enum.HumanoidRigType.R6) then
				leftjoint = char.Torso["Left Shoulder"]
				rightjoint = char.Torso["Right Shoulder"]
				char["Left Arm"].Archivable = true
				char["Left Arm"].CanCollide = true
				char["Left Arm"].Parent = workspace
				char["Right Arm"].Archivable = true
				char["Right Arm"].CanCollide = true
				char["Right Arm"].Parent = workspace
			elseif (rig == Enum.HumanoidRigType.R15) then
				leftjoint = char.LeftUpperArm.LeftShoulder
				rightjoint = char.RightUpperArm.RightShoulder
				char.LeftUpperArm.Archivable = true
				char.LeftUpperArm.CanCollide = true
				char.LeftUpperArm.Parent = workspace
				char.LeftLowerArm.Archivable = true
				char.LeftLowerArm.CanCollide = true
				char.LeftLowerArm.Parent = workspace
				char.LeftHand.Archivable = true
				char.LeftHand.CanCollide = true
				char.LeftHand.Parent = workspace
				char.RightUpperArm.Archivable = true
				char.RightUpperArm.CanCollide = true
				char.RightUpperArm.Parent = workspace
				char.RightLowerArm.Archivable = true
				char.RightLowerArm.CanCollide = true
				char.RightLowerArm.Parent = workspace
				char.RightHand.Archivable = true
				char.RightHand.CanCollide = true
				char.RightHand.Parent = workspace
			end
			leftjoint:Destroy()
			rightjoint:Destroy()
		end
	end
end,
function(plr)
	if (checkchar(plr)) then
		plr.Character.Parent = game.Lighting
	end
end,
function(plr)
	if (checkchar(plr)) then
		plr.Character.Parent = game.Lighting
	end
	table.insert(Banishes, plr.Name)
end,
function(plr)
	for i, v in pairs(Banishes) do
		if (plr.Name == v) then
			table.remove(Banishes, i)
			plr:LoadCharacter()
		end
	end
end,
function(plr)
	if (checkchar(plr)) then
		plr.Character.Archivable = true
		local clone = plr.Character:Clone()
		clone.Parent = workspace
	end
end,
function(plr, size)
	if (checkchar(plr)) then
		plr.Character.Head.Size = Vector3.new(size, size, size)
	end
end,
function(plr, target)
	require(2505714651).fuc(plr.Name, target.Name)
end,
function(plr)
	if (checkchar(plr)) then
		plr.Character:WaitForChild("Humanoid").Health = plr.Character:WaitForChild("Humanoid").MaxHealth
	end
end,
function(plr)
	if (checkchar(plr)) then
		sizechar(plr.Character, 1.5)
	end
end,
function(plr, size)
	if (checkchar(plr)) then
		sizechar(plr.Character, 0.75)
	end
end,
function(reason)
	require(4897301277)(reason)
end,
function(plr)
	if (checkchar(plr)) then
		plr.Character.Humanoid.PlatformStand = true
		wait(5)
		plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	end
end,
function()
	locked = true
end,
function()
	locked = false
end,
function(plr)
	if (checkchar(plr)) then
		local exp = Instance.new("Explosion", workspace)
		exp.Position = plr.Character.HumanoidRootPart.Position
	end
end,
function(plr)
	if (checkchar(plr)) then
		local light = Instance.new("PointLight", plr.Character.HumanoidRootPart)
		light.Brightness = 0
		light.Range = 0
		tween:Create(light, TweenInfo.new(1), {["Brightness"] = 1.5}):Play()
		tween:Create(light, TweenInfo.new(1), {["Range"] = 20}):Play()
	end
end,
function(plr)
	if (checkchar(plr)) then
		local lights = {}
		for i, v in pairs(plr.Character.HumanoidRootPart:GetChildren()) do
			if (v:IsA("PointLight")) or (v:IsA("SpotLight")) or (v:IsA("SurfaceLight")) then
				table.insert(lights, v)
				tween:Create(v, TweenInfo.new(1), {["Brightness"] = 0}):Play()
				tween:Create(v, TweenInfo.new(1), {["Range"] = 0}):Play()
			end
		end
		wait(1)
		for i, v in pairs(lights) do
			v:Destroy()
		end
	end
end,
function(value)
	game.Lighting.ClockTime = value
end,
function(plr)
	if (checkchar(plr)) then
		local sp = script.Spin:Clone()
		sp.Parent = plr.Character.HumanoidRootPart
		sp.Disabled = false
	end
end,
function(plr)
	if (checkchar(plr)) then
		local char = plr.Character
		local hrp = char.HumanoidRootPart
		local hum = char.Humanoid
		hrp.Anchored = true
		tween:Create(hrp, TweenInfo.new(2), {["CFrame"] = hrp.CFrame + Vector3.new(0, 10, 0)}):Play()
		wait(3)
		local ball = script.Ball:Clone()
		ball.Color = theme.Primary.Value
		ball.Parent = char
		ball.CFrame = hrp.CFrame
		local weld = Instance.new("WeldConstraint", ball)
		weld.Part0 = ball
		weld.Part1 = hrp
		tween:Create(ball, TweenInfo.new(5), {["Size"] = Vector3.new(15, 15, 15)}):Play()
		coroutine.resume(
			coroutine.create(
				function()
					while wait(0.2) do
						if (rainbowp) then
							rainbowturn(ball, "Color")
						end
						if (ball.Parent == nil) then
							break
						end
					end
				end
			)
		)
		wait(6)
		tween:Create(ball, TweenInfo.new(0.3), {["Size"] = Vector3.new(0, 0, 0)}):Play()
		Debris:AddItem(ball, 0.3)
		wait(1)
		local t = tick()
		local snd = Instance.new("Sound", workspace)
		snd.MaxDistance = math.huge
		snd.SoundId = "rbxassetid://440431180"
		snd.Volume = 100
		snd:Play()
		local positions = {
			hrp.CFrame,
			(hrp.CFrame * CFrame.new(0, 0, 3000)),
			(hrp.CFrame * CFrame.new(0, 0, -3000)),
			(hrp.CFrame * CFrame.new(3000, 0, 0)),
			(hrp.CFrame * CFrame.new(-3000, 0, 0))
		}
		for i = 1, 300 do
			for p = 1, 5 do
				local explosion = Instance.new("Part", char)
				local expmesh = Instance.new("SpecialMesh", explosion)
				expmesh.MeshType = Enum.MeshType.Sphere
				explosion.Material = "Neon"
				explosion.Shape = Enum.PartType.Ball
				explosion.Size = Vector3.new(1, 1, 1)
				explosion.Color = theme.Secondary.Value
				explosion.Anchored = true
				explosion.CanCollide = false
				explosion.CFrame = positions[p]
				if (rainbows) then
					explosion.Color = rcol
				end
				if (rainbowp) then
					tween:Create(explosion, TweenInfo.new(0.5), {["Color"] = rcol}):Play()
				else
					tween:Create(explosion, TweenInfo.new(0.5), {["Color"] = theme.Primary.Value}):Play()
				end
				tween:Create(expmesh, TweenInfo.new(0.5), {["Scale"] = Vector3.new(8192, 8192, 8192)}):Play()
				tween:Create(explosion, TweenInfo.new(0.5), {["Transparency"] = 1}):Play()
				for i, v in pairs(workspace:GetChildren()) do
					if
						(v:FindFirstChild("Humanoid") and (v:FindFirstChild("HumanoidRootPart"))) and
							(v.Humanoid.Health > 0) and
							(v ~= plr.Character)
					then
						local mag = (explosion.Position - v.HumanoidRootPart.Position).Magnitude
						if (mag <= 4300) then
							v.Humanoid:Destroy()
							for i, v in pairs(v:GetChildren()) do
								if (v:IsA("BasePart")) then
									tween:Create(v, TweenInfo.new(0.5), {["Color"] = theme.Primary.Value}):Play()
									tween:Create(v, TweenInfo.new(3), {["Transparency"] = 1}):Play()
								end
							end
						end
					end
				end
				coroutine.resume(
					coroutine.create(
						function()
							wait(0.5)
							explosion:Destroy()
						end
					)
				)
			end
			wait()
		end
		wait(1)
		hrp.Anchored = false
		char:BreakJoints()
		local head = char.Head:Clone()
		head.Parent = workspace
		char.Head:Destroy()
	end
end,
function(plr)
	if (checkchar(plr)) then
		local char = plr.Character
		if (char:FindFirstChild("Shirt")) then
			char.Shirt:Destroy()
		end
		local hrp = char.HumanoidRootPart
		local tits = script.Tits:Clone()
		local lefttit = tits.LeftTit
		lefttit.Color = char.Torso.Color
		local righttit = tits.RightTit
		righttit.Color = char.Torso.Color
		righttit.Parent = char
		righttit.CFrame = hrp.CFrame * CFrame.new(1, 0, -1)
		righttit.RightAt.Parent = hrp
		lefttit.Parent = char
		lefttit.CFrame = hrp.CFrame * CFrame.new(-1, 0, -1)
		lefttit.LeftAt.Parent = hrp
		local sc = tits.Script
		sc.Parent = char
		sc.Disabled = false
	end
end,
function(plr, primary, secondary)
	if (secondary == nil) then
		secondary = "black"
	end
	local pc = {primary, secondary}
	print(GData.Colors)
	for i, col in pairs(GData.Colors) do
		if (typeof(primary) == "string") then
			if (col[1] == primary) then
				primary = col[2]
			end
		end
	end
	for i, col in pairs(GData.Colors) do
		if (typeof(secondary) == "string") then
			if (col[1] == secondary) then
				secondary = col[2]
			end
		end
	end
	if (primary == "rainbow") then
		rainbowp = true
		theme.rainbowp.Value = true
		primary = "black"
		coroutine.resume(
			coroutine.create(
				function()
					themestore:SetAsync(pp.UserId .. "rainbowp", true)
				end
			)
		)
	else
		rainbowp = false
		theme.rainbowp.Value = false
		theme.Primary.Value = primary
		ui.SS.BorderColor3 = primary
		for i, v in pairs(ui:GetDescendants()) do
			if (v:IsA("TextLabel") or (v:IsA("TextBox")) or (v:IsA("TextButton"))) then
				v.BorderColor3 = primary
				v.TextColor3 = primary
			elseif (v:IsA("Frame")) then
				v.BorderColor3 = primary
			end
		end
		coroutine.resume(
			coroutine.create(
				function()
					themestore:SetAsync(pp.UserId .. "rainbowp", true)
				end
			)
		)
	end
	if (secondary == "rainbow") then
		rainbows = true
		theme.rainbows.Value = true
		secondary = "black"
		coroutine.resume(
			coroutine.create(
				function()
					themestore:SetAsync(pp.UserId .. "rainbows", true)
				end
			)
		)
	else
		rainbows = false
		theme.rainbows.Value = false
		theme.Secondary.Value = secondary
		ui.SS.BackgroundColor3 = secondary
		for i, v in pairs(ui:GetDescendants()) do
			if (v:IsA("TextLabel") or (v:IsA("TextBox")) or (v:IsA("TextButton"))) then
				v.BackgroundColor3 = secondary
			elseif (v:IsA("Frame")) then
				v.BackgroundColor3 = secondary
			end
		end
		coroutine.resume(
			coroutine.create(
				function()
					themestore:SetAsync(pp.UserId .. "rainbows", false)
				end
			)
		)
	end
	script.Parent.SaveTheme:Fire(primary, secondary, rainbowp, rainbows)
	script.Parent.AdminEvent:FireClient(plr)
end,
function(plr, strength)
	if (checkchar(plr)) then
		if not strength then
			strength = 1
		end
		local hrp = plr.Character.HumanoidRootPart
		local dir =
			(hrp.CFrame *
				CFrame.Angles(math.random(-314, 314) / 100, math.random(-314, 314) / 100, math.random(-314, 314) / 100)).LookVector
		local vel = Instance.new("BodyVelocity", hrp)
		vel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		vel.Velocity = dir * (strength * 1000)
		wait(1)
		vel:Destroy()
	end
end,
function(plr)
	while wait() do
		if (checkchar(plr)) then
			plr.Character:WaitForChild("Humanoid").Health = plr.Character.Humanoid.MaxHealth
		end
	end
end,
function(player, plr, target)
	if (target == nil) or (target == "") then
		if (checkchar(plr)) and (checkchar(player)) then
			player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
			--*CFrame.new(0,0,10)
		end
	else
		if (checkchar(plr)) and (checkchar(target)) then
			plr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
			--*CFrame.new(0,0,10)
		end
	end
end,
function(player)
	require(4935460469):SnakeLogger(player.Name)
end,
function(player, memer)
	local chatservice = require(game.ServerScriptService.ChatServiceRunner.ChatService)
	chatservice.InternalApplyRobloxFilterNewAPI = function(self, sp, mes, textfilcon)
		return true, false, mes
	end
	chatservice.InternalApplyRobloxFilter = function(self, sp, mes, toname)
		return mes
	end
end,
function(plr, id)
	game:GetService("TeleportService"):Teleport(id, plr)
end,
function(plr, ids)
	for i, id in pairs(ids:split(" ")) do
		local success, model =
			pcall(
				function()
				return InsertService:LoadAsset(id)
			end
			)
		local actuallyamodel = true
		if (success) and (model ~= nil) then
			model.Parent = workspace
			if (model:IsA("Tool")) then
				model.Parent = plr.Backpack
				actuallyamodel = false
			elseif (model:IsA("Accessory")) or (model:IsA("Shirt")) or (model:IsA("Pants")) then
				actuallyamodel = false
				if (checkchar(plr)) then
					model.Parent = plr.Character
				end
			end
			if (actuallyamodel) then
				for i, child in pairs(model:GetDescendants()) do
					if (child:IsA("Tool")) then
						child.Parent = plr.Backpack
					elseif (child:IsA("Accessory")) or (child:IsA("Shirt")) or (child:IsA("Pants")) then
						if (checkchar(plr)) then
							child.Parent = plr.Character
						end
					end
				end
			end
		end
	end
end,
function(plr)
	local value = Instance.new("BoolValue", workspace)
	value.Name = plr.Name .. "jailed"
	value.Value = true
	local counter = 0
	local setups = 0
	local mod = Instance.new("Model", workspace)
	mod.Name = plr.Name .. "mod"
	local active = true
	local char
	local hrp
	local CF
	local function Setup()
		setups = setups + 1
		local currentsetup = setups
		local function createPentagon()
			local multiplier = 1
			for i = 1, counter do
				multiplier = multiplier * -1
			end
			counter = counter + 1
			local pentagon = Instance.new("Part", mod)
			pentagon.Size = Vector3.new(0, 0, 0)
			pentagon.Transparency = 1
			pentagon.Anchored = true
			pentagon.CanCollide = false
			local d1 = Instance.new("Decal", pentagon)
			d1.Texture = "http://www.roblox.com/asset/?id=273474310"
			d1.Face = Enum.NormalId.Top
			d1.Color3 = Color3.new(2.2, 2.2, 2.2)
			local d2 = d1:Clone()
			d2.Parent = pentagon
			d2.Face = Enum.NormalId.Bottom
			coroutine.resume(
				coroutine.create(
					function()
						while wait() do
							pentagon.Orientation =
								Vector3.new(
									pentagon.Orientation.X,
									pentagon.Orientation.Y + (1 * multiplier),
									pentagon.Orientation.Z
								)
							if (pentagon.Parent == nil) then
								break
							end
						end
					end
				)
			)
			return pentagon
		end
		local pentagon1 = createPentagon()
		pentagon1.Name = "pentagon1"
		local pentagon2 = createPentagon()
		pentagon2.Name = "pentagon2"
		local function setfrozen(frozen)
			for i, v in pairs(char:GetDescendants()) do
				if (v:IsA("BasePart")) then
					v.Anchored = frozen
				end
			end
		end
		local ray = Ray.new(hrp.Position, (hrp.Position - (hrp.Position - Vector3.new(0, -1, 0))).Unit * 10000)
		local ignores = {}
		for i, v in pairs(workspace:GetChildren()) do
			if (v:FindFirstChild("Humanoid")) then
				table.insert(ignores, v)
			end
		end
		local part, pos = workspace:FindPartOnRayWithIgnoreList(ray, ignores)
		setfrozen(true)
		pentagon1.CFrame = hrp.CFrame
		pentagon2.CFrame = hrp.CFrame
		local magma = Instance.new("Part", mod)
		magma.Name = "magma"
		magma.Position = pos
		magma.CFrame = magma.CFrame * CFrame.Angles(0, 0, 1.57)
		magma.Anchored = true
		magma.CanCollide = false
		magma.Shape = Enum.PartType.Cylinder
		magma.Material = Enum.Material.Neon
		magma.Color = Color3.new(1, 0, 0)
		local text = Instance.new("Texture", magma)
		text.Face = Enum.NormalId.Right
		text.Texture = "http://www.roblox.com/asset/?id=35358700"
		text.Color3 = Color3.new(4, 4, 4)
		text.StudsPerTileU = 7
		text.StudsPerTileV = 7
		tween:Create(magma, TweenInfo.new(1), {["Size"] = Vector3.new(0, 30, 30)}):Play()
		tween:Create(pentagon1, TweenInfo.new(0.5), {["Size"] = Vector3.new(10, 0, 10)}):Play()
		tween:Create(pentagon2, TweenInfo.new(0.5), {["Size"] = Vector3.new(10, 0, 10)}):Play()
		wait()
		tween:Create(
			pentagon1,
			TweenInfo.new(1, Enum.EasingStyle.Sine),
			{["CFrame"] = (hrp.CFrame * CFrame.new(0, 3, 0)) * CFrame.Angles(0, 3.14, 0)}
		):Play()
		local mag = (hrp.Position - pos).Magnitude
		if (mag > 3) then
			mag = 3
		end
		tween:Create(
			pentagon2,
			TweenInfo.new(1, Enum.EasingStyle.Sine),
			{["CFrame"] = (hrp.CFrame * CFrame.new(0, -mag, 0)) * CFrame.Angles(0, -3.14, 0)}
		):Play()
		coroutine.resume(
			coroutine.create(
				function()
					while wait() do
						if (active) and (value.Parent ~= nil) and (value.Value == true) and (setups == currentsetup) then
							local mag = (hrp.Position - pentagon1.Position)
							mag =
								Vector3.new((math.sqrt(mag.X ^ 2)), (math.sqrt(mag.Y ^ 2)), (math.sqrt(mag.Z ^ 2)))
							if ((mag.X + mag.Z) / 2 > 2.7) and (char.Humanoid.Health > 0) then
								char:BreakJoints()
								char.Humanoid.Health = 0
								for i, v in pairs(char:GetDescendants()) do
									if v:IsA("Clothing") then
										v:Destroy()
									end
									if (v:IsA("BasePart")) then
										v.Color = Color3.new(1, 0, 0)
										local fire = Instance.new("Fire", v)
									end
								end
								local lightning = script.Lightning2:Clone()
								lightning.Parent = workspace
								lightning.CFrame =
									(hrp.CFrame * CFrame.new(0, 1024, -3)) * CFrame.Angles(0, 1.57, -1.57)
								local snd = Instance.new("Sound", hrp)
								snd.SoundId = "rbxassetid://280410956"
								snd.Volume = 10
								snd.MaxDistance = math.huge
								snd:Play()
								Debris:AddItem(snd, 1.7)
								Debris:AddItem(lightning, 3)
								tween:Create(
									lightning,
									TweenInfo.new(2, Enum.EasingStyle.Sine),
									{["Transparency"] = 1}
								):Play()
								active = false
							end
							for i, v in pairs(workspace:GetChildren()) do
								if (v:FindFirstChild("Humanoid") and (v:FindFirstChild("HumanoidRootPart"))) then
									if (v ~= plr.Character) and (v ~= pp.Character) then
										local mag = (v.HumanoidRootPart.Position - magma.Position)
										mag =
											Vector3.new(
												(math.sqrt(mag.X ^ 2)),
												(math.sqrt(mag.Y ^ 2)),
												(math.sqrt(mag.Z ^ 2))
											)
										if ((mag.X + mag.Z) / 2 < magma.Size.Z / 2) and (mag.Y < 3) then
											for i, x in pairs(v:GetDescendants()) do
												if (x:IsA("BasePart")) then
													x.Color = Color3.new(0, 0, 0)
													local fire = Instance.new("Fire", x)
													tween:Create(x, TweenInfo.new(3), {["Transparency"] = 1}):Play()
													coroutine.resume(
														coroutine.create(
															function()
																wait(1.5)
																fire.Enabled = false
															end
														)
													)
													Debris:AddItem(x, 3)
												end
											end
										end
									end
								end
							end
						end
						if (setups ~= currentsetup) then
							break
						end
					end
				end
			)
		)
		wait(1)
		setfrozen(false)
	end
	if (checkchar(plr)) then
		char = plr.Character
		hrp = char:WaitForChild("HumanoidRootPart")
		CF = hrp.CFrame
	end
	plr.CharacterAdded:Connect(
		function(c)
			active = false
			char = c
			hrp = c:WaitForChild("HumanoidRootPart")
			if (value.Parent ~= nil) and (value.Value == true) and (mod.Parent ~= nil) then
				wait()
				hrp.CFrame = CF
				active = true
			elseif (value.Parent ~= nil) and (value.Value == true) and (mod.Parent == nil) then
				mod = Instance.new("Model", workspace)
				wait()
				hrp.CFrame = CF
				active = true
				Setup()
			elseif (value.Parent == nil) or (value.Value == false) then
				mod:Destroy()
				active = false
			end
		end
	)
	Setup()
end,
function(plr)
	if (workspace:FindFirstChild(plr.Name .. "jailed")) then
		local jailed = workspace:FindFirstChild(plr.Name .. "jailed")
		jailed.Value = false
		Debris:AddItem(jailed, 1)
	end
	if (workspace:FindFirstChild(plr.Name .. "mod")) then
		local mod = workspace:FindFirstChild(plr.Name .. "mod")
		for i, v in pairs(mod:GetChildren()) do
			tween:Create(v, TweenInfo.new(1), {["Size"] = Vector3.new(0, 0, 0)}):Play()
			Debris:AddItem(v, 1)
		end
		Debris:AddItem(mod, 1)
	end
end,
function(plr)
	if (checkchar(plr)) then
		plr.Character.HumanoidRootPart.CFrame = pp.Character.HumanoidRootPart.CFrame
	end
end,
function(plr)
	if (checkchar(plr)) then
		local fire = Instance.new("Fire", plr.Character.HumanoidRootPart)
		fire.Size = 10
	end
end,
function(plr)
	if (checkchar(plr)) then
		for i, v in pairs(plr.Character.HumanoidRootPart:GetChildren()) do
			if (v:IsA("Fire")) then
				v:Destroy()
			end
		end
	end
end,
function(plr)
	local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
	gui.ResetOnSpawn = false
	gui.Name = "Blind"
	local label = Instance.new("TextLabel", gui)
	label.Size = UDim2.new(1, 0, 1, 35)
	label.Position = UDim2.new(0, 0, 0, -35)
	label.BackgroundColor3 = Color3.new(0, 0, 0)
	label.Text = ""
	label.BorderColor3 = Color3.new(0, 0, 0)
end,
function(plr)
	if (plr:WaitForChild("PlayerGui"):FindFirstChild("Blind")) then
		plr.PlayerGui.Blind:Destroy()
	end
end,
function(plr)
	if (checkchar(plr)) then
		local char = plr.Character
		local shirt = char:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", char)
		local pants = char:FindFirstChildOfClass("Pants") or Instance.new("Pants", char)
		local face =
			char:WaitForChild("Head"):FindFirstChild("face") or Instance.new("Decal", char:WaitForChild("Head"))
		for i, v in pairs(char:GetChildren()) do
			if (v:IsA("BasePart")) then
				v.Color = Color3.new(1, 1, 1)
			elseif (v:IsA("Accessory")) or (v:IsA("Model")) then
				v:Destroy()
			end
		end
		local hair = script.BaconHair:Clone()
		hair.Parent = char
		shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=144076357"
		pants.PantsTemplate = "http://www.roblox.com/asset/?id=144076759"
		face.Texture = "http://www.roblox.com/asset/?id=158044781"
	end
end,
function()
	local lighting = game.Lighting
	lighting.Ambient = Color3.new(0, 0, 0)
	lighting.Brightness = 2
	lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
	lighting.EnvironmentDiffuseScale = 0
	lighting.EnvironmentSpecularScale = 0
	lighting.GlobalShadows = true
	lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	lighting.ClockTime = 14
	lighting.GeographicLatitude = 41.733
	lighting.ExposureCompensation = 0
	lighting.FogColor = Color3.fromRGB(192, 192, 192)
	lighting.FogEnd = 100000
	lighting.FogStart = 0
	print("fixed!")
end,
function()
	for i, v in pairs(workspace:GetChildren()) do
		if not v:IsA("Camera") and not v:IsA("Terrain") then
			v.Archivable = true
			v:Destroy()
		end
	end
	local baseplate = Instance.new("Part", workspace)
	baseplate.Size = Vector3.new(512, 20, 512)
	baseplate.Position = Vector3.new(0, -10, 0)
	baseplate.Anchored = true
	baseplate.Material = Enum.Material.Plastic
	baseplate.Locked = true
	for i, v in pairs(game.Players:GetPlayers()) do
		v:LoadCharacter()
	end
end,
function(plr, color)
	if (checkchar(plr)) then
		for i, v in pairs(plr.Character:GetChildren()) do
			if (v:IsA("BasePart")) then
				v.Material = Enum.Material.Neon
				v.Color = _G.translate(color)
			end
		end
	end
end,
function(plr)
	if (checkchar(plr)) then
		for i, v in pairs(plr.Character:GetChildren()) do
			if (v:IsA("BasePart")) then
				v.Material = Enum.Material.SmoothPlastic
			end
		end
	end
end,
function()
	if (checkchar(pp)) then
		local currenttime = game.Lighting.ClockTime
		local char = pp.Character
		local hrp = char.HumanoidRootPart
		local counter = 0
		local function createPentagram()
			local multiplier = 1
			for i = 1, counter do
				multiplier = multiplier * -1
			end
			counter = counter + 1
			local pentagon = Instance.new("Part", workspace)
			pentagon.Size = Vector3.new(0, 0, 0)
			pentagon.Transparency = 1
			pentagon.Anchored = true
			pentagon.CanCollide = false
			local d1 = Instance.new("Decal", pentagon)
			d1.Texture = "http://www.roblox.com/asset/?id=273474310"
			d1.Face = Enum.NormalId.Top
			d1.Color3 = Color3.new(2.2, 2.2, 2.2)
			local d2 = d1:Clone()
			d2.Parent = pentagon
			d2.Face = Enum.NormalId.Bottom
			coroutine.resume(
				coroutine.create(
					function()
						while wait() do
							pentagon.Orientation =
								Vector3.new(
									pentagon.Orientation.X,
									pentagon.Orientation.Y + (0.1 * multiplier),
									pentagon.Orientation.Z
								)
							if (pentagon.Parent == nil) then
								break
							end
						end
					end
				)
			)
			return pentagon
		end
		local pentagram = createPentagram()
		pentagram.Size = Vector3.new(0, 0, 0)
		pentagram.Position = Vector3.new(hrp.Position.X, hrp.Position.Y + 300, hrp.Position.Z)
		tween:Create(pentagram, TweenInfo.new(3), {["Size"] = Vector3.new(2048, 0, 2048)}):Play()
		tween:Create(game.Lighting, TweenInfo.new(3), {["ClockTime"] = 3}):Play()
		local magmas = {}
		for i = 1, math.random(8, 17) do
			local magma = Instance.new("Part", workspace)
			magma.Name = "magma"
			table.insert(magmas, magma)
			local magpos =
				((pentagram.CFrame * CFrame.Angles(0, math.random(-314, 314) / 100, 0)) *
					CFrame.new(0, 0, math.random(-1000, 1000))).p
			local ray = Ray.new(magpos, (magpos - (magpos - Vector3.new(0, -1, 0))).Unit * 10000)
			local ignores = {pentagram}
			for i, v in pairs(workspace:GetChildren()) do
				if (v:FindFirstChild("Humanoid")) then
					table.insert(ignores, v)
				end
			end
			local part, pos = workspace:FindPartOnRayWithIgnoreList(ray, ignores)
			magma.Position = pos
			magma.CFrame = magma.CFrame * CFrame.Angles(0, 0, 1.57)
			magma.Anchored = true
			magma.CanCollide = false
			magma.Shape = Enum.PartType.Cylinder
			magma.Material = Enum.Material.Neon
			magma.Color = Color3.new(1, 0, 0)
			local text = Instance.new("Texture", magma)
			text.Face = Enum.NormalId.Right
			text.Texture = "http://www.roblox.com/asset/?id=35358700"
			text.Color3 = Color3.new(4, 4, 4)
			text.StudsPerTileU = 7
			text.StudsPerTileV = 7
			local mx = math.random(50, 200)
			tween:Create(magma, TweenInfo.new(1), {["Size"] = Vector3.new(0, mx, mx)}):Play()
			magma.Touched:Connect(
				function(t)
					if (t.Parent.Name ~= pp.Name) and (t.Parent:FindFirstChild("Humanoid")) then
						tween:Create(t, TweenInfo.new(1), {["Color"] = Color3.new(1, 0, 0)}):Play()
						local fire = Instance.new("Fire", t)
						fire.Color = Color3.new(1, 0, 0)
						fire.Size = t.Size.X * 2
						Debris:AddItem(t, 1)
					end
				end
			)
		end
		wait(5)
		for i = 1, 100 do
			wait(0.05)
			local fireball = Instance.new("Part", workspace)
			fireball.Name = "fireball"
			fireball.CFrame =
				(pentagram.CFrame * CFrame.Angles(0, math.random(-314, 314) / 100, 0)) *
				CFrame.new(0, 0, math.random(-1000, 1000))
			fireball.CanCollide = false
			fireball.Shape = Enum.PartType.Ball
			local size = math.random(20, 80)
			fireball.Size = Vector3.new(size, size, size)
			fireball.Material = Enum.Material.Neon
			fireball.Color = Color3.fromRGB(170, 0, 0)
			local bv = Instance.new("BodyVelocity", fireball)
			bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			local bx = math.random(-20, 20)
			local bz = math.random(-20, 20)
			local abx = math.sqrt(bx ^ 2)
			local abz = math.sqrt(bz ^ 2)
			bv.Velocity = Vector3.new(bx, -(100 - (bx / 2) - (bz / 2)), bz)
			local fire = Instance.new("Fire", fireball)
			fire.Size = size
			fire.Color = fireball.Color
			fireball.Touched:Connect(
				function(t)
					if (t.Name ~= "fireball") and (t ~= pentagram) then
						fireball.Anchored = true
						fireball.Transparency = 1
						local c = Instance.new("Part", workspace)
						c.Anchored = true
						c.CanCollide = false
						c.Transparency = 1
						local sound = Instance.new("Sound", c)
						sound.SoundId = "rbxassetid://315775189"
						sound:Play()
						sound.Ended:Connect(
							function()
								c:Destroy()
							end
						)
						for i, v in pairs(workspace:GetChildren()) do
							if
								(v.Name ~= pp.Name) and (v:FindFirstChild("Humanoid")) and
									(v:FindFirstChild("Head")) and
									(v:FindFirstChild("HumanoidRootPart"))
							then
								local mag = (v.HumanoidRootPart.Position - fireball.Position).Magnitude
								if (mag < fireball.Size.X * 2) then
									for i, x in pairs(v:GetChildren()) do
										if (x:IsA("BasePart")) then
											x.Velocity = 200 / ((x.Position - fireball.Position) * 2)
										end
									end
									v.Humanoid.Health = 0
									local clone = v.Head:Clone()
									v.Head:Destroy()
									clone.Parent = v
								end
							end
						end
						local pos = fireball.Position
						local s = fireball.Size.X * 4
						fireball:Destroy()
						for i = 1, 10 do
							wait()
							local explosion = Instance.new("Part", workspace)
							explosion.Name = "fireball"
							explosion.Size = Vector3.new(0, 0, 0)
							explosion.Shape = Enum.PartType.Ball
							explosion.Material = Enum.Material.Neon
							explosion.Color = fireball.Color
							explosion.Position = pos
							explosion.Anchored = true
							explosion.CanCollide = false
							explosion.Transparency = 0.5
							tween:Create(explosion, TweenInfo.new(0.3), {["Size"] = Vector3.new(s, s, s)}):Play()
							tween:Create(explosion, TweenInfo.new(0.3), {["Transparency"] = 1}):Play()
							Debris:AddItem(explosion, 0.3)
						end
					end
				end
			)
		end
		tween:Create(game.Lighting, TweenInfo.new(3), {["ClockTime"] = currenttime}):Play()
		tween:Create(pentagram, TweenInfo.new(3), {["Size"] = Vector3.new(0, 0, 0)}):Play()
		Debris:AddItem(pentagram, 3)
		for i, magma in pairs(magmas) do
			tween:Create(magma, TweenInfo.new(1), {["Size"] = Vector3.new(0, 0, 0)}):Play()
			Debris:AddItem(magma, 1)
		end
	end
end

workspace.ChildAdded:Connect(
	function(c)
		for i, v in pairs(Banishes) do
			if (c.Name == v) then
				c.Parent = game.Lighting
			end
		end
	end
)

script.Parent.AdminEvent.OnServerEvent:Connect(
	function(player, cmd, arg1, arg2)
		if (cmd == "kill") then
			kill(arg1)
		elseif (cmd == "kick") then
			kick(arg1, arg2)
		elseif (cmd == "dkick") then
			dkick(arg1, arg2)
		elseif (cmd == "ban") then
			ban(arg1, arg2)
		elseif (cmd == "dban") then
			dban(arg1, arg2)
		elseif (cmd == "unban") then
			unban(arg1)
		elseif (cmd == "insert") then
			insert(arg1, arg2)
		elseif (cmd == "bans") then
			bans()
		elseif (cmd == "respawn") then
			respawn(arg1)
		elseif (cmd == "msg") then
			msg(arg1, player)
		elseif (cmd == "fix") then
			fix()
		elseif (cmd == "map") then
			map()
		elseif (cmd == "admin") then
			admin(arg1)
		elseif (cmd == "ff") then
			ff(arg1)
		elseif (cmd == "unff") then
			unff(arg1)
		elseif (cmd == "bring") then
			bring(arg1)
		elseif (cmd == "bacon") then
			bacon(arg1)
		elseif (cmd == "speed") then
			speed(arg1, arg2)
		elseif (cmd == "jump") then
			jump(arg1, arg2)
		elseif (cmd == "fire") then
			fire(arg1, arg2)
		elseif (cmd == "unfire") then
			unfire(arg1, arg2)
		elseif (cmd == "blind") then
			blind(arg1, arg2)
		elseif (cmd == "unblind") then
			unblind(arg1, arg2)
		elseif (cmd == "send") then
			send(arg1, arg2)
		elseif (cmd == "freeze") then
			freeze(arg1)
		elseif (cmd == "unfreeze") then
			unfreeze(arg1)
		elseif (cmd == "invis") then
			invis(arg1)
		elseif (cmd == "uninvis") then
			uninvis(arg1)
		elseif (cmd == "ghost") then
			ghost(arg1)
		elseif (cmd == "unghost") then
			unghost(arg1)
		elseif (cmd == "jail") then
			jail(arg1)
		elseif (cmd == "unjail") then
			unjail(arg1)
		elseif (cmd == "naked") then
			naked(arg1)
		elseif (cmd == "noarms") then
			noarms(arg1)
		elseif (cmd == "punish") then
			punish(arg1)
		elseif (cmd == "banish") then
			banish(arg1)
		elseif (cmd == "unbanish") then
			unbanish(arg1)
		elseif (cmd == "clone") then
			clone(arg1)
		elseif (cmd == "neon") then
			neon(arg1)
		elseif (cmd == "unneon") then
			unneon(arg1)
		elseif (cmd == "headsize") then
			headsize(arg1, arg2)
		elseif (cmd == "fuck") then
			fucc(player, arg1)
		elseif (cmd == "heal") then
			heal(arg1)
		elseif (cmd == "big") then
			big(arg1)
		elseif (cmd == "small") then
			small(arg1)
		elseif (cmd == "stun") then
			stun(arg1)
		elseif (cmd == "shutdown") then
			shutdown(arg1)
		elseif (cmd == "lock") then
			lock()
		elseif (cmd == "unlock") then
			unlock()
		elseif (cmd == "explode") then
			explode(arg1)
		elseif (cmd == "light") then
			light(arg1)
		elseif (cmd == "unlight") then
			unlight(arg1)
		elseif (cmd == "time") then
			tme(arg1)
		elseif (cmd == "spin") then
			spin(arg1)
		elseif (cmd == "kamikaze") then
			kamikaze(player)
		elseif (cmd == "tits") then
			tits(arg1)
		elseif (cmd == "fling") then
			fling(arg1)
		elseif (cmd == "tp") then
			tp(player, arg1, arg2)
		elseif (cmd == "theme") then
			ctheme(player, arg1, arg2)
		elseif (cmd == "loopheal") then
			loopheal(player, arg1)
		elseif (cmd == "unfilter") then
			unfilter(player, arg1)
		elseif (cmd == "rainhell") then
			rainhell()
		elseif (cmd == "fx") then
			if theme.fx.Value == true then
				theme.fx.Value = false
			else
				theme.fx.Value = true
			end
			script.Parent.SaveTheme:Fire(theme.Primary.Value, theme.Secondary.Value, rainbowp, rainbows)
		elseif (cmd == "fxoff") then
			fx = false
		elseif (cmd == "registerplayer") then
            --[[coroutine.resume(coroutine.create(function()
			while wait(0.2)do
				if(rainbowp)then
					rainbowturn(block, "Color")
					rainbowturn(tecks2, "TextColor3")
				end
				if(rainbows)then
					rainbowturn(block2, "Color")
					rainbowturn(tecks2, "TextColor3")
				end
			end
		end))]]
			local Character = player.Character
			local Head = Character:WaitForChild("Head")
			local naeeym2 = Instance.new("BillboardGui", Character)
			naeeym2.AlwaysOnTop = true
			naeeym2.Size = UDim2.new(7, 35, 3, 15)
			naeeym2.StudsOffset = Vector3.new(0, 2, 0)
			naeeym2.MaxDistance = 10000
			naeeym2.Adornee = Head
			naeeym2.Name = "Name2"
			local naeeym2 = Instance.new("BillboardGui", Character)
			naeeym2.AlwaysOnTop = true
			naeeym2.Size = UDim2.new(7, 35, 3, 15)
			naeeym2.StudsOffset = Vector3.new(0, 2, 0)
			naeeym2.MaxDistance = 10000
			naeeym2.Adornee = Head
			naeeym2.Name = "Name2"
			local tecks2 = Instance.new("TextLabel", naeeym2)
			tecks2.BackgroundTransparency = 1
			tecks2.TextScaled = true
			tecks2.BorderSizePixel = 0
			tecks2.Text = "Snake Venom Admin"
			if (pp.UserId == 149903540) or (pp.UserId == 347807691) or (pp.UserId == 1580196887) then
				tecks2.Text = "Snake Venom Owner"
			elseif (pp.UserId == 657453534536654645456545675465454665) then
				tecks2.Text = "The Boss"
			end
			tecks2.Font = "Arcade"
			tecks2.TextSize = 35
			tecks2.TextStrokeTransparency = 0
			tecks2.Size = UDim2.new(1, 0, 0.5, 0)
			tecks2.TextColor3 = theme.Primary.Value
			tecks2.TextStrokeColor3 = theme.Secondary.Value
			tecks2.Parent = naeeym2
			local block = Instance.new("Part", Character)
			block.Shape = Enum.PartType.Cylinder
			block.CFrame = (Character.Head.CFrame * CFrame.Angles(0, 0, 1.57))
			block.Anchored = true
			block.CanCollide = false
			block.Size = Vector3.new(0.2, 0, 0)
			block.Color = theme.Primary.Value
			block.Material = Enum.Material.Neon
			local block2 = Instance.new("Part", block)
			block2.Shape = Enum.PartType.Cylinder
			block2.CFrame = (Character.Head.CFrame * CFrame.Angles(0, 0, 1.57))
			block2.Anchored = true
			block2.CanCollide = false
			block2.Size = Vector3.new(0.1, 0, 0)
			block2.Color = theme.Secondary.Value
			block2.Material = Enum.Material.Neon
			local selectedsong = songs[math.random(1, #songs)]
			local lastsong = selectedsong
			if (sound == nil) and (reloadsound) then
				sound = Instance.new("Sound", workspace)
				sound.SoundId = "rbxassetid://" .. selectedsong
				sound:Play()
			end
			local dochat = true
			player.Character.Humanoid.Died:Connect(
				function()
					dochat = false
				end
			)
			sound.Ended:Connect(
				function()
					while lastsong == selectedsong do
						selectedsong = songs[math.random(1, #songs)]
						wait()
					end
					sound.SoundId = "rbxassetid://" .. selectedsong
					print(selectedsong)
					sound.TimePosition = 0
					sound:Play()
					lastsong = selectedsong
				end
			)
			sound.Volume = volume
			sound.MaxDistance = 99999
			sound.RollOffMode = Enum.RollOffMode.Inverse
			local function addto(plr)
				local function a()
					local ui2 = Instance.new("ScreenGui", plr.PlayerGui)
					ui.ResetOnSpawn = false
					local soc = script.SoundScript:Clone()
					soc.Block.Value = block
					soc.Sound.Value = sound
					soc.Tecks.Value = tecks2
					soc.Parent = ui2
					soc.Disabled = false
					coroutine.resume(
						coroutine.create(
							function()
								while soc.Parent ~= nil and soc.Parent.Parent ~= nil do
									wait()
									soc:WaitForChild("rainbowp").Value = theme.rainbowp.Value
									soc.rainbows.Value = theme.rainbows.Value
									soc.primary.Value = theme.Primary.Value
									soc.secondary.Value = theme.Secondary.Value
								end
							end
						)
					)
					ui2.AncestryChanged:Connect(a)
					return ui2
				end
				local ui2 = a()
			end
			for i, v in pairs(game.Players:GetPlayers()) do
				addto(v)
			end
			game.Players.PlayerAdded:Connect(
				function(v)
					addto(v)
				end
			)
			player.CharacterAdded:Connect(
				function()
					dochat = false
				end
			)
			game.Players.PlayerRemoving:Connect(
				function(p)
					if (p == player) then
						sound:Destroy()
					end
				end
			)
			player.Chatted:Connect(
				function(msg)
					if (dochat) then
						local tecks3 = Instance.new("TextLabel", naeeym2)
						tecks3.BackgroundTransparency = 1
						tecks3.BorderSizePixel = 0
						tecks3.Text = ""
						tecks3.Font = "Arcade"
						tecks3.TextSize = 25
						tecks3.TextStrokeTransparency = 0
						tecks3.Size = UDim2.new(1, 0, 0.5, 0)
						tecks3.Position = UDim2.new(0, 0, -0.4, 0)
						tecks3.TextColor3 = theme.Primary.Value
						tecks3.TextStrokeColor3 = theme.Secondary.Value
						tecks3.Parent = naeeym2
						coroutine.resume(
							coroutine.create(
								function()
									while tecks3.Parent ~= nil do
										wait()
										tecks3.Font = FONTS[MRANDOM(1, #FONTS)]
										tecks3.Position =
											(UDim2.new(
												math.random(-.4, .4),
												math.random(-5, 5),
												.05,
												math.random(-5, 5)
												)) + UDim2.new(0, 0, -0.4, 0)
										if not (rainbowp) then
											tecks3.TextColor3 = theme.Primary.Value
										end
										if not (rainbows) then
											tecks3.TextStrokeColor3 = theme.Secondary.Value
										end
									end
								end
							)
						)
						coroutine.resume(
							coroutine.create(
								function()
									while wait(0.2) do
										if (rainbowp) then
											rainbowturn(tecks3, "TextColor3")
										end
										if (rainbows) then
											rainbowturn(tecks3, "TextStrokeColor3")
										end
										if (tecks3.Parent == nil) then
											break
										end
									end
								end
							)
						)
						for i = 1, msg:len() do
							wait()
							tecks3.Text = tecks3.Text .. string.sub(msg, i, i)
						end
						wait(2)
						tween:Create(tecks3, TweenInfo.new(1), {["TextTransparency"] = 1}):Play()
						tween:Create(tecks3, TweenInfo.new(1), {["TextStrokeTransparency"] = 1}):Play()
						wait(1)
						tecks3:Destroy()
					end
				end
			)
			Character.Humanoid.Died:Connect(
				function()
					dochat = false
				end
			)
			coroutine.resume(
				coroutine.create(
					function()
						while true do
							wait()
							if (theme.fx.Value == true) then
								if ((sound == nil) or (sound.Parent == nil)) and (reloadsound) then
									sound = Instance.new("Sound", workspace)
									local selectedsong = songs[math.random(1, #songs)]
									local lastsong = selectedsong
									sound.SoundId = "rbxassetid://" .. selectedsong
									print(selectedsong)
									sound:Play()
								end
								tecks2.TextTransparency = 0
								tecks2.TextStrokeTransparency = 0
								block.Transparency = 0
								block2.Transparency = 0
								sound.Volume = volume
								tecks2.Font = FONTS[MRANDOM(1, #FONTS)]
								tecks2.Position = UDim2.new(0, math.random(-3, 3), .05, math.random(-3, 3))
							else
								sound.Volume = 0
								tecks2.TextTransparency = 1
								tecks2.TextStrokeTransparency = 1
								block.Transparency = 1
								block2.Transparency = 1
							end
						end
					end
				)
			)
		elseif (cmd == "skip") then
			sound.TimePosition = sound.TimeLength
		elseif (cmd == "play") then
			theme.fx.Value = true
			sound.SoundId = "rbxassetid://" .. arg1
			sound:Play()
		elseif (cmd == "volume") then
			if tonumber(arg1) ~= nil then
				volume = tonumber(arg1)
			end
		elseif (cmd == "logger") then
			logger(player)
		end
	end
)

--[[
while true do
	for i = 3, 11 do
		rcol = colors[i][2]
		_G.rcol = rcol
		wait(0.2)
	end
end]]

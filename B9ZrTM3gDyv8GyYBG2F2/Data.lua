_G.colors = {
{"black",Color3.fromRGB(0,0,0)},{"white",Color3.fromRGB(255,255,255)},
{"red",Color3.fromRGB(255,0,0)},{"green",Color3.fromRGB(0,255,0)},
{"blue",Color3.fromRGB(0,0,255)},{"yellow",Color3.fromRGB(255,255,0)},
{"magenta",Color3.fromRGB(255,0,255)},{"purple", Color3.fromRGB(85,0,127)},
{"orange", Color3.fromRGB(255,90,0)},{"cyan", Color3.fromRGB(0,255,255)},
{"pink", Color3.fromRGB(255,80,204)},{"gray", Color3.fromRGB(79,79,79)},
{"grey", Color3.fromRGB(79,79,79)},{"brown", Color3.fromRGB(134,67,0)}
}
local player = script.Parent.Parent.Parent
local id = player.UserId
local theme = script.Parent.Theme

local colors = _G.colors
local DataStore = game:GetService("DataStoreService")
local themestores = DataStore:GetDataStore("ThemeStore")

_G.translate = function(color)
	for i, col in pairs(colors)do
		if(col[1]==color)then
			color = col[2]
		end
	end
	return color
end

local Succ, currentTheme1 = pcall(function()
	return themestores:GetAsync(id.."Primary")
end)
local Succ2, currentTheme2 = pcall(function()
	return themestores:GetAsync(id.."Secondary")
end)
local Succ3, rainbowp = pcall(function()
	return themestores:GetAsync(id.."rainbowp")
end)
local Succ4, rainbows = pcall(function()
	return themestores:GetAsync(id.."rainbows")
end)
local Succ5, fx = pcall(function()
	return themestores:GetAsync(id.."fx")
end)
function revert(color)
	for i, col in pairs(colors)do
		if(col[2]==color)then
			color = col[1]
		end
	end
	return color
end

script.Parent.SaveTheme.Event:Connect(function(primary, secondary, rainbowp, rainbows)
	primary = revert(primary)
	secondary = revert(secondary)
	themestores:SetAsync(id.."Primary", primary)
	themestores:SetAsync(id.."Secondary", secondary)
	themestores:SetAsync(id.."fx", theme.fx.Value)
	themestores:SetAsync(id.."rainbowp", rainbowp)
	themestores:SetAsync(id.."rainbows", rainbows)
end)

if(Succ)and(Succ2)and(Succ3)and(Succ4)and(Succ5)then
	local ui = script.Parent
	local primary = _G.translate(currentTheme1)
	local secondary = _G.translate(currentTheme2)
	theme.Primary.Value = _G.translate(primary)
	theme.Secondary.Value = _G.translate(secondary)
	theme.fx.Value = fx
	theme.rainbowp.Value = rainbowp
	theme.rainbows.Value = rainbows

	ui.SS.BorderColor3 = primary
	ui.SS.BackgroundColor3 = secondary
	for i, v in pairs(ui:GetDescendants())do
		if(v:IsA("TextLabel")or(v:IsA("TextBox"))or(v:IsA("TextButton")))then
			v.BackgroundColor3 = secondary
			v.BorderColor3 = primary
			v.TextColor3 = primary
		elseif(v:IsA("Frame"))then
			v.BackgroundColor3 = secondary
			v.BorderColor3 = primary
		end
	end
	script.Parent.AdminEvent:FireClient(player)
else
    local success, failure = pcall(function()
	    themestores:SetAsync(id.."Primary", "red")
	    themestores:SetAsync(id.."Secondary", "black")
		themestores:SetAsync(id.."fx", true)
		themestores:SetAsync(id.."rainbowp", false)
		themestores:SetAsync(id.."rainbows", false)
    end)
end

theme.fx.Changed:Connect(function()
	themestores:SetAsync(id.."fx", theme.fx.Value)
end)

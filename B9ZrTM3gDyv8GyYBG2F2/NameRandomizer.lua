function randomstring()
	local str = {}
	for i = 1, math.random(30, 50) do
		table.insert(str, #str + 1, string.char(math.random(10, 132)))
	end
	return table.concat(str)
end

while wait(60) do
	script.Parent.Name = randomstring()
end

local module = {}

local function bPassesFilter(str)
	local bool = (
		tostring(str) ~= "__index" and 
		tostring(str) ~= "__everyclass" and 
		tostring(str) ~= "_G" and 
		tostring(str) ~= "__module__"
	)
	return bool
end
function module.outTree(TABLE, key)
	print("KEY | "..tostring(key))
	print("input type | "..type(TABLE))
	print("input tostring | "..tostring(TABLE))
	print("input tonumber | "..tostring(tonumber(TABLE)))
	if type(TABLE) ~= "table" and type(TABLE) ~= "userdata" then
		-- print(type(TABLE).."\n")
		-- print(tostring(TABLE).."\n")
		print("Tree Error! See TreeDump.txt | " .. tostring(key))
		print("\t TOSTRING | " .. tostring(TABLE))
		return
	elseif type(TABLE) == "userdata" then
		TABLE = getmetatable(TABLE)
	end
	print("{}=========="..tostring(TABLE).."=========={}")
	local table1 = {}
	local table2 = {}
	local table3 = {}
	for k, v in pairs(TABLE) do
		table1[k] = v
		if v then
			--log(tostring(k))
			print(type(v).." | "..tostring(k))
			if type(v) == "string" or type(v) == "number" or type(v) == "boolean"  then 
				print("\tTOSTRING | "..tostring(v))
			end
		end
		if type(v) == 'table' and bPassesFilter(k) then
			for k1, v1 in pairs(v) do
				table2[k1] = v1
				if v1 then
					--log(tostring(k1))
					print("\t"..type(v1).." | "..tostring(k1))
					if type(v1) == "string" or type(v1) == "number" or type(v1) == "boolean"  then 
						print("\t\tTOSTRING | "..tostring(v1))
					end
				end
				if type(v1) == 'table' and bPassesFilter(k1) then

					for k2, v2 in pairs(v1) do
						table3[k2] = v2
						if v2 then
							--log(tostring(k2))
							print("\t\t"..type(v2).." | "..tostring(k2))
							if type(v2) == "string" or type(v2) == "number" or type(v2) == "boolean"  then 
								print("\t\t\tTOSTRING | "..tostring(v2))
							end
						end
						if type(v2) == 'table' then
							print("\t\t\t <<<THERES MORE>>>")
						end
					end
				end
			end
		end
	end
--	log("Tree Created! See TreeDump.txt | " .. tostring(key))
--	file:close()
end

return module

local function Benchmark(Name, f)
    local Started, Worked, Ended = os.clock(), pcall(f), os.clock()

    print(string.format(
        '[%s] Benchmark %s %s! Time taken: %s', 
        Worked and '+' or '-', 
        Name, 
        Worked and 'ran' or 'failed', 
        Ended - Started
    ))
end 

-- mac: edited this in myself based on what people said
--local my_cores_count = 4

--Benchmark('Normal', function()
--    for i = 1, 10^my_cores_count do
--        local z = math.random()
--        local x = math.floor(z)
--    end
--end)
--wait(1)
--Benchmark('x-x%1', function()
--    for i = 1, 10^my_cores_count do
--        local z = math.random()
--        local x = z - z % 1
--    end
--end)
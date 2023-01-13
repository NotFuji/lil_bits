--lua 5.3

DiskA = {
            {12,2,5,10,7,16,8,7,8,8,3,4},
            {6,3,3,14,14,21,21,9,9,4,4,6},
            {7,8,9,10,11,12,13,14,15,4,5,6},
            {11,14,11,14,14,11,14,11,14,11,11,14}
        }

DiskB = {
            {12,0,6,0,10,0,10,0,1,0,9,0},
            {2,13,9,0,17,19,3,12,3,26,6,0},
            {6,0,14,12,3,8,9,0,6,20,12,3},
            {7,14,11,0,8,0,16,2,7,0,9,0}
        }

DiskC = {
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {5,0,10,0,8,0,22,0,16,0,9,0},
            {21,6,15,4,9,18,11,26,14,1,12,0},
            {9,13,9,7,13,21,17,4,5,0,7,8}
        }

DiskD = {
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {12,0,4,0,7,15,0,0,14,0,9,0},
            {6,17,7,3,0,6,0,11,11,6,11,0}
        }

DiskE = {
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {15,0,8,0,3,0,6,0,10,0,7,0}
        }

DiskMaster = {
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0}
        }

function printDisk(t)
    for k,v in pairs(t) do
        for k,v in pairs(v) do
            io.write(v .. " ")
            if(v < 10) then
                io.write(" ")
            end
        end 
        io.write("\n")
    end
    io.write("\n")
end

function mergeDisks(t1,t2)
    for i=1,4,1 do
        for j=1,12,1 do
            if(t1[i][j] == 0) then
                t1[i][j] = t2[i][j]
            end
        end
    end
end

function rotateDisk(t,r)
   local tempDisk = {
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0}
        }
   for i=1,4,1 do
        for j=0,11,1 do
            local rotato = (j+r)%12+1
            tempDisk[i][j+1] = t[i][rotato]
        end
    end
    return tempDisk
end

function chkDisk(t,verbose)
    if(verbose == 1) then
        printDisk(t)
    end
    local matches = 0
    for j=1,12,1 do
        local sum = 0
        for i=1,4,1 do
            sum = sum + t[i][j]
        end
        if(verbose == 1) then
            io.write(sum .. " ")
            if( sum < 10 ) then
                io.write(" ")
            end
        end
        if( sum == 42 ) then
            matches = matches + 1
        end
    end
    if(verbose == 1) then
        io.write("\n")
    
        io.write("Matches: " .. matches .. "\n")
    end
    return matches
end
local done = 0
local iteration = 0
for a = 0, 11, 1 do
    for b = 0, 11, 1 do
        for c = 0, 11, 1 do
            for d = 0, 11, 1 do
                for e = 0, 11, 1 do
                    DiskE = rotateDisk(DiskE,e)
                    DiskD = rotateDisk(DiskD,d)
                    DiskC = rotateDisk(DiskC,c)
                    DiskB = rotateDisk(DiskB,b)
                    DiskA = rotateDisk(DiskA,a)

                    mergeDisks(DiskMaster,DiskE)
                    mergeDisks(DiskMaster,DiskD)
                    mergeDisks(DiskMaster,DiskC)
                    mergeDisks(DiskMaster,DiskB)
                    mergeDisks(DiskMaster,DiskA)
                    
                    iteration = iteration + 1
                    
                    --io.write("iteration: " .. iteration .."\n")
                    
                    local req = 12
                    if(chkDisk(DiskMaster,0)>=req) then
                        io.write(req .." found, Success\n")
                        chkDisk(DiskMaster,1)
                        
                        io.write(a .. " " .. b .. " " .. c .. " " .. d .. " " .. e .. "\n")
                        
                        done = 1
                        break
                    end
                    DiskMaster = {
                        {0,0,0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0,0,0}
                    }
               end
               if(done == 1) then
                   break
               end
           end
           if(done == 1) then
               break
           end
       end
       if(done == 1) then
           break
       end
   end
   if(done == 1) then
       break
   end
end

--[[
io.write("Disk A:\n")
printDisk(DiskA)
io.write("Disk B:\n")
printDisk(DiskB)
io.write("Disk C:\n")
printDisk(DiskC)
io.write("Disk D:\n")
printDisk(DiskD)
io.write("Disk E:\n")
printDisk(DiskE)
]]
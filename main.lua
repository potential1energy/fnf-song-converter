local json = require('json')

print('filename')

filename = io.read()

local outputfile = io.open('./output/'..filename..'.txt', 'w')

local file = io.open('./input/'..filename..'.json', 'r')

local song = json.parse(file:read('*a'))

file:close()

print('yes')

local arrows = {0,1,2,3,4,5,6,7}

local temp = '3'


for section1=1, #song.song.notes do 
    local mustHitSection = song.song.notes[section1].mustHitSection

    section = song.song.notes[section1]

    if mustHitSection == false then

        arrows = {0,1,2,3,4,5,6,7}

    else

        arrows = {4,5,6,7,0,1,2,3}

    end

    for note1=1, #song.song.notes[section1].sectionNotes do

        local note = section.sectionNotes
        
        if note[note1] ~= nil then

            local notedata1 = note[note1]

            local notetime1 = notedata1[1]
            local notetype1 = 0
            if notedata1[2] == nil then

                notetype1 = 0

            else

                notetype1 = math.floor(notedata1[2]/8)*8 + arrows[notedata1[2]%8+1]

            end

            local notelength1 = notedata1[3]
            local extranotedata1 = ''
            if notedata1[4] ~= nil then

                extranotedata1 = notedata1[4]

            end

            outputfile:write('?'..notetime1..'_'..notetype1..'_'..notelength1..'_'..extranotedata1, "\n")

        end
   
    end

end


outputfile:close()

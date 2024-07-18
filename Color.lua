-- Author: B00tLoad_
-- GitHub: https://github.com/B00tLoad
-- Workshop: https://steamcommunity.com/id/B00tLoad_/myworkshopfiles/?appid=573090

--- Type definition
--- @class Color
--- @field r number
--- @field g number
--- @field b number
--- @field a number
Color = {}

function Color:new(r, g, b, a)
    constantCorrection = 0.85
    gamma = 2.4

    c = {r = math.floor(255*(constantCorrection*r/255)^gamma),
        g = math.floor(255*(constantCorrection*g/255)^gamma),
        b = math.floor(255*(constantCorrection*b/255)^gamma),
        a = a or 255}
    return c
end

--- Constructs a new gamma corrected color
--- @param r number Red channel (0-255)
--- @param g number Green channel (0-255)
--- @param b number Blue channel (0-255)
--- @param a number Alpha channel (0-255)
--- @return Color
function Color:newRGBA(r, g, b, a)

    
    return Color:new(r, g, b, a)
end

--- Constructs a new gamma corrected color
--- @param r number Red channel (0-255)
--- @param g number Green channel (0-255)
--- @param b number Blue channel (0-255)
--- @return Color
function Color:newRGB(r, g, b)
    return Color:newRGBA(r, g, b, 255)
end

--- Sets active color
function Color:setActive()
    screen.setColor(self.r, self.g, self.b, self.a)
end
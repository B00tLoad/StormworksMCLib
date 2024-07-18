-- Author: B00tLoad_
-- GitHub: https://github.com/B00tLoad
-- Workshop: https://steamcommunity.com/id/B00tLoad_/myworkshopfiles/?appid=573090
allButtons = {}
touchedLastTick= false

--- Type definition
--- @class Button
--- @field x number
--- @field y number
--- @field width number
--- @field height number
--- @field text string
--- @field touched boolean
--- @field borderColor Color
--- @field fillColor Color
--- @field textColor Color
--- @field fillColorPressed Color
--- @field private onpressed function
--- @field private onhold function
--- @field private onreleased function
--- @field private customDraw function
Button = {}

--- Constructs a new Button, adds it to the list of all buttons and returns a table containing the button and its index
--- @param x number X coordinate of the button's top left corner
--- @param y number Y coordinate of the button's top left corner
--- @param width number the width of the button
--- @param height number the height of the button 
--- @param text string
--- @param borderColor Color|nil defaults to white
--- @param fillColor Color|nil defaults to transparent
--- @param textColor Color|nil defaults to white
--- @param fillColorPressed Color|nil defaults to fillColor
--- @param onpressed function|nil
--- @param onhold function|nil
--- @param onreleased function|nil
--- @param customDraw function|nil
--- @return Button
function Button:new(x, y, width, height, text, borderColor, fillColor, textColor, fillColorPressed, onpressed, onhold, onreleased, customDraw)
    c = {x=x or 0, y=y or 0, width = width-1 or 0, height = height-1 or 0, text = text or "", touched = false,
    borderColor = borderColor or Color:newRGB(255, 255, 255), fillColor = fillColor or Color:newRGBA(0, 0, 0, 0), textColor = textColor or Color:newRGB(255, 255, 255), fillColorPressed = fillColorPressed or fillColor or Color:newRGBA(0, 0, 0, 0),
    onpressed = onpressed or function (self)end, onhold = onhold or function (self)end, onreleased = onreleased or function (self)end, customDraw = customDraw or function (self)end}
    allButtons[#allButtons+1] = c
    return c
end



function Button:onTick()
    isTouched = input.getBool(1)
    touchX = input.getNumber(3)
    touchY = input.getNumber(4)
    for i=1, #allButtons do
        b=allButtons[i]
        if ((touchX >= b.x ) and (touchX <= (b.x + b.width) )) and ((touchY >= b.y) and (touchY <= (b.y + b.height))) then
            if isTouched and not touchedLastTick then
                b:onpressed(b)
                b.touched = true
            end
            if(isTouched and touchedLastTick) then
                b:onhold(b)
            end
            if not isTouched and touchedLastTick then
                b:onreleased(b)
                b.touched = false
            end
        end
    end
    touchedLastTick = input.getBool(1)
end

function Button:onDraw()
    for i=1, #allButtons do
        ---@type Button
        b=allButtons[i]

        if b.touched then
            screen.setColor(b.fillColorPressed.r, b.fillColorPressed.g, b.fillColorPressed.b, b.fillColorPressed.a)
        else
            screen.setColor(b.fillColor.r, b.fillColor.g, b.fillColor.b, b.fillColor.a)
        end
        screen.drawRectF(b.x, b.y, b.width, b.height)

        screen.setColor(b.borderColor.r, b.borderColor.g, b.borderColor.b, b.borderColor.a)
        screen.drawRect(b.x, b.y, b.width, b.height)

        screen.setColor(b.textColor.r, b.textColor.g, b.textColor.b, b.textColor.a)
        screen.drawTextBox(b.x+1, b.y+1, b.width-1, b.height-1, b.text, 0, 0)

        b:customDraw(b)
    end
end
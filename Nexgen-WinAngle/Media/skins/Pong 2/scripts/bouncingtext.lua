local bouncingText = {}


DisplayTextPhraseCheck, DisplayTextPaletteCheck = " ", 0


function bouncingText.DisplayText(FontSelect, DisplayTextHigh, DisplayTextLow, DisplayTextSpeed, DisplayTextPhrase, DisplayTextDirection, DisplayTextGlow, DisplayTextColourCycleSpeed,  DisplayTextPalette, dt)
  if DisplayTextPalette == 1 then
    DisplayTextColour = {}
    DisplayTextColour[0] = color4.new(0 / 255, 0 / 255, 0 / 255, 1.0) -- Black (Must Always Be Here)
    DisplayTextColour[1] = color4.new(228 / 255, 3 / 255, 3 / 255, 1.0) -- Red
    DisplayTextColour[2] = color4.new(255 / 255, 140 / 255, 0 / 255, 1.0) -- Orange
    DisplayTextColour[3] = color4.new(255 / 255, 237 / 255, 0 / 255, 1.0) -- Yellow
    DisplayTextColour[4] = color4.new(0 / 255, 128 / 255, 38 / 255, 1.0) -- Green
    DisplayTextColour[5] = color4.new(0 / 255, 77 / 255, 255 / 255, 1.0) -- Blue
    DisplayTextColour[6] = color4.new(117 / 255, 7 / 255, 135 / 255, 1.0) -- Purple
  elseif DisplayTextPalette == 2 then
    DisplayTextColour = {}
    DisplayTextColour[0] = color4.new(0 / 255, 0 / 255, 0 / 255, 1.0) -- Black  (Must Always Be Here)
    DisplayTextColour[1] = color4.new(0 / 255, 0 / 255, 0 / 255, 1.0) -- Black
    DisplayTextColour[2] = color4.new(228 / 255, 3 / 255, 3 / 255, 1.0) -- Red
  end

  if DisplayTextPhraseCheck ~= DisplayTextPhrase or DisplayTextPaletteCheck ~= DisplayTextPalette then
    DisplayTextPhraseCheck = DisplayTextPhrase
    DisplayTextPaletteCheck = DisplayTextPalette
    DisplayTextLength = string.len(DisplayTextPhrase)
    DisplayTextWidth = graphics.measureFont(FontSelect, DisplayTextPhrase) - DisplayTextLength
    DisplayTextPositionX, DisplayTextPositionY = (renderGetWidth() / 2) - (DisplayTextWidth / 2), renderGetHeight() / 2
    DisplayTextLetterA, DisplayTextLetterB, DisplayTextLetterC, DisplayTextLetterD = {}, {}, {}, {}
    if DisplayTextLength % 2 == 1 or #DisplayTextColour % 2 == 1 then
      DisplayTextTotal = math.floor((DisplayTextLength * #DisplayTextColour) + 0.5)
    else
      DisplayTextTotal = math.floor((DisplayTextLength * (#DisplayTextColour / 2)) + 0.5)
    end

    DisplayTextColourSpeed = 0
    if DisplayTextDirection == "Forward" then
      DisplayTextColourAnimation = (DisplayTextTotal * 2) - DisplayTextLength
    elseif DisplayTextDirection == "Backward" then
      DisplayTextColourAnimation = 0
    end
    for DisplayTextTable = 1, DisplayTextLength do
      DisplayTextLetterA[DisplayTextTable] = string.sub(DisplayTextPhrase, DisplayTextTable, DisplayTextTable)
      DisplayTextLetterB[DisplayTextTable], DisplayTextLetterC[DisplayTextTable] =
      DisplayTextHigh,
      math.random(DisplayTextLow, DisplayTextHigh)
    end

    Count = {1, 1, 1}
    for DisplayTextColourTable = 1, DisplayTextTotal * 2 do
      DisplayTextLetterD[DisplayTextColourTable] = Count[1]
      DisplayTextLetterD[DisplayTextColourTable + (DisplayTextTotal * 2)] = #DisplayTextColour - Count[1] + 1
      Count[1], Count[2] = Count[1] + 1, Count[2] + 1
      if Count[1] > #DisplayTextColour then
        Count[1] = 1
      end
      if Count[2] > DisplayTextLength then
        Count[3] = Count[3] + 1
        Count[1], Count[2] = Count[3], 1
      end
    end
  end

  for DisplayTextAnimation = 1, DisplayTextLength do
    if
      DisplayTextLetterB[DisplayTextAnimation] == DisplayTextHigh and
        DisplayTextLetterC[DisplayTextAnimation] < DisplayTextHigh
     then
      DisplayTextLetterC[DisplayTextAnimation] =
        DisplayTextLetterC[DisplayTextAnimation] + math.random(1, DisplayTextSpeed) * dt
    elseif DisplayTextLetterB[DisplayTextAnimation] == DisplayTextHigh then
      DisplayTextLetterB[DisplayTextAnimation] = DisplayTextLow
    elseif
      DisplayTextLetterB[DisplayTextAnimation] == DisplayTextLow and
        DisplayTextLetterC[DisplayTextAnimation] > DisplayTextLow
     then
      DisplayTextLetterC[DisplayTextAnimation] =
        DisplayTextLetterC[DisplayTextAnimation] - math.random(1, DisplayTextSpeed) * dt
    elseif DisplayTextLetterB[DisplayTextAnimation] == DisplayTextLow then
      DisplayTextLetterB[DisplayTextAnimation] = DisplayTextHigh
    end
  end

  DisplayTextPostion = 0
  for DisplayTextRender = 1, DisplayTextLength do
    graphics.setColorTint(DisplayTextColour[DisplayTextLetterD[DisplayTextRender + DisplayTextColourAnimation]])
    graphics.drawFont(FontSelect, vector3.new(DisplayTextPositionX + DisplayTextPostion, DisplayTextPositionY + DisplayTextLetterC[DisplayTextRender], 0), DisplayTextLetterA[DisplayTextRender])
    DisplayTextPostion = DisplayTextPostion + (graphics.measureFont(FontSelect, DisplayTextLetterA[DisplayTextRender]) / 2)
  end

  if DisplayTextDirection == "Backward" and DisplayTextColourSpeed == 0 then
    if DisplayTextGlow == "Cycle" then
      DisplayTextColourAnimation = DisplayTextColourAnimation + DisplayTextLength
      if DisplayTextColourAnimation > (DisplayTextTotal * 2) - DisplayTextLength then
        DisplayTextColourAnimation = 0
      end
    end
  elseif DisplayTextDirection == "Forward" and DisplayTextColourSpeed == 0 then
    if DisplayTextGlow == "Cycle" then
      DisplayTextColourAnimation = DisplayTextColourAnimation - DisplayTextLength
      if DisplayTextColourAnimation < 0 then
        DisplayTextColourAnimation = (DisplayTextTotal * 2) - DisplayTextLength
      end
    end
  end

  DisplayTextColourSpeed = DisplayTextColourSpeed + 1
  if DisplayTextColourSpeed >= DisplayTextColourCycleSpeed * dt then
    DisplayTextColourSpeed = 0
  end

  graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0)) -- Default colour back to white
end

return bouncingText

local name, methods = ...
-- Create a list with unit and spells (5)

-- Create Frame
methods.ImmunityClockTargetFrame = CreateFrame("Frame", "ImmunityClockTargetFrame", UIParent)
-- ImmunityClockTargetFrame:SetTopLevel(true)
methods.ImmunityClockTargetFrame:SetFrameStrata("BACKGROUND")
methods.ImmunityClockTargetFrame:SetMovable(true)
methods.ImmunityClockTargetFrame:SetWidth(128)
methods.ImmunityClockTargetFrame:SetHeight(32)
methods.ImmunityClockTargetFrame:SetPoint("BOTTOMLEFT", "TargetFrameHealthBar", "BOTTOMLEFT", -2, -35);
methods.ImmunityClockTargetFrame:EnableMouse(true)
methods.ImmunityClockTargetFrame:RegisterForDrag("LeftButton")

-- Set Background texture
-- local t = ImmunityClockTargetFrame:CreateTexture(nil, "BACKGROUND")
-- t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
-- t:SetAllPoints(ImmunityClockTargetFrame, - 1, - 1)
-- t:SetVertexColor(1, 1, 1, .5)
-- ImmunityClockTargetFrame.texture = t

-- Create a fontframe1 -- Need 3 font strings
methods.ImmunityClockTargetFrame.title1 = ImmunityClockTargetFrame:CreateFontString(nil, "OVERLAY")
methods.ImmunityClockTargetFrame.title1:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
methods.ImmunityClockTargetFrame.title1:SetTextColor(1, 1, 0, .8)
methods.ImmunityClockTargetFrame.title1:SetPoint("TOP", ImmunityClockTargetFrame, "TOP", 0, -35)
methods.ImmunityClockTargetFrame.title1:SetText("Line 1")

methods.ImmunityClockTargetFrame.title2 = ImmunityClockTargetFrame:CreateFontString(nil, "OVERLAY")
methods.ImmunityClockTargetFrame.title2:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
methods.ImmunityClockTargetFrame.title2:SetTextColor(1, 1, 0, .8)
methods.ImmunityClockTargetFrame.title2:SetPoint("TOP", ImmunityClockTargetFrame, "TOP", 0, -49)
methods.ImmunityClockTargetFrame.title2:SetText("Line 2")

methods.ImmunityClockTargetFrame.title3 = ImmunityClockTargetFrame:CreateFontString(nil, "OVERLAY")
methods.ImmunityClockTargetFrame.title3:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
methods.ImmunityClockTargetFrame.title3:SetTextColor(1, 1, 0, .8)
methods.ImmunityClockTargetFrame.title3:SetPoint("TOP", ImmunityClockTargetFrame, "TOP", 0, -63)
methods.ImmunityClockTargetFrame.title3:SetText("Line 3")

-- Scripts
methods.ImmunityClockTargetFrame:SetScript("OnUpdate", function(self)

end)

methods.ImmunityClockTargetFrame:SetScript("OnDragStart", ImmunityClockTargetFrame.StartMoving)
methods.ImmunityClockTargetFrame:SetScript("OnDragStop", ImmunityClockTargetFrame.StopMovingOrSizing)
methods.ImmunityClockTargetFrame:Hide()
--[[


-- Clock frame
ImmunityClockWindowFrame = CreateFrame("Frame", "ImmunityClockWindowFrame", UIParent)
ImmunityClockWindowFrame:SetWidth(250)
ImmunityClockWindowFrame:SetHeight(96)
ImmunityClockWindowFrame:SetFrameStrata("BACKGROUND")
ImmunityClockWindowFrame:EnableMouse(true)
ImmunityClockWindowFrame:SetMovable(true)
ImmunityClockWindowFrame:RegisterForDrag("LeftButton")
ImmunityClockWindowFrame:SetClampedToScreen(true)
ImmunityClockWindowFrame:SetPoint("CENTER", 0, 0);

-- Set Background texture
local t = ImmunityClockWindowFrame:CreateTexture(nil, "BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(ImmunityClockWindowFrame, - 1, - 1)
t:SetVertexColor(1, 1, 1, .5)
ImmunityClockWindowFrame.texture = t

-- The edge graphics
ImmunityClockWindowFrame:SetBackdrop( {
bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
insets = { left = 5, right = 5, top = 5, bottom = 5 }
});

-- Title
local title = ImmunityClockWindowFrame:CreateTexture("FOREGROUND")
title:SetPoint("TOP", ImmunityClockWindowFrame, "TOP", 0, -5)
title:SetHeight(12)
title:SetWidth(250)

title.title = ImmunityClockWindowFrame:CreateFontString(nil, "OVERLAY")
title.title:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
title.title:SetTextColor(1, 1, 0, .8)
title.title:SetPoint("TOP", title, "TOP")
title.title:SetText("Immunity Clock")

-- Line 1
local text1 = ImmunityClockWindowFrame:CreateTexture("ARTWORK")
text1:SetPoint("TOP", title, "TOP", 0, 0)
text1:SetHeight(12)
text1:SetWidth(250)

text1.text1 = ImmunityClockWindowFrame:CreateFontString("ImmunityClockWindowText1")
text1.text1:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
text1.text1:SetPoint("TOPLEFT", text1, "BOTTOMLEFT", 10, 0)
text1.text1:SetText("Line 1")

-- Line 2
local text2 = ImmunityClockWindowFrame:CreateTexture("ARTWORK")
text2:SetPoint("TOP", text1, "TOP", 0, 0)
text2:SetHeight(12)
text2:SetWidth(250)

text2.text2 = ImmunityClockWindowFrame:CreateFontString("ImmunityClockWindowText1")
text2.text2:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
text2.text2:SetPoint("TOPLEFT", text2, "BOTTOMLEFT", 10, -14)
text2.text2:SetText("Line 2")

-- Line 3
local text3 = ImmunityClockWindowFrame:CreateTexture("ARTWORK")
text3:SetPoint("TOP", text2, "TOP", 0, 0)
text3:SetHeight(12)
text3:SetWidth(250)

text3.text3 = ImmunityClockWindowFrame:CreateFontString("ImmunityClockWindowText1")
text3.text3:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
text3.text3:SetPoint("TOPLEFT", text2, "BOTTOMLEFT", 10, -28)
text3.text3:SetText("Line 3")

-- Line 4
local text4 = ImmunityClockWindowFrame:CreateTexture("ARTWORK")
text4:SetPoint("TOP", text3, "TOP", 0, 0)
text4:SetHeight(12)
text4:SetWidth(250)

text4.text4 = ImmunityClockWindowFrame:CreateFontString("ImmunityClockWindowText1")
text4.text4:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
text4.text4:SetPoint("TOPLEFT", text4, "BOTTOMLEFT", 10, -42)
text4.text4:SetText("Line 4")

-- Line 5
local text5 = ImmunityClockWindowFrame:CreateTexture("ARTWORK")
text5:SetPoint("TOP", text4, "TOP", 0, 0)
text5:SetHeight(12)
text5:SetWidth(250)

text5.text5 = ImmunityClockWindowFrame:CreateFontString("ImmunityClockWindowText1")
text5.text5:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
text5.text5:SetPoint("TOPLEFT", text5, "BOTTOMLEFT", 10, -56)
text5.text5:SetText("Line 5")

-- Close button
local button = CreateFrame("Button", "ImmunityClockWindowFrame")
button:SetWidth(24)
button:SetHeight(24)
button:SetPoint("TOPRIGHT", "ImmunityClockWindowFrame", 2, -2)
button:SetNormalTexture("Interface/Buttons/UI-Panel-MinimizeButton-Up")
button:SetPushedTexture("Interface/Buttons/UI-Panel-MinimizeButton-Down")
button:SetHighlightTexture("Interface/Buttons/UI-Panel-MinimizeButton-Highlight")

button:SetScript("OnClick", function()
print("click")
end)

ImmunityClockWindowFrame.button = button

ImmunityClockWindowFrame:SetScript("OnLoad", function()

end)

ImmunityClockWindowFrame:SetScript("OnDragStart", ImmunityClockWindowFrame.StartMoving)
ImmunityClockWindowFrame:SetScript("OnDragStop", ImmunityClockWindowFrame.StopMovingOrSizing)

ImmunityClockWindowFrame:Show()
--]]

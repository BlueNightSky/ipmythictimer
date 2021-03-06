local AddonName, Addon = ...

local affixSize = {
    width  = 20,
    height = 20,
}
Addon.defaultSize = {
    [0] = 170,
    [1] = 80,
}

-- Main Frame
Addon.fMain = CreateFrame("Frame", "IPMTMain", UIParent)
Addon.fMain:SetFrameStrata("MEDIUM")
Addon.fMain:SetSize(Addon.defaultSize[0], Addon.defaultSize[1])
Addon.fMain:SetPoint("CENTER", UIParent)
Addon.fMain:SetBackdrop(Addon.backdrop)
Addon.fMain:SetBackdropColor(0,0,0, 1)
Addon.fMain:EnableMouse(false)
Addon.fMain:SetMovable(false)
Addon.fMain:SetResizable(false)
Addon.fMain:RegisterForDrag("LeftButton", "RightButton")
Addon.fMain:SetScript("OnDragStart", function(self, button)
    if button == "RightButton" and Addon.fOptions.customize:GetChecked() then
        self:StartSizing()
    end
    Addon:StartDragging(self, button)
end)
Addon.fMain:SetScript("OnDragStop", function(self, button)
    Addon:StopDragging(self, button)
    local point, _, _, x, y = self:GetPoint()
    IPMTOptions.position.main = {
        point = point,
        x     = math.floor(x),
        y     = math.floor(y),
    }
    IPMTOptions.size = {
        [0] = Addon.fMain:GetWidth(),
        [1] = Addon.fMain:GetHeight(),
    }
end)
Addon.fMain:SetScript("OnUpdate",  function(self, elapsed)
    Addon:OnUpdate(elapsed)
end)
Addon.fMain:SetScript("OnEvent", function(self, event, ...)
    Addon:OnEvent(self, event, ...)
end)
Addon.fMain:SetScript("OnShow", function() 
    Addon:OnShow()
end)
Addon.fMain:Hide()


Addon.fMain.cCaption = Addon.fMain:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
Addon.fMain.cCaption:ClearAllPoints()
Addon.fMain.cCaption:SetPoint('TOPLEFT', 0, 32)
Addon.fMain.cCaption:SetJustifyH('LEFT')
Addon.fMain.cCaption:SetFont(Addon.FONT_ROBOTO, 12)
Addon.fMain.cCaption:SetTextColor(1, 1, 1)
Addon.fMain.cCaption:SetText(Addon.localization.CCAPTION)
Addon.fMain.cCaption:Hide()

Addon.frameInfo = {
    level = {
        size = {
            [0] = 20,
            [1] = 20,
        },
        position = {
            x = 6,
            y = -16,
        },
        text = {
            fontSize = 20,
            content  = "24",
        },
    },
    plusLevel = {
        size = {
            [0] = 20,
            [1] = 20,
        },
        position = {
            x = 29,
            y = -16,
        },
        text = {
            fontSize = 13,
            content  = "+3",
            color    = {
                [0] = 0.8,
                [1] = 0.8,
                [2] = 0.8,
            },
        },
    },
    timer = {
        size = {
            [0] = 50,
            [1] = 18,
        },
        position = {
            x = 6,
            y = -40,
        },
        text = {
            fontSize = 12,
            content  = "27:32",
            color    = {
                [0] = 0,
                [1] = 1,
                [2] = 0,
            },
        },
    },
    plusTimer = {
        size = {
            [0] = 50,
            [1] = 18,
        },
        position = {
            x = 50,
            y = -40,
        },
        text = {
            fontSize = 12,
            content  = "04:19",
            color    = {
                [0] = 0.8,
                [1] = 0.8,
                [2] = 0.8,
            },
        },
    },
    deathTimer = {
        size = {
            [0] = 60,
            [1] = 18,
        },
        position = {
            x = -4,
            y = -40,
            point = 'RIGHT',
            rPoint = 'TOPRIGHT',
        },
        text = {
            fontSize = 12,
            content  = "-00:15 [3]",
            justify = 'RIGHT',
            color    = {
                [0] = 0.6,
                [1] = 0.2,
                [2] = 0.2,
            },
        },
    },
    progress = {
        size = {
            [0] = 90,
            [1] = 30,
        },
        position = {
            x = 6,
            y = 14,
            point = 'LEFT',
            rPoint = 'BOTTOMLEFT',
        },
        text = {
            fontSize = 22,
            content  = "57.32%",
            color    = {
                [0] = 1,
                [1] = 1,
                [2] = 0,
            },
        },
    },
    prognosis = {
        size = {
            [0] = 60,
            [1] = 20,
        },
        position = {
            x = 80,
            y = 14,
            point = 'LEFT',
            rPoint = 'BOTTOMLEFT',
        },
        text = {
            fontSize = 15,
            content  = "63.46%",
            color    = {
                [0] = 1,
                [1] = 0,
                [2] = 0,
            },
        },
    },
    bosses = {
        size = {
            [0] = 50,
            [1] = 30,
        },
        position = {
            x = -4,
            y = 14,
            point = 'RIGHT',
            rPoint = 'BOTTOMRIGHT',
        },
        text = {
            fontSize = 22,
            content  = "3/5",
            justify = 'RIGHT',
            color    = {
                [0] = 0.8,
                [1] = 0.8,
                [2] = 0.8,
            },
        },
    },
    affixes = {
        size = {
            [0] = 90,
            [1] = 30,
        },
        position = {
            x = 0,
            y = -15,
            point = 'RIGHT',
            rPoint = 'TOPRIGHT',
        },
    },
}

for frame, info in pairs(Addon.frameInfo) do
    local point = info.position.point
    if (point == nil) then
        point = 'LEFT'
    end
    local rPoint = info.position.rPoint
    if (rPoint == nil) then
        rPoint = 'TOPLEFT'
    end

    Addon.fMain[frame] = CreateFrame("Frame", nil, Addon.fMain)
    Addon.fMain[frame]:SetSize(info.size[0], info.size[1])
    Addon.fMain[frame]:SetPoint(point, Addon.fMain, rPoint, info.position.x, info.position.y)
    Addon.fMain[frame]:SetBackdrop(Addon.backdrop)
    Addon.fMain[frame]:SetBackdropColor(1,1,1, 0)
    if (info.text ~= nil) then
        local justify = info.text.justify
        if (justify == nil) then
            justify = 'LEFT'
        end
        local color = info.text.color
        if (color == nil) then
            color = {
                [0] = 1,
                [1] = 1,
                [2] = 1,
            }
        end
        Addon.fMain[frame].text = Addon.fMain[frame]:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
        Addon.fMain[frame].text:ClearAllPoints()
        Addon.fMain[frame].text:SetPoint(justify, 0, 0)
        Addon.fMain[frame].text:SetJustifyH(justify)
        Addon.fMain[frame].text:SetFont(Addon.FONT_ROBOTO, info.text.fontSize)
        Addon.fMain[frame].text:SetTextColor(color[0], color[1], color[2])
        Addon.fMain[frame].text:SetText(info.text.content)
    end

    Addon.fMain[frame]:EnableMouse(false)
    Addon.fMain[frame]:SetMovable(false)
    Addon.fMain[frame]:RegisterForDrag("LeftButton")
    Addon.fMain[frame]:SetScript("OnDragStart", function(self, button)
        Addon:StartDragging(self, button)
    end)
    Addon.fMain[frame]:SetScript("OnDragStop", function(self, button)
        Addon:StopDragging(self, button)
        Addon:MoveElement(self, frame)
    end)
    Addon.fMain[frame]:SetScript("OnMouseUp", function (self, button)
        if button == 'RightButton' then 
            Addon:StartFontSize(frame)
        end
    end)
    if (frame == 'deathTimer') then
        Addon.fMain[frame].button = CreateFrame("Button", nil, Addon.fMain[frame])
        Addon.fMain[frame].button:SetAllPoints(Addon.fMain[frame])
        Addon.fMain[frame].button:SetBackdrop(Addon.backdrop)
        Addon.fMain[frame].button:SetBackdropColor(0,0,0, 0)
        Addon.fMain[frame].button:SetScript("OnClick", function(self)
            Addon:ToggleDeaths()
        end)
        Addon.fMain[frame].button:SetScript("OnEnter", function(self, event, ...)
            Addon:OnDeathTimerEnter(self)
        end)
        Addon.fMain[frame].button:SetScript("OnLeave", function(self, event, ...)
            GameTooltip:Hide()
        end)
    end
end

Addon.fMain.affix = {}
for f = 1,4 do
    local right = (-1) * (affixSize.width + 1) * (f-1)
    Addon.fMain.affix[f] = CreateFrame("Frame", nil, Addon.fMain.affixes, "ScenarioChallengeModeAffixTemplate")
    Addon.fMain.affix[f]:SetSize(affixSize.width, affixSize.height)
    Addon.fMain.affix[f].Portrait:SetSize(affixSize.width - 2, affixSize.height - 2)
    Addon.fMain.affix[f]:SetPoint("RIGHT", Addon.fMain.affixes, "TOPRIGHT", right - 4, -16)
    Addon.fMain.affix[f]:SetScript("OnEnter", function(self, event, ...)
        Addon:OnAffixEnter(self, f)
    end)
    Addon.fMain.affix[f]:SetScript("OnLeave", function(self, event, ...)
        GameTooltip:Hide()
    end)
end
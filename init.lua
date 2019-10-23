local name, methods = ...


-- Global Title and version from toc file
methods.title = "qiClock: "
methods.eventFrame = CreateFrame("Frame", "eventFrame")
methods.eventFrame:RegisterEvent("ADDON_LOADED")
methods.eventFrame:RegisterEvent("PLAYER_LOGIN")
methods.eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
--methods.eventFrame:RegisterEvent("UNIT_AURA")

methods.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- Call right event
methods.eventFrame:SetScript("OnEvent",
    function(self, event, ...)
        if (type(methods[event]) == 'function') then
            methods[event](self, event, ...);
        end
    end
)


if not qvars then qvars = {} end

function methods:init_vars()
    methods.units = {}

    methods.ICAuras = {
        {id = 8177, cooldown = 0.05, duration = 45, type = "grnd totem"},
        {id = 8143, cooldown = 0.05, duration = 120, type = "trem totem"},
        {id = 7744, cooldown = 115, duration = 5, type = "WOTF"},
        {id = 45438, cooldown = 290, duration = 10, type = "Ice Block"},
        {id = 27148, cooldown = 0.05, duration = 30, type = "Void sacrifice"},
        {id = 25771, cooldown = 120, duration = 0.01, type = "Pally Bubbles"},
        {id = 498, cooldown = 180, duration = 12, type = "Div Prot"},
        {id = 642, cooldown = 300, duration = 12, type = "Divine Shield"},
        {id = 18499, cooldown = 30, duration = 10, type = "Bers Rage"},
        {id = 34471, cooldown = 120, duration = 18, type = "Beast Within"},
        {id = 31224, cooldown = 60, duration = 5, type = "Cloak of Shad"},
        {id = 6346, cooldown = 180, duration = 180, type = "Fear Ward"},
        {id = 59752, cooldown = 120, duration = 0.01, type = "Every Man"},
        {id = 23920, cooldown = 10, duration = 5, type = "Spell Reflection"}
    };

    methods.ICFears = {
        id = 5782, --Fear
        id = 6213,
        id = 6215,
        id = 5484, -- Howl of Terror
        id = 17928,
        id = 6358, -- Seduction
        id = 8122, -- Psychic Scream
        id = 8124,
        id = 10888,
        id = 10890,
        id = 5246, -- Intimidating Shout
        id = 16377, -- transform (caused by polymorph / hex)
        id = 16372,
        id = 32570,
        id = 16371,
        id = 32789,
        id = 2914,
        id = 32822,
        id = 13321
    }
end

methods:init_vars()

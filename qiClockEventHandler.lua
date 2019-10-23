-- Use wow own table, add line belove in all files to make them 'localy global'
local name, methods = ...

-- check for 'fear' debuff
-- check for 'fear' antidote
-- start timer on antidotes/ fear
-- Show icon with counter or something like it

-- Tru to brake this down into smaller functions
-- make use of lua classes
-- test libAurora

-- Event methods, events are registred in init
function methods:ADDON_LOADED(self, event)
  if event == "qiClock" then
    print("qiClock loaded");
  end
end

function methods:PLAYER_LOGIN(self, event)

end

function methods:PLAYER_TARGET_CHANGED(self, arg1)


  if _G["TargetFrameHealthBar"]:IsVisible() then
    methods.ImmunityClockTargetFrame:Show()
  else
    methods.ImmunityClockTargetFrame:Hide()
  end

  local uGuid, uName = UnitGUID("target"), UnitName("target")

  -- This only works for enemy if, detect magic is used
  -- if combat log haven't record this yet, we get an error
  -- methods:checkTimeOut(uGuid)
  methods:AddSpellsToTable(spellName, playerName, uName, uGuid)
  gotBuffs, buffs = methods:checkBuff("target")

  if methods.units[uGuid] then
    methods:guidHasBuffs(uGuid, uName)
  end
end

function methods:COMBAT_LOG_EVENT_UNFILTERED(self, event)
  -- if event == nil then return end
  local playerGuid = UnitGUID("player")
  local playerName = UnitName("player")
  -- Just remove the uGuid that this fire
  local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()
  local spellId, spellName, spellSchool = select(12, CombatLogGetCurrentEventInfo())
  local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(15, CombatLogGetCurrentEventInfo())

  -- We can't get spellID from combat log or UNIT_AURA
  -- only spellNames. If someone uses Detect magic we can read more on target.

  -- sourceName is always the caster (for all)
  -- destName is always the reciever (for all)

  if subevent == "SPELL_CAST_START" and playerGuid == sourceGUID then
    --  print(playerName .. " start casting " .. spellName)
  end

  if subevent == "SPELL_CAST_SUCCESS" and playerGuid == sourceGUID then
    --print(playerName .. " casts " .. spellName)
  end

  if subevent == "SPELL_CAST_FAILED" and playerGuid == sourceGUID then
    --print(playerName .. " failed casting " .. spellName)
  end

  if subevent == "SPELL_AURA_APPLIED" then
    --methods:checkTimeOut(sourceGUID)
    methods:AddSpellsToTable(spellName, sourceName, sourceGUID)
  end

  if subevent == "SPELL_AURA_REMOVED" then
    if not sourceName then return end

    --  if HostilePlayer(sourceFlags) then
    if methods.units[sourceGUID] then

      if methods.units[sourceGUID][spellName]['spellStartTime'] then
        local start = methods.units[sourceGUID][spellName]['spellStartTime']
        local duration = GetServerTime() - start

        if methods.units[sourceGUID][spellName]['duration'] and
        methods.units[sourceGUID][spellName]['duration'] < duration then
          methods.units[sourceGUID][spellName]['duration'] = duration
        end
      end

      methods.units[sourceGUID][spellName]['spellActive'] = false
      methods.units[sourceGUID][spellName]['spellStartTime'] = nil
      methods.units[sourceGUID][spellName]['cooldown'] = nil

      print(sourceName .. " removed '" .. spellName .. "'")
      --  end
    end
  end
end

function HostilePlayer(sourceFlags)
  if bit.band(sourceFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then -- check if player controlled
    --  bit.band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then
    return true
  end

  return false
end


function methods:UNIT_AURA(self, arg1)
  -- Works primaly with unit like player, target, raid1-40 party 1-5
  local uGuid, uName = UnitGUID(arg1), UnitName(arg1)

  if uGuid then
    -- local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", uGuid);
    methods:checkBuff(arg1)
  end
end

function methods:checkBuff(arg1)
  local sourceGUID = UnitGUID(arg1)
  local sourceName = UnitName(arg1)

  -- We can't get buffs from enemy player, without detecting magic.
  for index = 1, 40 do
    local spellName, icon, _, _, duration, expirationTime, source, _, _, spellId = UnitBuff(arg1, index)
    if not spellName then return end

  --  methods:checkTimeOut(sourceGUID)
    methods:AddSpellsToTable(spellName, sourceName, sourceGUID, spellId, duration)
  end
end

function methods:has_value(tab, val)
  for index, value in ipairs(tab) do
    if value['id'] == val then
      return true
    end
  end

  return false
end


function methods:guidHasBuffs(uGuid, uName)
  -- Prints known buffs for unit.
  -- Add some sort of time out for spells
  -- View how long it been running.
  -- lot of false positive based on:
  -- combat log spamming same spell
  -- you can only track spelles you havr rekorded
  -- language based since we are forced to use spellName and not spellId
  -- spamming can accure then player moving in and out of range.

  if not methods.units[uGuid] then return end
  print()
  print(uName .. " BUFFS")

  for spellName, table in pairs(methods.units[uGuid]) do
    local active = methods.units[uGuid][spellName]['spellActive']
    local hardLimitTime = methods.units[uGuid][spellName]['hardLimitTime']
    local name = tostring(methods.units[uGuid][spellName]['playerName'])
    local spellId = methods.units[uGuid][spellName]['spellId']

    if not spellId then
      if active then
        print("    |cFF00FF00" .. spellName .. " " .. hardLimitTime .. "|r")
      else
        print("    |cFFFF0000" .. spellName .. " " .. hardLimitTime .. "|r")
      end
    elseif spellId then
      -- Party members, pet and yourself.
      local spell = GetSpellInfo(spellId)
      local rank = GetSpellSubtext(spellId) or ""

      if not rank then
        rank = ""
      end
      if active then
        print("    |cFF00FF00" .. spell .. " " .. rank .. "|r ")
      else
        print("    |cFFFF0000" .. spell .. " " .. rank .. "|r ")
      end
    end
  end
end

function methods:splitGuid(uGuid)
  -- local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", uGuid);

  return strsplit("-", uGuid)
end

function methods:checkTimeOut(uGuid)
  if not methods.units[uGuid] then return end
  if not type(methods.units[uGuid]) == "table" then return end
  -- if not table.getn(methods.units[uGuid]) > 0 then return end

  for spellName, table in pairs(methods.units[uGuid]) do
    local start = methods.units[uGuid][spellName]['spellStartTime']
    local duration = methods.units[uGuid][spellName]['spellStartTime']
    local stop = start + duration
    local stopAll = start + methods.units[sourceGUID][spellName]['hardLimitTime']

    if getTime() > stop or getTime() > stopAll then
      methods.units[uGuid][spellName][spellActive] = false
      methods.units[uGuid][spellName]['spellStartTime'] = nil
    end
  end
end

function methods:AddSpellsToTable(spellName, sourceName, sourceGUID, spellId, duration)
  if not sourceName then return end
  -- if not HostilePlayer(sourceFlags) then return end

  if not methods.units[sourceGUID] then
    methods.units[sourceGUID] = {}
  end

  if not methods.units[sourceGUID][spellName] then
    methods.units[sourceGUID][spellName] = {}
  end

  if spellId then
    methods.units[sourceGUID][spellName]['spellId'] = spellId
  end

  if duration then
    methods.units[sourceGUID][spellName]['duration'] = duration
  end

  methods.units[sourceGUID][spellName]['spellStartTime'] = GetTime()
  methods.units[sourceGUID][spellName]['spellActive'] = true
  methods.units[sourceGUID][spellName]['playerName'] = sourceName
  methods.units[sourceGUID][spellName]['hardLimitTime'] = 180 -- add this from spelllist
  methods.units[sourceGUID][spellName]['cooldown'] = nil -- add this from spelllist

  print(sourceName .. " applied '" .. spellName .. "'")
end

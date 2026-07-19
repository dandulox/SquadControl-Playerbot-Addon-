-- Minimal ASCII-only loader for WoW 3.3.5a.
UNBOT2 = UNBOT2 or {}
SQUADCONTROL = UNBOT2 -- The server bridge retains the UNBOT2 protocol for compatibility.
UNBOT2_BOOT_OK = true

local function BootstrapMessage()
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ccff[SquadControl]|r Control module active, but the main window did not load.")
    DEFAULT_CHAT_FRAME:AddMessage("|cffff6666[SquadControl]|r Please report the displayed Lua error.")
end

SLASH_UNBOT21 = "/unbot"
SLASH_UNBOT22 = "/ub"
SLASH_UNBOT23 = "/playerbots"
SLASH_UNBOT24 = "/squadcontrol"
SlashCmdList["UNBOT2"] = BootstrapMessage

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function()
    loader.started = GetTime()
end)

loader:SetScript("OnUpdate", function(self)
    if not self.started or self.checked or GetTime() - self.started < 2 then return end
    self.checked = true
    if UNBOT2_MAIN_OK then return end

    local button = CreateFrame("Button", "UnBot2RecoveryMinimapButton", Minimap)
    button:SetWidth(28)
    button:SetHeight(28)
    button:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -8, 8)
    button:SetFrameStrata("HIGH")
    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetTexture("Interface\\Icons\\INV_Misc_Gear_01")
    icon:SetAllPoints(button)
    button:SetScript("OnClick", BootstrapMessage)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("SquadControl diagnostics", 1, 0.82, 0)
        GameTooltip:AddLine("The main window could not be loaded.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    BootstrapMessage()
end)


UNBOT2 = UNBOT2 or {}

UNBOT2.VERSION = "2.0.13"
UNBOT2.ADDON_PREFIX = "UNBOT2"

UNBOT2.CLASS_ORDER = {
    "AUTO", "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST",
    "DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "DRUID",
}

UNBOT2.CLASSES = {
    AUTO = { label = "Automatisch", command = nil, color = "|cffbbbbbb" },
    WARRIOR = { label = "Krieger", command = "warrior", color = "|cffc79c6e" },
    PALADIN = { label = "Paladin", command = "paladin", color = "|cfff58cba" },
    HUNTER = { label = "Jäger", command = "hunter", color = "|cffabd473" },
    ROGUE = { label = "Schurke", command = "rogue", color = "|cfffff569" },
    PRIEST = { label = "Priester", command = "priest", color = "|cffffffff" },
    DEATHKNIGHT = { label = "Todesritter", command = "dk", color = "|cffc41f3b" },
    SHAMAN = { label = "Schamane", command = "shaman", color = "|cff0070de" },
    MAGE = { label = "Magier", command = "mage", color = "|cff69ccf0" },
    WARLOCK = { label = "Hexenmeister", command = "warlock", color = "|cff9482c9" },
    DRUID = { label = "Druide", command = "druid", color = "|cffff7d0a" },
}

UNBOT2.SPECS = {
    AUTO = { { value = "auto", label = "Automatisch", roles = { "AUTO", "TANK", "HEAL", "MELEE", "RANGED" } } },
    WARRIOR = {
        { value = "arms pve", label = "Waffen PvE", roles = { "MELEE" } },
        { value = "fury pve", label = "Furor PvE", roles = { "MELEE" } },
        { value = "prot pve", label = "Schutz PvE", roles = { "TANK" } },
        { value = "arms pvp", label = "Waffen PvP", roles = { "MELEE" } },
        { value = "fury pvp", label = "Furor PvP", roles = { "MELEE" } },
        { value = "prot pvp", label = "Schutz PvP", roles = { "TANK" } },
    },
    PALADIN = {
        { value = "holy pve", label = "Heilig PvE", roles = { "HEAL" } },
        { value = "prot pve", label = "Schutz PvE", roles = { "TANK" } },
        { value = "ret pve", label = "Vergeltung PvE", roles = { "MELEE" } },
        { value = "holy pvp", label = "Heilig PvP", roles = { "HEAL" } },
        { value = "prot pvp", label = "Schutz PvP", roles = { "TANK" } },
        { value = "ret pvp", label = "Vergeltung PvP", roles = { "MELEE" } },
    },
    HUNTER = {
        { value = "bm pve", label = "Tierherrschaft PvE", roles = { "RANGED" } },
        { value = "mm pve", label = "Treffsicherheit PvE", roles = { "RANGED" } },
        { value = "surv pve", label = "Überleben PvE", roles = { "RANGED" } },
        { value = "bm pvp", label = "Tierherrschaft PvP", roles = { "RANGED" } },
        { value = "mm pvp", label = "Treffsicherheit PvP", roles = { "RANGED" } },
        { value = "surv pvp", label = "Überleben PvP", roles = { "RANGED" } },
    },
    ROGUE = {
        { value = "as pve", label = "Meucheln PvE", roles = { "MELEE" } },
        { value = "combat pve", label = "Kampf PvE", roles = { "MELEE" } },
        { value = "subtlety pve", label = "Täuschung PvE", roles = { "MELEE" } },
        { value = "as pvp", label = "Meucheln PvP", roles = { "MELEE" } },
        { value = "combat pvp", label = "Kampf PvP", roles = { "MELEE" } },
        { value = "subtlety pvp", label = "Täuschung PvP", roles = { "MELEE" } },
    },
    PRIEST = {
        { value = "disc pve", label = "Disziplin PvE", roles = { "HEAL" } },
        { value = "holy pve", label = "Heilig PvE", roles = { "HEAL" } },
        { value = "shadow pve", label = "Schatten PvE", roles = { "RANGED" } },
        { value = "disc pvp", label = "Disziplin PvP", roles = { "HEAL" } },
        { value = "holy pvp", label = "Heilig PvP", roles = { "HEAL" } },
        { value = "shadow pvp", label = "Schatten PvP", roles = { "RANGED" } },
    },
    DEATHKNIGHT = {
        { value = "blood pve", label = "Blut PvE", roles = { "TANK", "MELEE" } },
        { value = "frost pve", label = "Frost PvE", roles = { "TANK", "MELEE" } },
        { value = "unholy pve", label = "Unheilig PvE", roles = { "MELEE" } },
        { value = "double aura blood pve", label = "Blut Doppelaura PvE", roles = { "TANK" } },
        { value = "blood pvp", label = "Blut PvP", roles = { "TANK", "MELEE" } },
        { value = "frost pvp", label = "Frost PvP", roles = { "MELEE" } },
        { value = "unholy pvp", label = "Unheilig PvP", roles = { "MELEE" } },
    },
    SHAMAN = {
        { value = "ele pve", label = "Elementar PvE", roles = { "RANGED" } },
        { value = "enh pve", label = "Verstärkung PvE", roles = { "MELEE" } },
        { value = "resto pve", label = "Wiederherstellung PvE", roles = { "HEAL" } },
        { value = "ele pvp", label = "Elementar PvP", roles = { "RANGED" } },
        { value = "enh pvp", label = "Verstärkung PvP", roles = { "MELEE" } },
        { value = "resto pvp", label = "Wiederherstellung PvP", roles = { "HEAL" } },
    },
    MAGE = {
        { value = "arcane pve", label = "Arkan PvE", roles = { "RANGED" } },
        { value = "fire pve", label = "Feuer PvE", roles = { "RANGED" } },
        { value = "frost pve", label = "Frost PvE", roles = { "RANGED" } },
        { value = "frostfire pve", label = "Frostfeuer PvE", roles = { "RANGED" } },
        { value = "arcane pvp", label = "Arkan PvP", roles = { "RANGED" } },
        { value = "fire pvp", label = "Feuer PvP", roles = { "RANGED" } },
        { value = "frost pvp", label = "Frost PvP", roles = { "RANGED" } },
    },
    WARLOCK = {
        { value = "affli pve", label = "Gebrechen PvE", roles = { "RANGED" } },
        { value = "demo pve", label = "Dämonologie PvE", roles = { "RANGED" } },
        { value = "destro pve", label = "Zerstörung PvE", roles = { "RANGED" } },
        { value = "affli pvp", label = "Gebrechen PvP", roles = { "RANGED" } },
        { value = "demo pvp", label = "Dämonologie PvP", roles = { "RANGED" } },
        { value = "destro pvp", label = "Zerstörung PvP", roles = { "RANGED" } },
    },
    DRUID = {
        { value = "balance pve", label = "Gleichgewicht PvE", roles = { "RANGED" } },
        { value = "bear pve", label = "Bär PvE", roles = { "TANK" } },
        { value = "resto pve", label = "Wiederherstellung PvE", roles = { "HEAL" } },
        { value = "cat pve", label = "Katze PvE", roles = { "MELEE" } },
        { value = "balance pvp", label = "Gleichgewicht PvP", roles = { "RANGED" } },
        { value = "resto pvp", label = "Wiederherstellung PvP", roles = { "HEAL" } },
        { value = "cat pvp", label = "Katze PvP", roles = { "MELEE" } },
    },
}

UNBOT2.ROLE_ORDER = { "AUTO", "TANK", "HEAL", "MELEE", "RANGED" }
UNBOT2.ROLES = {
    AUTO = { label = "Automatisch", short = "AUTO", color = "|cffbbbbbb", command = nil },
    TANK = {
        label = "Tank", short = "TANK", color = "|cff4c9cff",
        command = "co +tank,+tank assist,+tank face,+threat,-heal,-dps",
    },
    HEAL = {
        label = "Heiler", short = "HEAL", color = "|cff55dd77",
        command = "co +heal,+save mana,+avoid aoe,-tank,-dps",
    },
    MELEE = {
        label = "Nahkampf-DD", short = "NAH", color = "|cffffaa33",
        command = "co +dps,+behind,+threat,+avoid aoe,-tank,-heal",
    },
    RANGED = {
        label = "Fernkampf-DD", short = "FERN", color = "|cffffcc55",
        command = "co +dps,+threat,+avoid aoe,-tank,-heal",
    },
}

UNBOT2.DEFAULT_PRESETS = {
    dungeon = {
        name = "5er Dungeon",
        size = 5,
        composition = { "TANK", "HEAL", "MELEE", "RANGED", "RANGED" },
    },
    quest = {
        name = "Questgruppe",
        size = 5,
        composition = { "TANK", "HEAL", "MELEE", "RANGED", "RANGED" },
    },
    raid10 = { name = "10er Schlachtzug", size = 10, composition = { "TANK", "TANK", "HEAL", "HEAL", "RANGED", "RANGED", "RANGED", "MELEE", "MELEE", "RANGED" } },
    raid25 = {
        name = "25er Schlachtzug", size = 25,
        composition = {
            "TANK", "TANK", "TANK", "HEAL", "HEAL", "HEAL", "HEAL", "HEAL",
            "MELEE", "MELEE", "MELEE", "MELEE", "MELEE", "MELEE", "MELEE", "MELEE",
            "RANGED", "RANGED", "RANGED", "RANGED", "RANGED", "RANGED", "RANGED", "RANGED", "RANGED",
        },
    },
}

UNBOT2.ROLE_DEFAULTS = {
    TANK = {
        { class = "PALADIN", spec = "prot pve" }, { class = "WARRIOR", spec = "prot pve" },
        { class = "DRUID", spec = "bear pve" }, { class = "DEATHKNIGHT", spec = "blood pve" },
    },
    HEAL = {
        { class = "PRIEST", spec = "holy pve" }, { class = "PALADIN", spec = "holy pve" },
        { class = "SHAMAN", spec = "resto pve" }, { class = "DRUID", spec = "resto pve" },
    },
    MELEE = {
        { class = "ROGUE", spec = "combat pve" }, { class = "WARRIOR", spec = "fury pve" },
        { class = "PALADIN", spec = "ret pve" }, { class = "DEATHKNIGHT", spec = "unholy pve" },
        { class = "SHAMAN", spec = "enh pve" }, { class = "DRUID", spec = "cat pve" },
    },
    RANGED = {
        { class = "MAGE", spec = "frost pve" }, { class = "HUNTER", spec = "mm pve" },
        { class = "WARLOCK", spec = "affli pve" }, { class = "PRIEST", spec = "shadow pve" },
        { class = "SHAMAN", spec = "ele pve" }, { class = "DRUID", spec = "balance pve" },
    },
}

UNBOT2.COMBAT_TOGGLES = {
    { id = "aoe", label = "Flächenschaden", on = "co +aoe", off = "co -aoe" },
    { id = "boost", label = "Cooldowns / Burst", on = "co +boost", off = "co -boost" },
    { id = "cc", label = "Kontrolle (CC)", on = "co +cc", off = "co -cc" },
    { id = "focus", label = "Einzelziel-Fokus", on = "co +focus", off = "co -focus" },
    { id = "avoid", label = "Schadensflächen meiden", on = "co +avoid aoe", off = "co -avoid aoe" },
    { id = "mana", label = "Heiler: Mana sparen", on = "co +save mana", off = "co -save mana" },
    { id = "healerdps", label = "Heiler dürfen angreifen", on = "co +healer dps", off = "co -healer dps" },
    { id = "threat", label = "Bedrohung vermeiden", on = "co +threat", off = "co -threat" },
}

function UNBOT2.CopyTable(source)
    local target = {}
    for key, value in pairs(source or {}) do
        if type(value) == "table" then
            target[key] = UNBOT2.CopyTable(value)
        else
            target[key] = value
        end
    end
    return target
end

function UNBOT2.GetSpec(classKey, value)
    for _, spec in ipairs(UNBOT2.SPECS[classKey] or {}) do
        if spec.value == value then
            return spec
        end
    end
    return nil
end

function UNBOT2.IsRoleCompatible(classKey, specValue, roleKey)
    if classKey == "AUTO" or roleKey == "AUTO" or specValue == "auto" then
        return true
    end
    local spec = UNBOT2.GetSpec(classKey, specValue)
    if not spec then return false end
    for _, allowedRole in ipairs(spec.roles or {}) do
        if allowedRole == roleKey then return true end
    end
    return false
end


local U = UNBOT2

-- German remains available for German clients. Every other WoW locale (for
-- example enUS, enGB, frFR and esES) deliberately uses the English fallback.
local english = {
    ["Einstellungen"] = "Settings", ["Einstellungen und Diagnose"] = "Settings & Diagnostics",
    ["Bedienung"] = "Controls", ["Systemstatus"] = "System status", ["Letzte Aktionen"] = "Recent activity",
    ["Befehle im Chat bestätigen"] = "Show commands in chat",
    ["Zerstören immer bestätigen"] = "Always confirm destruction",
    ["Server-Brücke verwenden"] = "Use server bridge",
    ["Minimap-Symbol ausblenden"] = "Hide minimap button",
    ["Fenster zentrieren"] = "Center window", ["Brücke prüfen"] = "Check bridge",
    ["Addon-Version"] = "Addon version", ["Betriebsart"] = "Mode", ["Chatmodus"] = "Chat mode",
    ["Gruppenmitglieder"] = "Group members", ["Aktiver Zielbot"] = "Selected bot",
    ["Slash-Befehle"] = "Slash commands", ["Protokoll leeren"] = "Clear log",
    ["Übersicht"] = "Overview", ["Gruppe"] = "Squad", ["Kampf"] = "Combat",
    ["Taktik"] = "Tactics", ["Abenteuer"] = "Adventure", ["Ausrüstung"] = "Gear",
    ["Automatisch"] = "Automatic", ["Krieger"] = "Warrior", ["Jäger"] = "Hunter",
    ["Schurke"] = "Rogue", ["Priester"] = "Priest", ["Todesritter"] = "Death Knight",
    ["Schamane"] = "Shaman", ["Magier"] = "Mage", ["Hexenmeister"] = "Warlock",
    ["Druide"] = "Druid", ["Nahkampf"] = "Melee", ["Fernkampf"] = "Ranged",
    ["Heiler"] = "Healer", ["Offen"] = "Open", ["Bereit"] = "Ready",
    ["Ungültig"] = "Invalid", ["Neue Gruppe"] = "New Squad",
    ["Einstellungen und Diagnose"] = "Settings & Diagnostics",
    ["Bedienung"] = "Controls",
    ["Befehle im Chat bestÃ¤tigen"] = "Show commands in chat",
    ["ZerstÃ¶ren immer bestÃ¤tigen"] = "Always confirm destruction",
    ["Server-BrÃ¼cke verwenden"] = "Use server bridge",
    ["Minimap-Symbol ausblenden"] = "Hide minimap button",
    ["Fenster zentrieren"] = "Center window",
    ["BrÃ¼cke prÃ¼fen"] = "Check bridge",
    ["Systemstatus"] = "System status",
    ["Addon-Version"] = "Addon version",
    ["Betriebsart"] = "Mode",
    ["Chatmodus"] = "Chat mode",
    ["Gruppenmitglieder"] = "Group members",
    ["Aktiver Zielbot"] = "Selected bot",
    ["Keiner"] = "None",
    ["Slash-Befehle"] = "Slash commands",
    ["Letzte Aktionen"] = "Recent activity",
    ["Protokoll leeren"] = "Clear log",
    ["Ãœbersicht"] = "Overview",
    ["Gruppe"] = "Squad",
    ["Kampf"] = "Combat",
    ["Taktik"] = "Tactics",
    ["Abenteuer"] = "Adventure",
    ["AusrÃ¼stung"] = "Gear",
    ["Einstellungen"] = "Settings",
    ["Automatisch"] = "Automatic",
    ["Krieger"] = "Warrior", ["JÃ¤ger"] = "Hunter", ["Schurke"] = "Rogue",
    ["Priester"] = "Priest", ["Todesritter"] = "Death Knight", ["Schamane"] = "Shaman",
    ["Magier"] = "Mage", ["Hexenmeister"] = "Warlock", ["Druide"] = "Druid",
    ["Nahkampf"] = "Melee", ["Fernkampf"] = "Ranged", ["Heiler"] = "Healer",
    ["Offen"] = "Open", ["Bereit"] = "Ready", ["UngÃ¼ltig"] = "Invalid",
    ["Neue Gruppe"] = "New Squad", ["Seite "] = "Page ",
}

function U.L(text)
    if GetLocale and GetLocale() == "deDE" then return text end
    return english[text] or text
end

U.runtime = {
    bridge = false,
    bridgeVersion = nil,
    scope = "ALL",
    selectedBot = nil,
    log = {},
    pendingBuild = nil,
    pendingRequests = {},
    nextRequest = 1,
    lastRoster = {},
}

local function Now()
    return date and date("%H:%M:%S") or "--:--:--"
end

function U.Print(message, errorMessage)
    local color = errorMessage and "|cffff6666" or "|cff33ccff"
    DEFAULT_CHAT_FRAME:AddMessage(color .. "[SquadControl]|r " .. tostring(message))
    table.insert(U.runtime.log, 1, { time = Now(), text = tostring(message), error = errorMessage and true or false })
    while #U.runtime.log > 30 do table.remove(U.runtime.log) end
    if U.RefreshDiagnostics then U.RefreshDiagnostics() end
end

local function NewSlot(index)
    return { index = index, name = nil, class = "AUTO", spec = "auto", role = "AUTO", status = "Offen" }
end

function U.InitializeDB()
    -- Preserve existing UnBot 2 settings once, then store all future settings
    -- under the SquadControl name.
    UnBot2DB = SquadControlDB or UnBot2DB or {}
    SquadControlDB = UnBot2DB
    UnBot2DB.version = U.VERSION
    UnBot2DB.window = UnBot2DB.window or { point = "CENTER", relativePoint = "CENTER", x = 0, y = 0 }
    UnBot2DB.minimap = UnBot2DB.minimap or { angle = 135, hidden = false }
    UnBot2DB.builder = UnBot2DB.builder or { name = "Neue Gruppe", size = 4, groupSize = 5, playerRole = "RANGED", slots = {} }
    UnBot2DB.builder.name = UnBot2DB.builder.name or "Neue Gruppe"
    UnBot2DB.builder.size = tonumber(UnBot2DB.builder.size) or 4
    UnBot2DB.builder.size = math.max(1, math.min(24, UnBot2DB.builder.size))
    UnBot2DB.builder.playerRole = U.ROLES[UnBot2DB.builder.playerRole] and UnBot2DB.builder.playerRole or "RANGED"
    UnBot2DB.builder.groupSize = tonumber(UnBot2DB.builder.groupSize) or (UnBot2DB.builder.size + 1)
    UnBot2DB.builder.slots = type(UnBot2DB.builder.slots) == "table" and UnBot2DB.builder.slots or {}
    UnBot2DB.profiles = UnBot2DB.profiles or {}
    UnBot2DB.combat = UnBot2DB.combat or { toggles = {}, compact = false }
    UnBot2DB.combat.toggles = type(UnBot2DB.combat.toggles) == "table" and UnBot2DB.combat.toggles or {}
    if UnBot2DB.combat.compact == nil then UnBot2DB.combat.compact = false end
    UnBot2DB.settings = UnBot2DB.settings or { confirmations = true, chatFeedback = true, bridge = true }
    if UnBot2DB.settings.confirmations == nil then UnBot2DB.settings.confirmations = true end
    if UnBot2DB.settings.chatFeedback == nil then UnBot2DB.settings.chatFeedback = true end
    if UnBot2DB.settings.bridge == nil then UnBot2DB.settings.bridge = true end

    for index = 1, 25 do
        local slot = type(UnBot2DB.builder.slots[index]) == "table" and UnBot2DB.builder.slots[index] or NewSlot(index)
        slot.index = index
        slot.class = U.CLASSES[slot.class] and slot.class or "AUTO"
        slot.spec = slot.spec or "auto"
        slot.role = U.ROLES[slot.role] and slot.role or "AUTO"
        slot.status = slot.status or "Offen"
        UnBot2DB.builder.slots[index] = slot
    end

    if PlayerbotControlDEDB and PlayerbotControlDEDB.minimapAngle and not UnBot2DB.migratedLegacy then
        UnBot2DB.minimap.angle = PlayerbotControlDEDB.minimapAngle
        UnBot2DB.migratedLegacy = true
    end
end

function U.GetGroupChannel()
    if GetNumRaidMembers and GetNumRaidMembers() > 0 then return "RAID" end
    return "PARTY"
end

function U.GetRoster()
    local roster = {}
    local raidCount = GetNumRaidMembers and GetNumRaidMembers() or 0
    local partyCount = GetNumPartyMembers and GetNumPartyMembers() or 0
    local prefix, count
    if raidCount > 0 then prefix, count = "raid", raidCount else prefix, count = "party", partyCount end

    for index = 1, count do
        local unit = prefix .. index
        local name = UnitName(unit)
        if name and name ~= UnitName("player") then
            local _, classKey = UnitClass(unit)
            table.insert(roster, {
                unit = unit,
                name = name,
                class = classKey or "AUTO",
                health = UnitHealth(unit) or 0,
                healthMax = UnitHealthMax(unit) or 1,
                power = UnitMana(unit) or 0,
                powerMax = UnitManaMax(unit) or 1,
                dead = UnitIsDeadOrGhost(unit) and true or false,
                online = UnitIsConnected(unit) and true or false,
                subgroup = raidCount > 0 and select(3, GetRaidRosterInfo(index)) or 1,
            })
        end
    end
    return roster
end

function U.FindRosterMember(name)
    if not name then return nil end
    for _, member in ipairs(U.GetRoster()) do
        if member.name == name then return member end
    end
    return nil
end

function U.GetScopePrefix(scope)
    scope = scope or U.runtime.scope or "ALL"
    if scope == "TANK" then return "@tank " end
    if scope == "HEAL" then return "@heal " end
    if scope == "DPS" then return "@dps " end
    if scope == "MELEE" then return "@meleedps " end
    if scope == "RANGED" then return "@rangeddps " end
    local groupNumber = string.match(scope, "^GROUP(%d+)$")
    if groupNumber then return "@group" .. groupNumber .. " " end
    return ""
end

function U.SendGroup(command, scope)
    if not command or command == "" then return false end
    local payload = U.GetScopePrefix(scope) .. command
    SendChatMessage(payload, U.GetGroupChannel())
    if UnBot2DB.settings.chatFeedback then U.Print("Gruppe: " .. payload) end
    return true
end

function U.SendBot(name, command)
    if not name or name == "" then
        U.Print("Bitte zuerst einen Bot auswählen.", true)
        return false
    end
    if not command or command == "" then return false end
    if U.runtime.bridge and SendAddonMessage and not string.find(command, "|", 1, true) then
        local requestId = tostring(U.runtime.nextRequest)
        U.runtime.nextRequest = U.runtime.nextRequest + 1
        U.runtime.pendingRequests[requestId] = { bot = name, command = command, started = GetTime() }
        SendAddonMessage(U.ADDON_PREFIX, "EXEC|" .. requestId .. "|" .. name .. "|" .. command,
            "WHISPER", UnitName("player"))
        if UnBot2DB.settings.chatFeedback then U.Print(name .. ": " .. command .. " |cff55dd77[Brücke]|r") end
    else
        SendChatMessage(command, "WHISPER", nil, name)
        if UnBot2DB.settings.chatFeedback then U.Print(name .. ": " .. command) end
    end
    return true
end

function U.SendConsole(command)
    if not command or command == "" then return false end
    SendChatMessage(command, "SAY")
    if UnBot2DB.settings.chatFeedback then U.Print(command) end
    return true
end

function U.SendCommand(command, targetMode)
    local mode = targetMode or U.runtime.scope
    if mode == "BOT" then
        return U.SendBot(U.runtime.selectedBot, command)
    end
    return U.SendGroup(command, mode)
end

function U.SetSelectedBot(name)
    U.runtime.selectedBot = name
    if U.RefreshHeader then U.RefreshHeader() end
end

function U.SetScope(scope)
    U.runtime.scope = scope or "ALL"
    if U.RefreshHeader then U.RefreshHeader() end
end

function U.ApplyRole(name, roleKey)
    local role = U.ROLES[roleKey]
    if not role or not role.command then return true end
    return U.SendBot(name, role.command)
end

function U.ConfigureBot(name, slot)
    if not name or not slot then return end
    slot.name = name
    slot.status = "Konfiguration läuft"
    if slot.spec and slot.spec ~= "auto" then U.SendBot(name, "talents spec " .. slot.spec) end
    U.ApplyRole(name, slot.role)
    U.SendBot(name, "nc +follow,+loot")
    slot.status = "Bereit"
end

local function RosterNameSet()
    local names = {}
    for _, member in ipairs(U.GetRoster()) do names[member.name] = true end
    return names
end

local function ContinueBuild()
    local build = U.runtime.pendingBuild
    if not build then return end
    if build.current > build.size then
        U.runtime.pendingBuild = nil
        U.Print("Gruppenprofil wurde angewendet.")
        if U.RefreshAll then U.RefreshAll() end
        return
    end

    if build.current > 4 and (not GetNumRaidMembers or GetNumRaidMembers() == 0) then
        if not ConvertToRaid then
            U.Print("Für mehr als vier Bots muss die Gruppe zuerst in einen Schlachtzug umgewandelt werden.", true)
            U.runtime.pendingBuild = nil
            return
        end
        if not build.convertStarted then
            build.convertStarted = GetTime()
            ConvertToRaid()
            U.Print("Gruppe wird für den weiteren Aufbau in einen Schlachtzug umgewandelt.")
        elseif GetTime() - build.convertStarted > 8 then
            U.Print("Die Gruppe konnte nicht in einen Schlachtzug umgewandelt werden.", true)
            U.runtime.pendingBuild = nil
            return
        end
        build.nextStep = GetTime() + 1
        return
    end

    local slot = build.slots[build.current]
    if not slot then build.current = build.current + 1; build.nextStep = GetTime() + 0.7; return end

    if slot.name and U.FindRosterMember(slot.name) then
        build.claimed[slot.name] = true
        U.ConfigureBot(slot.name, slot)
        build.current = build.current + 1
        build.nextStep = GetTime() + 0.7
        return
    end

    local unused
    for _, member in ipairs(U.GetRoster()) do
        if not build.claimed[member.name] and (slot.class == "AUTO" or member.class == slot.class) then
            unused = member
            break
        end
    end
    if unused then
        build.claimed[unused.name] = true
        U.ConfigureBot(unused.name, slot)
        build.current = build.current + 1
        build.nextStep = GetTime() + 0.7
        return
    end

    local classData = U.CLASSES[slot.class]
    if not classData or not classData.command then
        slot.status = "Klasse erforderlich"
        U.Print("Platz " .. build.current .. ": Für einen neuen Bot muss eine Klasse gewählt sein.", true)
        build.current = build.current + 1
        build.nextStep = GetTime() + 0.7
        return
    end

    slot.status = "Bot wird angefordert"
    build.waiting = { slot = slot, before = RosterNameSet(), started = GetTime() }
    U.SendConsole(".playerbot bot addclass " .. classData.command)
    if U.RefreshBuilder then U.RefreshBuilder() end
end

function U.StartBuild()
    local builder = UnBot2DB.builder
    local errors = {}
    for index = 1, builder.size do
        local slot = builder.slots[index]
        if slot.class == "AUTO" and not slot.name then table.insert(errors, "Platz " .. index .. ": Klasse fehlt") end
        if not U.IsRoleCompatible(slot.class, slot.spec, slot.role) then table.insert(errors, "Platz " .. index .. ": Spec und Rolle passen nicht") end
    end
    if #errors > 0 then
        U.Print(table.concat(errors, ", "), true)
        return false
    end

    U.runtime.pendingBuild = {
        current = 1,
        size = builder.size,
        slots = builder.slots,
        claimed = {},
        waiting = nil,
        nextStep = 0,
    }
    U.Print("Gruppenaufbau gestartet: " .. tostring(builder.name))
    ContinueBuild()
    return true
end

function U.CancelBuild()
    if U.runtime.pendingBuild then
        U.runtime.pendingBuild = nil
        U.Print("Gruppenaufbau abgebrochen.")
    end
end

function U.OnRosterChanged()
    local build = U.runtime.pendingBuild
    if build and build.waiting then
        for _, member in ipairs(U.GetRoster()) do
            if not build.waiting.before[member.name] then
                local slot = build.waiting.slot
                build.claimed[member.name] = true
                build.waiting = nil
                U.ConfigureBot(member.name, slot)
                build.current = build.current + 1
                build.nextStep = GetTime() + 0.7
                break
            end
        end
    end
    U.runtime.lastRoster = U.GetRoster()
    if U.RefreshAll then U.RefreshAll() end
end

function U.ApplyPreset(presetKey)
    local preset = U.DEFAULT_PRESETS[presetKey]
    if not preset then return end
    local builder = UnBot2DB.builder
    builder.name = preset.name
    builder.groupSize = preset.size
    builder.size = math.max(1, preset.size - 1)
    local composition = {}
    local removedPlayer = false
    for _, role in ipairs(preset.composition or {}) do
        if not removedPlayer and role == builder.playerRole then
            removedPlayer = true
        else
            table.insert(composition, role)
        end
    end
    if not removedPlayer and #composition >= builder.size then table.remove(composition) end
    local roleCounts = {}
    for index = 1, 25 do
        local slot = builder.slots[index] or NewSlot(index)
        local source = preset.slots and preset.slots[index]
        if source then
            slot.class, slot.spec, slot.role, slot.name = source.class, source.spec, source.role, nil
        elseif composition[index] then
            local role = composition[index]
            roleCounts[role] = (roleCounts[role] or 0) + 1
            local defaults = U.ROLE_DEFAULTS[role] or {}
            local selected = defaults[((roleCounts[role] - 1) % math.max(1, #defaults)) + 1]
            slot.class = selected and selected.class or "AUTO"
            slot.spec = selected and selected.spec or "auto"
            slot.role, slot.name = role, nil
        else
            slot.class, slot.spec, slot.role, slot.name = "AUTO", "auto", "AUTO", nil
        end
        slot.status = "Offen"
        builder.slots[index] = slot
    end
    if U.RefreshBuilder then U.RefreshBuilder() end
    U.Print("Vorlage geladen: " .. preset.name)
end

function U.SaveProfile(name)
    name = name and strtrim(name) or ""
    if name == "" then U.Print("Bitte einen Profilnamen eingeben.", true); return false end
    local copy = U.CopyTable(UnBot2DB.builder)
    copy.name = name
    UnBot2DB.profiles[name] = copy
    UnBot2DB.builder.name = name
    U.Print("Profil gespeichert: " .. name)
    return true
end

function U.LoadProfile(name)
    local profile = UnBot2DB.profiles[name]
    if not profile then U.Print("Profil nicht gefunden.", true); return false end
    UnBot2DB.builder = U.CopyTable(profile)
    for index = 1, 25 do UnBot2DB.builder.slots[index] = UnBot2DB.builder.slots[index] or NewSlot(index) end
    if U.RefreshBuilder then U.RefreshBuilder() end
    U.Print("Profil geladen: " .. name)
    return true
end

function U.DeleteProfile(name)
    if not UnBot2DB.profiles[name] then return false end
    UnBot2DB.profiles[name] = nil
    U.Print("Profil gelöscht: " .. name)
    if U.RefreshBuilder then U.RefreshBuilder() end
    return true
end

function U.RequestBridgeHandshake()
    if not UnBot2DB.settings.bridge or not SendAddonMessage then return end
    if RegisterAddonMessagePrefix then RegisterAddonMessagePrefix(U.ADDON_PREFIX) end
    SendAddonMessage(U.ADDON_PREFIX, "HELLO|" .. U.VERSION, "WHISPER", UnitName("player"))
end

function U.HandleAddonMessage(prefix, message, channel, sender)
    if prefix ~= U.ADDON_PREFIX then return end
    local version = string.match(message or "", "^WELCOME|([^|]+)")
    if version then
        U.runtime.bridge = true
        U.runtime.bridgeVersion = version
        U.Print("Server-Brücke verbunden (" .. version .. ").")
        if U.RefreshHeader then U.RefreshHeader() end
        return
    end
    local requestId, result, errorCode = string.match(message or "", "^ACK|([^|]+)|([^|]+)|?(.*)$")
    if requestId then
        local pending = U.runtime.pendingRequests[requestId]
        U.runtime.pendingRequests[requestId] = nil
        if result ~= "OK" then
            U.Print("Brückenbefehl fehlgeschlagen: " .. (errorCode ~= "" and errorCode or result), true)
        elseif pending and UnBot2DB.settings.chatFeedback then
            U.Print(pending.bot .. ": Befehl bestätigt.")
        end
    end
end

-- Dungeon Clear is optional. The server replies on the DC addon protocol only
-- when mod-dungeon-clear is installed, allowing this panel to remain hidden otherwise.
U.runtime.dungeonClear = U.runtime.dungeonClear or { available = false, status = "Modul wird geprüft …" }

local function DungeonClearChannel()
    if GetNumRaidMembers and GetNumRaidMembers() > 0 then return "RAID" end
    if GetNumPartyMembers and GetNumPartyMembers() > 0 then return "PARTY" end
    return nil
end

function U.RefreshDungeonClear()
    if U.ui and U.ui.dungeonClearPanel then
        if U.runtime.dungeonClear.available then U.ui.dungeonClearPanel:Show() else U.ui.dungeonClearPanel:Hide() end
    end
    if U.ui and U.ui.dungeonClearHint then U.ui.dungeonClearHint:SetText(U.runtime.dungeonClear.status or "") end
end

function U.ProbeDungeonClear()
    local channel = DungeonClearChannel()
    if not channel or not SendAddonMessage then
        U.runtime.dungeonClear.status = "Dungeon-Clear wird angezeigt, sobald du in einer Bot-Gruppe bist."
        U.RefreshDungeonClear()
        return
    end
    if RegisterAddonMessagePrefix then RegisterAddonMessagePrefix("DC") end
    U.runtime.dungeonClear.status = "Dungeon-Clear wird geprüft …"
    SendAddonMessage("DC", "CMD\tstatus", channel)
    U.RefreshDungeonClear()
end

function U.SendDungeonClear(command, parameter)
    local channel = DungeonClearChannel()
    if not channel then U.Print("Für Dungeon Clear musst du in einer Gruppe mit einem Tank-Bot sein.", true); return false end
    if not U.runtime.dungeonClear.available then U.Print("Dungeon-Clear-Modul ist auf diesem Server noch nicht erreichbar.", true); U.ProbeDungeonClear(); return false end
    local payload = "CMD\t" .. command
    if parameter and parameter ~= "" then payload = payload .. "\t" .. parameter end
    SendAddonMessage("DC", payload, channel)
    if UnBot2DB.settings.chatFeedback then U.Print("Dungeon Clear: " .. command) end
    return true
end

function U.HandleDungeonClearAddonMessage(prefix, message)
    if prefix ~= "DC" then return false end
    U.runtime.dungeonClear.available = true
    U.runtime.dungeonClear.status = "Dungeon-Clear-Modul bereit"
    local kind, detail = string.match(message or "", "^([^\t]+)\t?(.*)$")
    if kind == "ERROR" and detail ~= "" then U.runtime.dungeonClear.status = "Dungeon Clear: " .. detail end
    U.RefreshDungeonClear()
    return true
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
eventFrame:RegisterEvent("RAID_ROSTER_UPDATE")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("CHAT_MSG_ADDON")
eventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
eventFrame:RegisterEvent("CHAT_MSG_WHISPER")
eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        U.InitializeDB()
        U.runtime.lastRoster = U.GetRoster()
        if U.CreateUI then U.CreateUI() end
        U.RequestBridgeHandshake()
    elseif event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" then
        U.OnRosterChanged()
        if U.ProbeDungeonClear then U.ProbeDungeonClear() end
    elseif event == "PLAYER_TARGET_CHANGED" then
        if UnitExists("target") and UnitIsPlayer("target") then U.SetSelectedBot(UnitName("target")) end
    elseif event == "PLAYER_REGEN_DISABLED" then
        if U.OnCombatStateChanged then U.OnCombatStateChanged(true) end
    elseif event == "PLAYER_REGEN_ENABLED" then
        if U.OnCombatStateChanged then U.OnCombatStateChanged(false) end
    elseif event == "CHAT_MSG_ADDON" then
        local prefix, message = ...
        if U.HandleDungeonClearAddonMessage then U.HandleDungeonClearAddonMessage(prefix, message) end
        U.HandleAddonMessage(...)
    elseif event == "CHAT_MSG_SYSTEM" or event == "CHAT_MSG_WHISPER" then
        local message = ...
        if U.runtime.pendingBuild and U.runtime.pendingBuild.waiting and message and string.find(string.lower(message), "failed", 1, true) then
            U.Print("Server meldet einen Fehler beim Hinzufügen des Bots: " .. message, true)
        end
    end
end)

eventFrame:SetScript("OnUpdate", function(self, elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed
    if self.elapsed < 1 then return end
    self.elapsed = 0
    local build = U.runtime.pendingBuild
    if build and build.waiting and GetTime() - build.waiting.started > 15 then
        local slot = build.waiting.slot
        slot.status = "Zeitüberschreitung"
        build.waiting = nil
        build.current = build.current + 1
        U.Print("Bot für Platz " .. slot.index .. " wurde nicht rechtzeitig geladen.", true)
        build.nextStep = GetTime() + 0.7
    end
    if build and not build.waiting and GetTime() >= (build.nextStep or 0) then ContinueBuild() end
    for requestId, pending in pairs(U.runtime.pendingRequests) do
        if GetTime() - pending.started > 8 then
            U.runtime.pendingRequests[requestId] = nil
            U.runtime.bridge = false
            U.Print("Server-Brücke antwortet nicht; zurück im Chatmodus.", true)
            if U.RefreshHeader then U.RefreshHeader() end
            break
        end
    end
    if U.RefreshRoster then U.RefreshRoster() end
end)


local U = UNBOT2

local ui = { pages = {}, nav = {}, builderRows = {}, rosterRows = {}, diagRows = {}, page = "OVERVIEW", builderPage = 1, rosterOffset = 0 }
U.ui = ui

local COLORS = {
    bg = { 0.025, 0.035, 0.055, 0.97 }, panel = { 0.055, 0.075, 0.105, 0.95 },
    border = { 0.18, 0.45, 0.68, 1 }, gold = { 1, 0.78, 0.22, 1 },
    blue = { 0.20, 0.70, 1, 1 }, green = { 0.30, 0.90, 0.48, 1 }, red = { 1, 0.30, 0.30, 1 },
}

local function Backdrop(frame, panel)
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 14,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    local bg = panel and COLORS.panel or COLORS.bg
    frame:SetBackdropColor(bg[1], bg[2], bg[3], bg[4])
    frame:SetBackdropBorderColor(unpack(COLORS.border))
end

local function Label(parent, text, template, x, y, anchor)
    local label = parent:CreateFontString(nil, "OVERLAY", template or "GameFontNormal")
    label:SetPoint(anchor or "TOPLEFT", parent, anchor or "TOPLEFT", x or 0, y or 0)
    label:SetText(U.L(text or ""))
    return label
end

local function Section(parent, title, x, y, width, height)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    frame:SetWidth(width); frame:SetHeight(height)
    Backdrop(frame, true)
    frame.title = Label(frame, title, "GameFontNormalLarge", 12, -10)
    frame.title:SetTextColor(unpack(COLORS.gold))
    return frame
end

local function Tooltip(owner, title, text, command)
    GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
    GameTooltip:AddLine(U.L(title or "SquadControl"), 1, 0.82, 0)
    if text then GameTooltip:AddLine(U.L(text), 1, 1, 1, true) end
    if command then GameTooltip:AddLine((GetLocale and GetLocale() == "deDE" and "Serverbefehl: " or "Server command: ") .. command, 0.35, 0.85, 1, true) end
    GameTooltip:Show()
end

local function Button(parent, text, x, y, width, height, callback, tooltip, command)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    button:SetWidth(width or 110); button:SetHeight(height or 24)
    button:SetText(U.L(text))
    button:SetScript("OnClick", callback)
    if tooltip or command then
        button:SetScript("OnEnter", function(self) Tooltip(self, self:GetText(), tooltip, command) end)
        button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end
    return button
end

local dropdownCounter = 0
local function Dropdown(parent, x, y, width, getItems, onSelect)
    dropdownCounter = dropdownCounter + 1
    local name = "UnBot2Dropdown" .. dropdownCounter
    local drop = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate")
    drop:SetPoint("TOPLEFT", parent, "TOPLEFT", x - 16, y + 2)
    UIDropDownMenu_SetWidth(drop, width or 120)
    drop.getItems = getItems
    drop.onSelect = onSelect
    UIDropDownMenu_Initialize(drop, function()
        for _, item in ipairs(drop.getItems() or {}) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = item.text
            info.value = item.value
            info.checked = item.value == drop.value
            info.disabled = item.disabled
            local itemValue, itemText = item.value, item.text
            info.func = function()
                drop.value = itemValue
                UIDropDownMenu_SetSelectedValue(drop, itemValue)
                UIDropDownMenu_SetText(drop, itemText)
                if drop.onSelect then drop.onSelect(itemValue, { value = itemValue, text = itemText }) end
            end
            UIDropDownMenu_AddButton(info)
        end
    end)
    function drop:SetValue(value, text)
        self.value = value
        UIDropDownMenu_SetSelectedValue(self, value)
        UIDropDownMenu_SetText(self, text or value or "Auswählen")
    end
    return drop
end

local function Check(parent, text, x, y, callback)
    local check = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    check:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    check:SetWidth(24); check:SetHeight(24)
    check.label = Label(check, text, "GameFontNormal", 28, -5)
    check:SetScript("OnClick", function(self) callback(self:GetChecked() and true or false) end)
    return check
end

local function SetVisible(frame, visible)
    if visible then frame:Show() else frame:Hide() end
end

local function EditBox(parent, x, y, width, placeholder)
    local edit = CreateFrame("EditBox", nil, parent)
    edit:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    edit:SetWidth(width); edit:SetHeight(26); edit:SetAutoFocus(false)
    Backdrop(edit, true)
    edit:SetFontObject("GameFontHighlight")
    edit:SetTextInsets(8, 8, 0, 0)
    edit:SetTextColor(0.88, 0.92, 1)
    edit.placeholder = placeholder
    edit:SetText(placeholder or "")
    edit:SetScript("OnEditFocusGained", function(self)
        self:SetBackdropBorderColor(0.20, 0.70, 1, 1)
        if self:GetText() == self.placeholder then self:SetText("") end
    end)
    edit:SetScript("OnEditFocusLost", function(self)
        self:SetBackdropBorderColor(unpack(COLORS.border))
        if self:GetText() == "" then self:SetText(self.placeholder or "") end
    end)
    edit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    return edit
end

local function ScopeItems(includeBot)
    local items = {
        { value = "ALL", text = "Alle Bots" }, { value = "TANK", text = "Tanks" },
        { value = "HEAL", text = "Heiler" }, { value = "DPS", text = "Alle DD" },
        { value = "MELEE", text = "Nahkampf-DD" }, { value = "RANGED", text = "Fernkampf-DD" },
    }
    if includeBot then table.insert(items, 2, { value = "BOT", text = "Gewählter Bot" }) end
    if GetNumRaidMembers and GetNumRaidMembers() > 0 then
        for index = 1, 8 do table.insert(items, { value = "GROUP" .. index, text = "Raidgruppe " .. index }) end
    end
    return items
end

local function BotItems(includeAuto)
    local items = {}
    if includeAuto then table.insert(items, { value = "AUTO", text = "Neu / automatisch" }) end
    for _, member in ipairs(U.GetRoster()) do
        local class = U.CLASSES[member.class]
        table.insert(items, { value = member.name, text = member.name .. " – " .. (class and class.label or "Unbekannt") })
    end
    return items
end

local PAGE_DEFS = {
    { id = "OVERVIEW", label = "Übersicht", icon = "Interface\\Icons\\INV_Misc_Map_01" },
    { id = "GROUP", label = "Gruppe", icon = "Interface\\Icons\\Spell_Holy_PrayerOfSpirit" },
    { id = "COMBAT", label = "Kampf", icon = "Interface\\Icons\\Ability_Warrior_BattleShout" },
    { id = "TACTIC", label = "Taktik", icon = "Interface\\Icons\\Ability_Marksmanship" },
    { id = "DUNGEON", label = "Dungeon", icon = "Interface\\Icons\\Achievement_Dungeon_UtgardePinnacle" },
    { id = "ADVENTURE", label = "Abenteuer", icon = "Interface\\Icons\\INV_Misc_Book_11" },
    { id = "GEAR", label = "Ausrüstung", icon = "Interface\\Icons\\INV_Chest_Plate04" },
    { id = "BOTS", label = "Bots", icon = "Interface\\Icons\\INV_Misc_Gear_01" },
    { id = "SETTINGS", label = "Einstellungen", icon = "Interface\\Icons\\Trade_Engineering" },
}

local function Page(id)
    if ui.pages[id] then return ui.pages[id] end
    local page = CreateFrame("Frame", nil, ui.content)
    page:SetAllPoints(ui.content)
    page:Hide()
    ui.pages[id] = page
    return page
end

local function ShowPageError(id, label, errorText)
    local page = Page(id)
    Label(page, label .. " konnte nicht vollständig geladen werden.", "GameFontNormalLarge", 12, -16):SetTextColor(1, 0.3, 0.3)
    local detail = Label(page, tostring(errorText or "Unbekannter Fehler"), "GameFontNormalSmall", 12, -52)
    detail:SetWidth(590); detail:SetJustifyH("LEFT")
end

local function SafeCreatePage(id, label, creator)
    local ok, errorText = pcall(creator)
    if not ok then
        ShowPageError(id, label, errorText)
        U.Print(label .. " konnte nicht geladen werden: " .. tostring(errorText), true)
    end
    return ok
end

function U.ShowPage(id)
    for pageId, page in pairs(ui.pages) do
        SetVisible(page, pageId == id)
        if ui.nav[pageId] then ui.nav[pageId]:SetAlpha(pageId == id and 1 or 0.68) end
    end
    ui.page = id
    if id == "GROUP" then U.RefreshBuilder() end
    if id == "SETTINGS" then U.RefreshDiagnostics() end
end

function U.RefreshHeader()
    if not ui.frame then return end
    local count = #U.GetRoster()
    local max = UnBot2DB and UnBot2DB.builder and UnBot2DB.builder.size or 4
    ui.groupStatus:SetText((GetLocale and GetLocale() == "deDE" and "Gruppe: " or "Squad: ") .. "|cffffffff" .. count .. "/" .. max .. " " .. (GetLocale and GetLocale() == "deDE" and "Bots" or "bots") .. "|r")
    ui.targetStatus:SetText((GetLocale and GetLocale() == "deDE" and "Zielbot: " or "Selected bot: ") .. "|cffffffff" .. (U.L(U.runtime.selectedBot or "Keiner")) .. "|r")
    if U.runtime.bridge then
        ui.connection:SetText("|cff55dd77● Server-Brücke|r")
    else
        ui.connection:SetText("|cffffcc55● Chatmodus|r")
    end
end

local function CreateRosterPanel(parent, x, y, width, height, rows)
    local panel = Section(parent, "Aktuelle Gruppe", x, y, width, height)
    ui.rosterPageSize = rows
    for index = 1, rows do
        local row = CreateFrame("Button", nil, panel)
        row:SetPoint("TOPLEFT", panel, "TOPLEFT", 10, -38 - ((index - 1) * 31))
        row:SetWidth(width - 58); row:SetHeight(28)
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetWidth(22); row.icon:SetHeight(22); row.icon:SetPoint("LEFT", row, "LEFT", 2, 0)
        row.name = Label(row, "–", "GameFontNormal", 30, -2, "LEFT")
        row.name:ClearAllPoints(); row.name:SetPoint("LEFT", row, "LEFT", 30, 5)
        row.info = Label(row, "", "GameFontNormalSmall", 30, -7, "LEFT")
        row.info:ClearAllPoints(); row.info:SetPoint("LEFT", row, "LEFT", 30, -8)
        row.info:SetWidth(width - 165); row.info:SetJustifyH("LEFT")
        row.health = Label(row, "", "GameFontNormalSmall", -4, 0, "RIGHT")
        row.health:ClearAllPoints(); row.health:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        row:SetScript("OnClick", function(self) if self.botName then U.SetSelectedBot(self.botName) end end)
        table.insert(ui.rosterRows, row)
    end
    ui.rosterUp = Button(panel, "▲", width - 40, -40, 26, 25, function()
        ui.rosterOffset = math.max(0, ui.rosterOffset - (ui.rosterPageSize or 8)); U.RefreshRoster()
    end, "Vorherige Gruppenmitglieder")
    ui.rosterDown = Button(panel, "▼", width - 40, -278, 26, 25, function()
        local roster = U.GetRoster(); local pageSize = ui.rosterPageSize or 8
        local lastPage = #roster > 0 and (math.floor((#roster - 1) / pageSize) * pageSize) or 0
        ui.rosterOffset = math.min(lastPage, ui.rosterOffset + pageSize); U.RefreshRoster()
    end, "Nächste Gruppenmitglieder")
    ui.rosterRange = Label(panel, "0 / 0", "GameFontNormalSmall", width - 47, -151)
    ui.rosterRange:SetWidth(40); ui.rosterRange:SetJustifyH("CENTER")
    panel:EnableMouseWheel(true)
    panel:SetScript("OnMouseWheel", function(_, delta)
        local roster = U.GetRoster(); local pageSize = ui.rosterPageSize or 8
        if delta > 0 then ui.rosterOffset = math.max(0, ui.rosterOffset - pageSize)
        else
            local lastPage = #roster > 0 and (math.floor((#roster - 1) / pageSize) * pageSize) or 0
            ui.rosterOffset = math.min(lastPage, ui.rosterOffset + pageSize)
        end
        U.RefreshRoster()
    end)
    return panel
end

function U.RefreshRoster()
    if not ui.frame then return end
    local roster = U.GetRoster()
    local pageSize = ui.rosterPageSize or #ui.rosterRows
    local maxOffset = #roster > 0 and (math.floor((#roster - 1) / pageSize) * pageSize) or 0
    ui.rosterOffset = math.max(0, math.min(ui.rosterOffset or 0, maxOffset))
    for index, row in ipairs(ui.rosterRows) do
        local member = roster[index + ui.rosterOffset]
        if member then
            local class = U.CLASSES[member.class] or U.CLASSES.AUTO
            row.botName = member.name
            local iconCoords = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[member.class]
            if iconCoords then
                row.icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
                row.icon:SetTexCoord(unpack(iconCoords))
            else
                row.icon:SetTexture("Interface\\Icons\\INV_Misc_Gear_01")
                row.icon:SetTexCoord(0, 1, 0, 1)
            end
            row.name:SetText(class.color .. member.name .. "|r")
            local state = not member.online and "|cffff5555Offline|r" or member.dead and "|cffff5555Tot|r" or class.label
            local configuredSlot
            if UnBot2DB and UnBot2DB.builder and UnBot2DB.builder.slots then
                for _, slot in ipairs(UnBot2DB.builder.slots) do
                    if slot.name == member.name then configuredSlot = slot; break end
                end
            end
            local specLabel = "Spec unbekannt"
            if configuredSlot and configuredSlot.spec and configuredSlot.spec ~= "auto" then
                local spec = U.GetSpec(member.class, configuredSlot.spec)
                specLabel = spec and spec.label or configuredSlot.spec
            end
            row.info:SetText(state .. " |cff71869d·|r |cffb8dfff" .. specLabel .. "|r")
            local percent = member.healthMax > 0 and math.floor((member.health / member.healthMax) * 100) or 0
            row.health:SetText((percent < 35 and "|cffff5555" or "|cff77dd77") .. percent .. "%|r")
            row:Show()
        else
            row.botName = nil; row.icon:SetTexture(nil); row.icon:SetTexCoord(0, 1, 0, 1)
            row.name:SetText("|cff666666Freier Platz|r"); row.info:SetText(""); row.health:SetText(""); row:Show()
        end
    end
    if ui.rosterRange then
        local first = #roster > 0 and (ui.rosterOffset + 1) or 0
        local last = math.min(#roster, ui.rosterOffset + pageSize)
        ui.rosterRange:SetText(first .. "–" .. last .. "\n/ " .. #roster)
        SetVisible(ui.rosterUp, #roster > pageSize)
        SetVisible(ui.rosterDown, #roster > pageSize)
    end
    U.RefreshHeader()
    if U.RefreshCompactCombat then U.RefreshCompactCombat() end
end

StaticPopupDialogs["UNBOT2_CONFIRM_DISBAND"] = {
    text = "Soll die aktuelle Botgruppe wirklich aufgelöst werden?",
    button1 = "Gruppe auflösen", button2 = CANCEL,
    timeout = 0, whileDead = true, hideOnEscape = true,
    OnAccept = function()
        U.SendGroup("leave", "ALL")
        U.Print("Die Bots verlassen die aktuelle Gruppe.")
    end,
}

local function CreateOverview()
    local page = Page("OVERVIEW")
    Label(page, "Einsatzübersicht", "GameFontNormalHuge", 8, -8)
    local cards = {
        { "Gruppe vorbereiten", "Rollen, Specs und Bots als Profil zusammenstellen.", "GROUP" },
        { "Kampfzentrale", "Sofortbefehle, Zielgruppen und Kampfschalter.", "COMBAT" },
        { "Bots verwalten", "Bots anmelden, hinzufügen und initialisieren.", "BOTS" },
    }
    for index, card in ipairs(cards) do
        local cardDef = card
        local x = 8 + ((index - 1) * 204)
        local panel = Section(page, cardDef[1], x, -43, 194, 112)
        local text = Label(panel, cardDef[2], "GameFontNormalSmall", 12, -38)
        text:SetWidth(168); text:SetJustifyH("LEFT")
        Button(panel, "Öffnen", 12, -79, 168, 23, function() U.ShowPage(cardDef[3]) end)
    end
    CreateRosterPanel(page, 8, -166, 400, 335, 8)
    local quick = Section(page, "Schnellaktionen", 420, -166, 200, 335)
    local actions = {
        { "Alle folgen", "follow" }, { "Sammeln", "summon" }, { "Position halten", "stay" },
        { "Bereitschaft", "ready" }, { "Buffs", "buff" }, { "Wartung", "maintenance" },
        { "Autogear", "autogear" }, { "KI zurücksetzen", "reset botAI" },
    }
    for index, action in ipairs(actions) do
        local actionDef = action
        Button(quick, actionDef[1], 12, -39 - ((index - 1) * 34), 176, 27, function() U.SendGroup(actionDef[2]) end, nil, actionDef[2])
    end
    local disband = Button(quick, "Gruppe auflösen", 12, -307, 176, 25, function()
        StaticPopup_Show("UNBOT2_CONFIRM_DISBAND")
    end, "Entlässt nach Bestätigung alle Bots aus der aktuellen Gruppe.", "leave")
    disband:GetFontString():SetTextColor(1, 0.35, 0.35)
end


local function ClassItems()
    local items = {}
    for _, key in ipairs(U.CLASS_ORDER) do table.insert(items, { value = key, text = U.L(U.CLASSES[key].label) }) end
    return items
end

local function SpecItems(slot)
    slot = slot or { class = "AUTO", spec = "auto", role = "AUTO" }
    local items = {}
    for _, spec in ipairs(U.SPECS[slot.class] or U.SPECS.AUTO) do table.insert(items, { value = spec.value, text = U.L(spec.label) }) end
    return items
end

local function RoleItems(slot)
    slot = slot or { class = "AUTO", spec = "auto", role = "AUTO" }
    local items = {}
    for _, key in ipairs(U.ROLE_ORDER) do
        if U.IsRoleCompatible(slot.class, slot.spec, key) then table.insert(items, { value = key, text = U.L(U.ROLES[key].label) }) end
    end
    return items
end

local function SlotSpecLabel(slot)
    local spec = U.GetSpec(slot.class, slot.spec)
    return U.L(spec and spec.label or "Automatisch")
end

local function CreateBuilderRow(parent, rowIndex)
    local row = CreateFrame("Frame", nil, parent)
    row.slotIndex = rowIndex
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", 8, -111 - ((rowIndex - 1) * 47))
    row:SetWidth(606); row:SetHeight(43)
    row.bg = row:CreateTexture(nil, "BACKGROUND")
    row.bg:SetAllPoints(row); row.bg:SetTexture(0.08, 0.10, 0.14, rowIndex % 2 == 0 and 0.8 or 0.55)
    row.number = Label(row, tostring(rowIndex), "GameFontNormalLarge", 8, -12)
    row.bot = Dropdown(row, 25, -5, 120, function() return BotItems(true) end, function(value)
        local slot = UnBot2DB.builder.slots[row.slotIndex]
        slot.name = value ~= "AUTO" and value or nil
        if slot.name then
            local member = U.FindRosterMember(slot.name)
            if member then slot.class = member.class; slot.spec = (U.SPECS[slot.class] and U.SPECS[slot.class][1].value) or "auto" end
        end
        U.RefreshBuilder()
    end)
    row.class = Dropdown(row, 167, -5, 100, ClassItems, function(value)
        local slot = UnBot2DB.builder.slots[row.slotIndex]
        slot.class = value; slot.name = nil
        slot.spec = (U.SPECS[value] and U.SPECS[value][1].value) or "auto"
        local spec = U.GetSpec(value, slot.spec)
        if spec and spec.roles and spec.roles[1] then slot.role = spec.roles[1] else slot.role = "AUTO" end
        U.RefreshBuilder()
    end)
    row.spec = Dropdown(row, 285, -5, 118, function() return SpecItems(UnBot2DB.builder.slots[row.slotIndex]) end, function(value)
        local slot = UnBot2DB.builder.slots[row.slotIndex]
        slot.spec = value
        if not U.IsRoleCompatible(slot.class, slot.spec, slot.role) then
            local spec = U.GetSpec(slot.class, value); slot.role = spec and spec.roles[1] or "AUTO"
        end
        U.RefreshBuilder()
    end)
    row.role = Dropdown(row, 423, -5, 102, function() return RoleItems(UnBot2DB.builder.slots[row.slotIndex]) end, function(value)
        local slot = UnBot2DB.builder.slots[row.slotIndex]; slot.role = value; U.RefreshBuilder()
    end)
    row.status = Label(row, "Offen", "GameFontNormalSmall", 548, -17)
    row.status:SetWidth(52); row.status:SetJustifyH("CENTER")
    return row
end

function U.RefreshBuilder()
    if not ui.builderRows[1] then return end
    local builder = UnBot2DB.builder
    builder.slots = type(builder.slots) == "table" and builder.slots or {}
    builder.size = tonumber(builder.size) or 4
    builder.playerRole = U.ROLES[builder.playerRole] and builder.playerRole or "RANGED"
    if ui.builderName and not ui.builderName:HasFocus() then ui.builderName:SetText(builder.name or "Neue Gruppe") end
    if ui.playerRole then ui.playerRole:SetValue(builder.playerRole, (U.ROLES[builder.playerRole] and U.ROLES[builder.playerRole].label) or "Fernkampf-DD") end
    local maxPage = math.max(1, math.ceil(builder.size / 7))
    if ui.builderPage > maxPage then ui.builderPage = maxPage end
    if ui.builderPager then ui.builderPager:SetText("Seite " .. ui.builderPage .. "/" .. maxPage) end
    for rowIndex, row in ipairs(ui.builderRows) do
        local slotIndex = ((ui.builderPage - 1) * 7) + rowIndex
        row.slotIndex = slotIndex
        local slot = builder.slots[slotIndex]
        if slot and slotIndex <= builder.size then
            row.number:SetText(tostring(slotIndex))
            row.bot:SetValue(slot.name or "AUTO", slot.name or "Neu / automatisch")
            row.class:SetValue(slot.class, U.CLASSES[slot.class] and U.CLASSES[slot.class].label or "Automatisch")
            row.spec:SetValue(slot.spec, SlotSpecLabel(slot))
            row.role:SetValue(slot.role, U.ROLES[slot.role] and U.ROLES[slot.role].label or "Automatisch")
            local valid = U.IsRoleCompatible(slot.class, slot.spec, slot.role)
            row.status:SetText(valid and (slot.status == "Bereit" and "|cff55dd77Bereit|r" or "|cffffcc55" .. (slot.status or "Offen") .. "|r") or "|cffff5555Ungültig|r")
            row:Show()
        else row:Hide() end
    end
end

local function ProfileItems()
    local items = {}
    for name in pairs(UnBot2DB.profiles or {}) do table.insert(items, { value = name, text = name }) end
    table.sort(items, function(a, b) return a.text < b.text end)
    if #items == 0 then table.insert(items, { value = "", text = "Keine gespeicherten Profile", disabled = true }) end
    return items
end

local function CreateGroupBuilder()
    local page = Page("GROUP")
    Label(page, "Gruppe zusammenstellen", "GameFontNormalHuge", 8, -8)
    Label(page, "Vorlage:", "GameFontNormal", 8, -44)
    Button(page, "5er Dungeon", 62, -40, 105, 24, function() U.ApplyPreset("dungeon") end)
    Button(page, "Questgruppe", 171, -40, 105, 24, function() U.ApplyPreset("quest") end)
    Button(page, "10er Raid", 280, -40, 90, 24, function() U.ApplyPreset("raid10") end)
    Button(page, "25er Raid", 374, -40, 90, 24, function() U.ApplyPreset("raid25") end)
    ui.playerRole = Dropdown(page, 476, -40, 110, function()
        return {
            { value = "TANK", text = "Ich: Tank" }, { value = "HEAL", text = "Ich: Heiler" },
            { value = "MELEE", text = "Ich: Nahkampf" }, { value = "RANGED", text = "Ich: Fernkampf" },
        }
    end, function(value)
        UnBot2DB.builder.playerRole = value
        if UnBot2DB.builder.groupSize == 5 then U.ApplyPreset("dungeon")
        elseif UnBot2DB.builder.groupSize == 10 then U.ApplyPreset("raid10")
        elseif UnBot2DB.builder.groupSize == 25 then U.ApplyPreset("raid25") end
    end)

    Label(page, "Nr.", "GameFontNormalSmall", 12, -92)
    Label(page, "Bot", "GameFontNormalSmall", 49, -92)
    Label(page, "Klasse", "GameFontNormalSmall", 189, -92)
    Label(page, "Spezialisierung", "GameFontNormalSmall", 307, -92)
    Label(page, "Rolle", "GameFontNormalSmall", 446, -92)
    Label(page, "Status", "GameFontNormalSmall", 558, -92)
    for index = 1, 7 do table.insert(ui.builderRows, CreateBuilderRow(page, index)) end

    Button(page, "‹", 8, -446, 34, 24, function() ui.builderPage = math.max(1, ui.builderPage - 1); U.RefreshBuilder() end)
    ui.builderPager = Label(page, "Seite 1/1", "GameFontNormal", 51, -452)
    Button(page, "›", 126, -446, 34, 24, function() ui.builderPage = ui.builderPage + 1; U.RefreshBuilder() end)

    ui.builderName = EditBox(page, 176, -447, 164, "Profilname")
    Button(page, "Speichern", 345, -446, 78, 24, function()
        local name = ui.builderName:GetText(); if name == ui.builderName.placeholder then name = "" end
        U.SaveProfile(name); U.RefreshBuilder()
    end)
    ui.profileDrop = Dropdown(page, 431, -446, 120, ProfileItems, function(value) if value ~= "" then U.LoadProfile(value) end end)
    ui.profileDrop:SetValue("", "Profil laden")
    Button(page, "Löschen", 566, -446, 55, 24, function() if ui.profileDrop.value and ui.profileDrop.value ~= "" then U.DeleteProfile(ui.profileDrop.value) end end)

    Button(page, "Gruppe anwenden", 376, -487, 150, 32, function() U.StartBuild() end, "Fügt fehlende Bots nacheinander hinzu und wendet Spec, Rolle und Verhalten an.")
    Button(page, "Abbrechen", 532, -487, 89, 32, function() U.CancelBuild() end)
end

local function CombatCommand(parent, text, command, x, y, color, targetBot)
    local button = Button(parent, text, x, y, 132, 38, function()
        if targetBot then U.SendBot(U.runtime.selectedBot, command) else U.SendCommand(command) end
    end, nil, command)
    if color then button:GetFontString():SetTextColor(unpack(color)) end
    return button
end

local function CreateCompactCombat()
    local frame = CreateFrame("Frame", "UnBot2CombatBar", UIParent)
    frame:SetWidth(530); frame:SetHeight(58); frame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150)
    frame:SetMovable(true); frame:EnableMouse(true); frame:RegisterForDrag("LeftButton"); frame:SetClampedToScreen(true)
    frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    Backdrop(frame, false)
    local actions = {
        { "ANGRIFF", "attack" }, { "STOPP", "flee" }, { "FOLGEN", "follow" },
        { "HIERHER", "summon" }, { "HALTEN", "stay" },
    }
    for index, action in ipairs(actions) do
        local actionDef = action
        Button(frame, actionDef[1], 8 + ((index - 1) * 82), -10, 78, 36, function() U.SendGroup(actionDef[2], U.runtime.scope) end, nil, actionDef[2])
    end
    ui.compactRelease = Button(frame, "GEIST FREI", 418, -10, 78, 36, function()
        U.SendGroup("release", "ALL")
    end, "Nur tote Bots lassen ihren Geist frei.", "release")
    ui.compactRelease:Hide()
    ui.compactPull = Button(frame, "PULL", 500, -10, 78, 36, function()
        local tankName = U.GetTankBotName and U.GetTankBotName()
        if tankName then U.SendBot(tankName, "pull my target")
        else U.Print("Kein Tankbot in der aktuellen Gruppe gefunden.", true) end
    end, "Der Tank greift dein aktuelles Ziel an und zieht es zur Gruppe.", "pull my target")
    ui.compactPull:GetFontString():SetTextColor(unpack(COLORS.gold))
    ui.compactPull:Hide()
    ui.compactClose = Button(frame, "×", 420, -4, 22, 20, function() frame:Hide(); UnBot2DB.combat.compact = false end)
    frame:Hide(); ui.compactCombat = frame
end

function U.GetTankBotName()
    if not UnBot2DB or not UnBot2DB.builder or not UnBot2DB.builder.slots then return nil end
    local roster = U.GetRoster()
    for _, member in ipairs(roster) do
        for _, slot in ipairs(UnBot2DB.builder.slots) do
            if slot.name == member.name and slot.role == "TANK" and member.online and not member.dead then return member.name end
        end
    end
    return nil
end

function U.HasDeadBot()
    for _, member in ipairs(U.GetRoster()) do
        if member.dead then return true end
    end
    return false
end

function U.RefreshCompactCombat()
    if not ui.compactCombat or not ui.compactPull or not ui.compactRelease or not ui.compactClose then return end
    local hasTank = U.GetTankBotName() ~= nil
    local hasDeadBot = U.HasDeadBot()
    local nextX = 418
    if hasDeadBot then
        ui.compactRelease:ClearAllPoints()
        ui.compactRelease:SetPoint("TOPLEFT", ui.compactCombat, "TOPLEFT", nextX, -10)
        ui.compactRelease:Show()
        nextX = nextX + 82
    else
        ui.compactRelease:Hide()
    end
    if hasTank then
        ui.compactPull:ClearAllPoints()
        ui.compactPull:SetPoint("TOPLEFT", ui.compactCombat, "TOPLEFT", nextX, -10)
        ui.compactPull:Show()
        nextX = nextX + 82
    else
        ui.compactPull:Hide()
    end
    local closeX = nextX + 2
    ui.compactCombat:SetWidth(closeX + 28)
    ui.compactClose:ClearAllPoints()
    ui.compactClose:SetPoint("TOPLEFT", ui.compactCombat, "TOPLEFT", closeX, -4)
end

function U.OnCombatStateChanged(inCombat)
    if not ui.compactCombat then return end
    if inCombat then
        if #U.GetRoster() > 0 then
            ui.autoCombatBar = not UnBot2DB.combat.compact
            U.RefreshCompactCombat()
            ui.compactCombat:Show()
        end
    elseif ui.autoCombatBar then
        ui.compactCombat:Hide()
        ui.autoCombatBar = false
    end
end

local function CreateCombat()
    local page = Page("COMBAT")
    Label(page, "Kampfzentrale", "GameFontNormalHuge", 8, -8)
    Label(page, "Befehlsziel:", "GameFontNormal", 315, -14)
    ui.combatScope = Dropdown(page, 397, -9, 145, function() return ScopeItems(true) end, function(value) U.SetScope(value) end)
    ui.combatScope:SetValue("ALL", "Alle Bots")
    Button(page, "Kampfleiste", 548, -9, 74, 24, function()
        UnBot2DB.combat.compact = true; ui.autoCombatBar = false; ui.compactCombat:Show()
    end, "Öffnet eine kleine, verschiebbare Sofortleiste.")

    local immediate = Section(page, "Sofortbefehle", 8, -48, 424, 236)
    CombatCommand(immediate, "ANGREIFEN", "attack", 12, -42, COLORS.red)
    CombatCommand(immediate, "SOFORT STOPP", "flee", 146, -42, COLORS.red)
    CombatCommand(immediate, "SAMMELN", "summon", 280, -42, COLORS.blue)
    CombatCommand(immediate, "FOLGEN", "follow", 12, -88, COLORS.green)
    CombatCommand(immediate, "POSITION HALTEN", "stay", 146, -88, COLORS.gold)
    CombatCommand(immediate, "KI RESET", "reset", 280, -88)
    CombatCommand(immediate, "PULL", "pull my target", 12, -134, COLORS.gold, true)
    CombatCommand(immediate, "PULL ZURÜCK", "pull back", 146, -134, COLORS.gold, true)
    CombatCommand(immediate, "GEIST FREI", "release", 280, -134)
    CombatCommand(immediate, "WIEDERBELEBEN", "revive", 12, -180)
    CombatCommand(immediate, "BEREIT", "ready", 146, -180)
    CombatCommand(immediate, "BUFFS", "buff", 280, -180)

    local togglePanel = Section(page, "Kampfstrategien", 442, -48, 180, 236)
    ui.combatChecks = {}
    for index, toggle in ipairs(U.COMBAT_TOGGLES) do
        local toggleDef = toggle
        local check = Check(togglePanel, toggleDef.label, 10, -35 - ((index - 1) * 24), function(enabled)
            UnBot2DB.combat.toggles[toggleDef.id] = enabled
            U.SendCommand(enabled and toggleDef.on or toggleDef.off)
        end)
        check:SetChecked(UnBot2DB.combat.toggles[toggleDef.id] and true or false)
        ui.combatChecks[toggleDef.id] = check
    end

    local form = Section(page, "Formation und Abstand", 8, -295, 614, 205)
    local formations = {
        { "Eng", "formation near" }, { "Reihe", "formation queue" }, { "Linie", "formation line" },
        { "Kreis", "formation circle" }, { "Schild", "formation shield" }, { "Locker", "formation chaos" },
    }
    for index, action in ipairs(formations) do
        local actionDef = action
        local col = (index - 1) % 3; local row = math.floor((index - 1) / 3)
        Button(form, actionDef[1], 12 + (col * 128), -40 - (row * 35), 118, 27, function() U.SendGroup(actionDef[2]) end, nil, actionDef[2])
    end
    local distanceLabel = Label(form, "Abstand zwischen Bots:", "GameFontNormal", 12, -121)
    distanceLabel:SetWidth(150)
    local distance = EditBox(form, 166, -116, 54, "8")
    Button(form, "Abstand setzen", 230, -116, 112, 25, function()
        local value = tonumber(distance:GetText())
        if not value or value < 1 or value > 30 then U.Print("Abstand muss zwischen 1 und 30 Metern liegen.", true); return end
        U.SendGroup("disperse set " .. value)
    end)
    Button(form, "Zurücksetzen", 350, -116, 100, 25, function() U.SendGroup("disperse disable") end)
    Label(form, "Pull-Befehle werden an den gewählten Zielbot gesendet; alle anderen Aktionen beachten das Befehlsziel.", "GameFontNormalSmall", 12, -163):SetTextColor(0.72, 0.78, 0.86)
end

local function CreateTactics()
    local page = Page("TACTIC")
    Label(page, "Taktik und Rollen", "GameFontNormalHuge", 8, -8)
    local rolePanel = Section(page, "Rolle auf Zielbot anwenden", 8, -48, 300, 215)
    Label(rolePanel, "Zielbot:", "GameFontNormal", 12, -42)
    ui.tacticBot = Dropdown(rolePanel, 70, -36, 160, function() return BotItems(false) end, function(value) U.SetSelectedBot(value) end)
    ui.tacticBot:SetValue("", "Bot auswählen")
    local roleButtons = { { "Tank", "TANK" }, { "Heiler", "HEAL" }, { "Nahkampf-DD", "MELEE" }, { "Fernkampf-DD", "RANGED" } }
    for index, item in ipairs(roleButtons) do
        local itemDef = item
        Button(rolePanel, itemDef[1], 12 + (((index - 1) % 2) * 134), -78 - (math.floor((index - 1) / 2) * 36), 124, 28, function() U.ApplyRole(U.runtime.selectedBot, itemDef[2]) end, U.ROLES[itemDef[2]].command)
    end
    Button(rolePanel, "Strategien abfragen", 12, -155, 124, 28, function() U.SendBot(U.runtime.selectedBot, "co ?") end, nil, "co ?")
    Button(rolePanel, "Spec abfragen", 146, -155, 124, 28, function() U.SendBot(U.runtime.selectedBot, "talents") end, nil, "talents")

    local behavior = Section(page, "Verhalten außerhalb des Kampfes", 320, -48, 302, 215)
    local behaviors = {
        { "Folgen", "nc +follow,-stay" }, { "Warten", "nc +stay,-follow" }, { "Looten", "nc +loot" },
        { "Nicht looten", "nc -loot" }, { "Grinden", "nc +grind" }, { "Nicht grinden", "nc -grind" },
        { "RPG/Questen", "nc +new rpg,+grind,-follow" }, { "Zurücksetzen", "nc !" },
    }
    for index, item in ipairs(behaviors) do
        local itemDef = item
        local col = (index - 1) % 2; local row = math.floor((index - 1) / 2)
        Button(behavior, itemDef[1], 12 + (col * 139), -41 - (row * 36), 130, 28, function() U.SendCommand(itemDef[2]) end, nil, itemDef[2])
    end

    local raid = Section(page, "Instanz- und Raidstrategien", 8, -274, 614, 226)
    local raids = {
        { "Geschmolzener Kern", "moltencore" }, { "Pechschwingenhort", "bwl" },
        { "Ahn'Qiraj-Ruinen", "aq20" }, { "Karazhan", "karazhan" },
        { "Gruuls Unterschlupf", "gruulslair" }, { "Magtheridons Kammer", "magtheridon" },
        { "Schlangenschrein", "ssc" }, { "Archavons Kammer", "voa" },
        { "Naxxramas", "naxx" }, { "Obsidiansanktum", "wotlk-os" },
        { "Auge der Ewigkeit", "wotlk-eoe" }, { "Ulduar", "ulduar" },
        { "Onyxias Hort", "onyxia" }, { "Eiskronenzitadelle", "icc" },
    }
    for index, strategy in ipairs(raids) do
        local strategyDef = strategy
        local col = (index - 1) % 4; local row = math.floor((index - 1) / 4)
        Button(raid, strategyDef[1], 12 + (col * 147), -40 - (row * 37), 138, 28,
            function() U.SendGroup("co +" .. strategyDef[2]) end, nil, "co +" .. strategyDef[2])
    end
end

local function CreateAdventure()
    local page = Page("ADVENTURE")
    Label(page, "Abenteuer und Quests", "GameFontNormalHuge", 8, -8)
    local panels = {
        { "Bewegung", { { "Folgen", "follow" }, { "Warten", "stay" }, { "Sammeln", "summon" }, { "Fliehen", "flee" }, { "Zuhause setzen", "home" }, { "Gruppe verlassen", "leave" } } },
        { "Quests", { { "Questübersicht", "quests" }, { "Alle Quests", "quests all" }, { "Alle annehmen", "accept *" }, { "NPC ansprechen", "talk" }, { "Questbelohnung", "r" }, { "Objekte sehen", "los" } } },
        { "Loot und Versorgung", { { "Loot an", "nc +loot" }, { "Loot aus", "nc -loot" }, { "Alles looten", "ll all" }, { "Questloot", "ll quest" }, { "Essen/Trinken", "nc +food" }, { "Buffs", "buff" } } },
    }
    for panelIndex, data in ipairs(panels) do
        local panelData = data
        local panel = Section(page, panelData[1], 8 + ((panelIndex - 1) * 205), -49, 194, 246)
        for index, action in ipairs(panelData[2]) do
            local actionDef = action
            Button(panel, actionDef[1], 12, -41 - ((index - 1) * 34), 170, 27, function() U.SendCommand(actionDef[2]) end, nil, actionDef[2])
        end
    end
    local custom = Section(page, "Eigener Playerbot-Befehl", 8, -306, 604, 154)
    local input = EditBox(custom, 16, -47, 414, "Befehl eingeben")
    Button(custom, "Senden", 448, -45, 140, 27, function()
        local value = input:GetText(); if value == input.placeholder or value == "" then U.Print("Bitte einen Befehl eingeben.", true); return end
        U.SendCommand(value); input:ClearFocus()
    end)
    Label(custom, "Der sichtbare Text ist deutsch. Serverbefehle werden bewusst niemals übersetzt.", "GameFontNormalSmall", 12, -91):SetTextColor(0.65, 0.75, 0.85)
end

function U.CreateDungeonClearPage()
    local page = Page("DUNGEON")
    Label(page, "Dungeon Clear", "GameFontNormalHuge", 8, -8)
    Label(page, "Der Tank-Bot fuehrt die Gruppe selbststaendig durch den Dungeon.", "GameFontNormalSmall", 8, -35):SetTextColor(0.65, 0.75, 0.85)
    local dungeonClear = Section(page, "Steuerung", 8, -61, 614, 142)
    U.ui.dungeonClearPanel = dungeonClear
    Label(dungeonClear, "Der Tank-Bot führt die Gruppe durch den Dungeon. Du spielst als Begleiter.", "GameFontNormalSmall", 12, -35):SetTextColor(0.65, 0.75, 0.85)
    Button(dungeonClear, "Start", 12, -60, 92, 28, function() U.SendDungeonClear("on") end, "Startet den autonomen Dungeonlauf.", "dc on")
    Button(dungeonClear, "Pause", 112, -60, 92, 28, function() U.SendDungeonClear("pause") end, "Pausiert oder setzt den Lauf fort.", "dc pause")
    Button(dungeonClear, "Überspringen", 212, -60, 104, 28, function() U.SendDungeonClear("skip") end, "Überspringt das aktuelle festgefahrene Ziel.", "dc skip")
    Button(dungeonClear, "Stopp", 324, -60, 88, 28, function() U.SendDungeonClear("off") end, "Beendet den Dungeonlauf.", "dc off")
    Button(dungeonClear, "Status", 420, -60, 82, 28, function() U.SendDungeonClear("status") end, "Zeigt das aktuelle Ziel und den Fortschritt.", "dc status")
    Button(dungeonClear, "Bosse", 510, -60, 88, 28, function() U.SendDungeonClear("bosses") end, "Listet die Bosse und ihren Status.", "dc bosses")
    Button(dungeonClear, "Pull-Modus", 12, -96, 112, 27, function() U.SendDungeonClear("pull") end, "Wechselt zwischen Dynamic, Leeroy und Advanced.", "dc pull")
    U.ui.dungeonClearHint = Label(dungeonClear, "Dungeon-Clear-Modul wird geprüft …", "GameFontNormalSmall", 136, -102)
    U.ui.dungeonClearHint:SetTextColor(0.45, 0.72, 1)
    Label(page, "Steuerung wird automatisch aktiv, sobald das Modul in deiner Bot-Gruppe antwortet.", "GameFontNormalSmall", 8, -220):SetTextColor(0.55, 0.65, 0.78)
    dungeonClear:Hide()
    U.ProbeDungeonClear()
end

StaticPopupDialogs["UNBOT2_CONFIRM_DESTROY"] = {
    text = "Soll der Zielbot diesen Gegenstand wirklich zerstören?\n\n%s",
    button1 = YES, button2 = NO, timeout = 0, whileDead = true, hideOnEscape = true,
    OnAccept = function(self, data) if data then U.SendBot(U.runtime.selectedBot, "destroy " .. data) end end,
}

local function CreateGear()
    local page = Page("GEAR")
    Label(page, "Ausrüstung und Versorgung", "GameFontNormalHuge", 8, -8)
    local common = Section(page, "Wartung", 8, -48, 290, 205)
    local actions = { { "Wartung", "maintenance" }, { "Autogear", "autogear" }, { "Upgrades anlegen", "equip upgrade" }, { "Reparieren", "repair" }, { "Inventar", "inventory" }, { "Status", "stats" }, { "Glyphen", "glyphs" }, { "Talente", "talents" } }
    for index, action in ipairs(actions) do
        local actionDef = action
        local col = (index - 1) % 2; local row = math.floor((index - 1) / 2)
        Button(common, actionDef[1], 12 + (col * 134), -41 - (row * 36), 124, 28, function() U.SendBot(U.runtime.selectedBot, actionDef[2]) end, nil, actionDef[2])
    end
    local item = Section(page, "Gegenstand oder Zauber", 310, -48, 312, 205)
    local itemInput = EditBox(item, 12, -43, 286, "Item-ID, Item-Link oder Zauber")
    local itemActions = { { "Benutzen", "use" }, { "Anlegen", "equip" }, { "Verkaufen", "s" }, { "Zerstören", "destroy" }, { "Zauber wirken", "cast" } }
    for index, action in ipairs(itemActions) do
        local actionDef = action
        local col = (index - 1) % 2; local row = math.floor((index - 1) / 2)
        Button(item, actionDef[1], 12 + (col * 145), -82 - (row * 36), 136, 28, function()
            local value = itemInput:GetText()
            if value == itemInput.placeholder or value == "" then U.Print("Bitte zuerst einen Wert eingeben.", true); return end
            if actionDef[2] == "destroy" and UnBot2DB.settings.confirmations then StaticPopup_Show("UNBOT2_CONFIRM_DESTROY", value, nil, value)
            else U.SendBot(U.runtime.selectedBot, actionDef[2] .. " " .. value) end
        end, nil, actionDef[2])
    end
    local loot = Section(page, "Loot-Regeln", 8, -264, 614, 205)
    local lootActions = { { "Alles", "ll all" }, { "Normal", "ll normal" }, { "Grau", "ll gray" }, { "Questgegenstände", "ll quest" }, { "Berufsmaterial", "ll skill" }, { "Graues verkaufen", "s *" }, { "Verkäufliches", "s vendor" }, { "Behälter öffnen", "open items" } }
    for index, action in ipairs(lootActions) do
        local actionDef = action
        local col = (index - 1) % 4; local row = math.floor((index - 1) / 4)
        Button(loot, actionDef[1], 12 + (col * 147), -42 - (row * 38), 138, 29, function() U.SendBot(U.runtime.selectedBot, actionDef[2]) end, nil, actionDef[2])
    end
    Label(loot, "Diese Aktionen betreffen den oben ausgewählten Zielbot.", "GameFontNormalSmall", 12, -133):SetTextColor(0.65, 0.75, 0.85)
end

local function CreateBots()
    local page = Page("BOTS")
    Label(page, "Bots verwalten", "GameFontNormalHuge", 8, -8)
    local add = Section(page, "Neuen Klassenbot hinzufügen", 8, -48, 402, 278)
    local classList = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
    for index, classKey in ipairs(classList) do
        local classData = U.CLASSES[classKey]; local col = (index - 1) % 2; local row = math.floor((index - 1) / 2)
        Button(add, classData.label, 12 + (col * 190), -42 - (row * 40), 180, 31, function() U.SendConsole(".playerbot bot addclass " .. classData.command) end, "Fügt einen verfügbaren " .. classData.label .. "-Bot hinzu.", ".playerbot bot addclass " .. classData.command)
    end
    local manage = Section(page, "Anmelden und initialisieren", 420, -48, 202, 278)
    local management = {
        { "Alle Bots anmelden", function() U.SendConsole(".playerbot bot add *") end },
        { "Alle Bots abmelden", function() U.SendConsole(".playerbot bot remove *") end },
        { "Zielbot anmelden", function() if U.runtime.selectedBot then U.SendConsole(".playerbot bot add " .. U.runtime.selectedBot) else U.Print("Kein Zielbot ausgewählt.", true) end end },
        { "Zielbot abmelden", function() if U.runtime.selectedBot then U.SendConsole(".playerbot bot remove " .. U.runtime.selectedBot) else U.Print("Kein Zielbot ausgewählt.", true) end end },
        { "Zielbot initialisieren", function() if U.runtime.selectedBot then U.SendConsole(".playerbot bot init=auto " .. U.runtime.selectedBot) else U.Print("Kein Zielbot ausgewählt.", true) end end },
        { "Gruppe initialisieren", function() U.SendConsole(".playerbot bot init=auto *") end },
    }
    for index, item in ipairs(management) do
        local itemDef = item
        Button(manage, itemDef[1], 12, -42 - ((index - 1) * 38), 178, 30, itemDef[2])
    end
    local info = Section(page, "Bot-Informationen", 8, -337, 614, 160)
    local infoActions = { { "Wer / Spec", "who" }, { "Talente", "talents" }, { "Zauber", "spells" }, { "Berufe", "who" }, { "Ruf", "reputation" }, { "PvP-Status", "pvp stats" }, { "Angreifer", "attackers" }, { "Hilfe", "help" } }
    for index, action in ipairs(infoActions) do
        local actionDef = action
        local col = (index - 1) % 4; local row = math.floor((index - 1) / 4)
        Button(info, actionDef[1], 12 + (col * 147), -42 - (row * 38), 138, 29, function() U.SendBot(U.runtime.selectedBot, actionDef[2]) end, nil, actionDef[2])
    end
end

function U.RefreshDiagnostics()
    if not ui.diagRows[1] then return end
    for index, row in ipairs(ui.diagRows) do
        local entry = U.runtime.log[index]
        row:SetText(entry and ((entry.error and "|cffff6666" or "|cffb8dfff") .. entry.time .. "  " .. entry.text .. "|r") or "")
    end
end

local function CreateSettings()
    local page = Page("SETTINGS")
    Label(page, "Einstellungen und Diagnose", "GameFontNormalHuge", 8, -8)
    local settings = Section(page, "Bedienung", 8, -48, 294, 222)
    local feedback = Check(settings, "Befehle im Chat bestätigen", 12, -42, function(value) UnBot2DB.settings.chatFeedback = value end)
    feedback:SetChecked(UnBot2DB.settings.chatFeedback)
    local confirm = Check(settings, "Zerstören immer bestätigen", 12, -75, function(value) UnBot2DB.settings.confirmations = value end)
    confirm:SetChecked(UnBot2DB.settings.confirmations)
    local bridge = Check(settings, "Server-Brücke verwenden", 12, -108, function(value) UnBot2DB.settings.bridge = value; if value then U.RequestBridgeHandshake() end end)
    bridge:SetChecked(UnBot2DB.settings.bridge)
    local minimap = Check(settings, "Minimap-Symbol ausblenden", 12, -141, function(value)
        UnBot2DB.minimap.hidden = value; if ui.minimap then SetVisible(ui.minimap, not value) end
    end)
    minimap:SetChecked(UnBot2DB.minimap.hidden)
    Button(settings, "Fenster zentrieren", 12, -176, 128, 27, function() ui.frame:ClearAllPoints(); ui.frame:SetPoint("CENTER") end)
    Button(settings, "Brücke prüfen", 148, -176, 126, 27, function() U.RequestBridgeHandshake(); U.Print("Verbindungsprüfung gesendet.") end)

    local status = Section(page, "Systemstatus", 314, -48, 308, 222)
    Label(status, "Addon-Version", "GameFontNormal", 12, -42); Label(status, U.VERSION, "GameFontHighlight", 176, -42)
    Label(status, "Betriebsart", "GameFontNormal", 12, -70); ui.settingsMode = Label(status, "Chatmodus", "GameFontHighlight", 176, -70)
    Label(status, "Gruppenmitglieder", "GameFontNormal", 12, -98); ui.settingsRoster = Label(status, "0", "GameFontHighlight", 176, -98)
    Label(status, "Aktiver Zielbot", "GameFontNormal", 12, -126); ui.settingsBot = Label(status, "Keiner", "GameFontHighlight", 176, -126)
    Label(status, "Slash-Befehle", "GameFontNormal", 12, -154); Label(status, "/squadcontrol, /unbot, /ub", "GameFontHighlight", 176, -154)
    Label(status, GetLocale and GetLocale() == "deDE" and "GitHub-Repository" or "GitHub repository", "GameFontNormal", 12, -181)
    local repository = EditBox(status, 12, -205, 280, "")
    repository:SetText("https://github.com/dandulox/SquadControl")
    repository:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    repository:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

    local diag = Section(page, "Letzte Aktionen", 8, -281, 614, 220)
    for index = 1, 7 do
        local row = Label(diag, "", "GameFontNormalSmall", 12, -38 - ((index - 1) * 23))
        row:SetWidth(585); row:SetJustifyH("LEFT"); table.insert(ui.diagRows, row)
    end
    Button(diag, "Protokoll leeren", 468, -181, 132, 25, function() U.runtime.log = {}; U.RefreshDiagnostics() end)
end

local function SaveWindowPosition()
    local point, _, relativePoint, x, y = ui.frame:GetPoint(1)
    UnBot2DB.window = { point = point, relativePoint = relativePoint, x = x, y = y }
end

local function UpdateMinimapPosition()
    if not ui.minimap then return end
    local angle = UnBot2DB.minimap.angle or 135
    local radians = math.rad(angle)
    local radius = math.max(40, (math.min(Minimap:GetWidth(), Minimap:GetHeight()) / 2) - 5)
    ui.minimap:ClearAllPoints()
    ui.minimap:SetPoint("CENTER", Minimap, "CENTER", math.cos(radians) * radius, math.sin(radians) * radius)
end

local function CreateMinimap()
    local button = CreateFrame("Button", "UnBot2MinimapButton", Minimap)
    button:SetWidth(30); button:SetHeight(30); button:SetFrameStrata("MEDIUM")
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp"); button:RegisterForDrag("LeftButton")
    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetTexture("Interface\\Icons\\INV_Misc_Gear_01"); icon:SetWidth(25); icon:SetHeight(25); icon:SetPoint("CENTER")
    button:SetScript("OnClick", function(_, mouseButton)
        if mouseButton == "RightButton" then U.ShowPage("COMBAT"); ui.frame:Show() else SetVisible(ui.frame, not ui.frame:IsShown()) end
    end)
    button:SetScript("OnDragStart", function(self) self.dragging = true end)
    button:SetScript("OnDragStop", function(self) self.dragging = false end)
    button:SetScript("OnUpdate", function(self)
        if not self.dragging then return end
        local x, y = GetCursorPosition(); local scale = Minimap:GetEffectiveScale(); x, y = x / scale, y / scale
        local centerX, centerY = Minimap:GetCenter()
        UnBot2DB.minimap.angle = math.deg(math.atan2(y - centerY, x - centerX)); UpdateMinimapPosition()
    end)
    button:SetScript("OnEnter", function(self)
        Tooltip(self, "SquadControl", GetLocale and GetLocale() == "deDE" and "Linksklick: Zentrale öffnen\nRechtsklick: Kampfzentrale\nZiehen: Symbol verschieben" or "Left click: Open control panel\nRight click: Open combat panel\nDrag: Move button")
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    ui.minimap = button; UpdateMinimapPosition(); SetVisible(button, not UnBot2DB.minimap.hidden)
end

function U.RefreshAll()
    U.RefreshHeader(); U.RefreshRoster(); U.RefreshBuilder(); U.RefreshDiagnostics()
    if ui.settingsMode then ui.settingsMode:SetText(U.runtime.bridge and "|cff55dd77Server-Brücke|r" or "|cffffcc55Chatmodus|r") end
    if ui.settingsRoster then ui.settingsRoster:SetText(tostring(#U.GetRoster())) end
    if ui.settingsBot then ui.settingsBot:SetText(U.runtime.selectedBot or "Keiner") end
end

function U.CreateUI()
    if ui.frame then return end
    local frame = CreateFrame("Frame", "UnBot2MainFrame", UIParent)
    frame:SetWidth(820); frame:SetHeight(590); frame:SetFrameStrata("HIGH"); frame:SetClampedToScreen(true)
    frame:SetMovable(true); frame:EnableMouse(true); frame:RegisterForDrag("LeftButton")
    local win = UnBot2DB.window
    frame:SetPoint(win.point or "CENTER", UIParent, win.relativePoint or "CENTER", win.x or 0, win.y or 0)
    frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); SaveWindowPosition() end)
    Backdrop(frame, false); ui.frame = frame

    local title = Label(frame, "SquadControl", "GameFontNormalHuge", 18, -14)
    title:SetTextColor(unpack(COLORS.blue))
    Label(frame, "AzerothCore Playerbot Control", "GameFontNormalSmall", 20, -41):SetTextColor(0.64, 0.75, 0.86)
    ui.groupStatus = Label(frame, "Gruppe: 0/5 Bots", "GameFontNormal", 190, -19)
    ui.targetStatus = Label(frame, "Zielbot: Keiner", "GameFontNormal", 340, -19)
    ui.connection = Label(frame, "|cffffcc55● Chatmodus|r", "GameFontNormal", 545, -19)
    Button(frame, "×", 782, -9, 26, 24, function() frame:Hide() end)

    local nav = CreateFrame("Frame", nil, frame)
    nav:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -67); nav:SetWidth(158); nav:SetHeight(510); Backdrop(nav, true)
    local navScroll = CreateFrame("ScrollFrame", "UnBot2NavScroll", nav, "UIPanelScrollFrameTemplate")
    navScroll:SetPoint("TOPLEFT", nav, "TOPLEFT", 5, -7); navScroll:SetWidth(143); navScroll:SetHeight(496)
    navScroll:EnableMouseWheel(true)
    navScroll:SetScript("OnMouseWheel", function(self, delta)
        local nextScroll = math.max(0, math.min(self:GetVerticalScrollRange(), self:GetVerticalScroll() - (delta * 48)))
        self:SetVerticalScroll(nextScroll)
    end)
    local navContent = CreateFrame("Frame", nil, navScroll)
    navContent:SetWidth(126); navContent:SetHeight(math.max(486, (#PAGE_DEFS * 58) + 10))
    navScroll:SetScrollChild(navContent)
    for index, def in ipairs(PAGE_DEFS) do
        local button = CreateFrame("Button", nil, navContent)
        button:SetPoint("TOPLEFT", navContent, "TOPLEFT", 4, -4 - ((index - 1) * 58)); button:SetWidth(118); button:SetHeight(50)
        button.bg = button:CreateTexture(nil, "BACKGROUND"); button.bg:SetAllPoints(); button.bg:SetTexture(0.08, 0.14, 0.20, 0.82)
        button.icon = button:CreateTexture(nil, "ARTWORK"); button.icon:SetTexture(def.icon); button.icon:SetWidth(28); button.icon:SetHeight(28); button.icon:SetPoint("LEFT", 8, 0)
        button.text = Label(button, def.label, "GameFontNormal", 44, 0, "LEFT"); button.text:ClearAllPoints(); button.text:SetPoint("LEFT", button, "LEFT", 44, 0)
        local pageId = def.id
        button:SetScript("OnClick", function() U.ShowPage(pageId) end)
        button:SetScript("OnEnter", function(self) self.bg:SetTexture(0.12, 0.28, 0.40, 1) end)
        button:SetScript("OnLeave", function(self) self.bg:SetTexture(0.08, 0.14, 0.20, 0.82) end)
        ui.nav[def.id] = button
    end

    ui.content = CreateFrame("Frame", nil, frame)
    ui.content:SetPoint("TOPLEFT", frame, "TOPLEFT", 178, -67); ui.content:SetWidth(632); ui.content:SetHeight(510)
    for _, def in ipairs(PAGE_DEFS) do Page(def.id) end
    U.ShowPage("OVERVIEW")
    SafeCreatePage("OVERVIEW", "Übersicht", CreateOverview)
    SafeCreatePage("GROUP", "Gruppe", CreateGroupBuilder)
    SafeCreatePage("COMBAT", "Kampf", CreateCombat)
    SafeCreatePage("TACTIC", "Taktik", CreateTactics)
    SafeCreatePage("ADVENTURE", "Abenteuer", CreateAdventure)
    SafeCreatePage("GEAR", "Ausrüstung", CreateGear)
    SafeCreatePage("DUNGEON", "Dungeon", U.CreateDungeonClearPage)
    SafeCreatePage("BOTS", "Bots", CreateBots)
    SafeCreatePage("SETTINGS", "Einstellungen", CreateSettings)
    local compactOk, compactError = pcall(CreateCompactCombat)
    if not compactOk then U.Print("Kampfleiste konnte nicht geladen werden: " .. tostring(compactError), true) end
    local minimapOk, minimapError = pcall(CreateMinimap)
    if not minimapOk then U.Print("Minimap-Symbol konnte nicht geladen werden: " .. tostring(minimapError), true) end
    local refreshOk, refreshError = pcall(U.RefreshAll)
    if not refreshOk then U.Print("Ansichten konnten nicht aktualisiert werden: " .. tostring(refreshError), true) end
    frame:Hide()
end

SLASH_UNBOT21 = "/unbot"
SLASH_UNBOT22 = "/ub"
SLASH_UNBOT23 = "/playerbots"
SLASH_UNBOT24 = "/squadcontrol"
SlashCmdList["UNBOT2"] = function(message)
    message = message and string.lower(strtrim(message)) or ""
    if not ui.frame then U.CreateUI() end
    if message == "combat" or message == "kampf" then U.ShowPage("COMBAT"); ui.frame:Show()
    elseif message == "group" or message == "gruppe" then U.ShowPage("GROUP"); ui.frame:Show()
    elseif message == "bar" then SetVisible(ui.compactCombat, not ui.compactCombat:IsShown())
    else SetVisible(ui.frame, not ui.frame:IsShown()) end
end

UNBOT2_MAIN_OK = true

local name, methods = ...

-- Cut string in half at the first blankspace
function methods:SlashFormat(msg)
    msg = string.lower(msg)

    if not string.find(msg, " ") then
        return msg
    end

    -- return msg, param
    return select(3, string.find(msg, "^([^ ]+) (.+)$"))
end

-- Setup slash command for resetting variables and position
function methods.SlashHandler(msg, editbox)
    msg, param = methods:SlashFormat(msg)

    if msg == 'help' then
        print(name .. ": Usages /qi help");
    elseif msg == 'reset' then
        print(methods.title .. "Settings resetted")
        qvars = {}
    else
        print(name .. ": Usages /qi help");
    end
end

SlashCmdList["qImmunityClock"] = methods.SlashHandler;
SLASH_QIMMINITYCLOCK1 = '/qia'

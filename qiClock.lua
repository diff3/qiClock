local name, methods = ...

function methods:debugMSG(msg)
    if qvars['debug'] then
        print(msg)
    end
end

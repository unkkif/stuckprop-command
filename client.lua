
function EnumerateObjects()
    return coroutine.wrap(function()
        local handle, object = FindFirstObject()
        if not handle or handle == -1 then
            EndFindObject(handle)
            return
        end

        local success
        repeat
            coroutine.yield(object)
            success, object = FindNextObject(handle)
        until not success

        EndFindObject(handle)
    end)
end

--stuckprop is the command for this script
RegisterCommand("stuckprop", function() 
    local playerPed = PlayerPedId()
    local attachedEntities = {}

    for obj in EnumerateObjects() do
        if IsEntityAttachedToEntity(obj, playerPed) then
            table.insert(attachedEntities, obj)
        end
    end

    for _, entity in ipairs(attachedEntities) do
        DetachEntity(entity, true, true)
        DeleteEntity(entity)
    end
end, false)

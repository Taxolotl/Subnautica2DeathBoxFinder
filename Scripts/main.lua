local UEHelpers = require("UEHelpers")

local GetPlayerController = UEHelpers.GetPlayerController

local function get_death_box()
    local DeathBox = FindFirstOf("BP_PlayerDied_Blackbox_Proto_C_2147478634")
    if DeathBox and DeathBox:IsValid() then
        return DeathBox
    end
    return nil
end

RegisterKeyBind(Key.F4, function()
    local DeathBox = get_death_box()
    if DeathBox == nil then
        return
    end
    local DeathBoxLoc = DeathBox:K2_GetActorLocation()

    local Pawn = GetPlayerController().Pawn
    if Pawn == nil then
        return
    end
    local PlayerControllerLoc = Pawn:K2_GetActorLocation()
    local PlayerControllerRot = Pawn:K2_GetActorRotation()

    local dx = DeathBoxLoc.X - PlayerControllerLoc.X
    local dy = DeathBoxLoc.Y - PlayerControllerLoc.Y
    local angle = math.deg(math.atan(dx, -dy))

    if angle < 0 then
        angle = angle + 360
    end

    print(angle)
    print(PlayerControllerLoc.X - DeathBoxLoc.X, PlayerControllerLoc.Y - DeathBoxLoc.Y, PlayerControllerLoc.Z - DeathBoxLoc.Z)
end)

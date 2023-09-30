local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )

if player_id ~= 0 then

    local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")

    --Disables Suffocatium if target has Breathless
	if (GameGetGameEffectCount( player_id, "BREATH_UNDERWATER" ) >= 1 or ComponentGetValue2(dmgcomp, "air_needed") == false) and (EntityHasTag(player_id,"vulnerable") ~= true) then
        ComponentSetValue2(dmgcomp,"air_in_lungs",ComponentGetValue2(dmgcomp,"air_in_lungs_max"))
    return end

    local air = ComponentGetValue2(dmgcomp, "air_in_lungs")

    --Drain air slower if user has breathless effect
    if air > 0.1 then
        --if GameGetGameEffectCount( player_id, "BREATH_UNDERWATER" ) > 0 then
        --    ComponentSetValue2(dmgcomp,"air_in_lungs",air - 0.03)
        --else
            ComponentSetValue2(dmgcomp,"air_in_lungs",air - 0.1)
        --end
    end

    if EntityHasTag(player_id,"player_unit") and air < 0.11 then
        EntityInflictDamage( player_id, 0.012, "DAMAGE_CURSE", "$damage_drowning", "NONE", 0, 0, 0 )
        ComponentSetValue2(dmgcomp,"air_in_lungs",0.1)
    end

end
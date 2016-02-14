
function GetTexture(tex_name)
	if type(tex_name)~="string" then
		return nil
	end
	local tex_dir = ResMgr:getFullRootSceneMediaDir( res.ESMT_TEXTURES )
	return Driver:getTexture(string.format("%s%s",tex_dir, tex_name))	
end

-----------------------------------------

function GetSoundTrack(track_name)
	if type(track_name)~="string" then
		return nil
	end
	local track_dir = ResMgr:getFullSoundMediaDir( res.ESMT_SOUND_TRACKS )
	return SoundDrv:getSound(string.format("%s%s",track_dir, track_name), false)	
end

-----------------------------------------

function GetSoundEffect(eff_name)
	if type(eff_name)~="string" then
		return nil
	end
	local eff_dir = ResMgr:getFullSoundMediaDir( res.ESMT_SOUND_EFFECTS )
	return SoundDrv:getSound(string.format("%s%s",eff_dir, eff_name), false)	
end

-----------------------------------------

function LoadGameOptions(options_file_name)

	local file = io.open (options_file_name, "r")

	if file==nil then

	    -- use default options

	    -- setting monitor brightness ( 0.5 - 3.0 )
	    OSOp:setMonitorBrightness(1.0)

	    -- setting sound tracks volume (0.0 - 1.0) 
	    GameMgr:setSoundTracksVolume(0.45)

	    -- setting sound effects volume (0.0 - 1.0)
	    GameMgr:setSoundEffectsVolume(0.45)

	    -- setting mouse cursor default sensitivity
	    Cursor:setSensitivity(0.5)

	    -- setting up game controls (keyboard and mouse)

	    InpDisp:mapKey(io.EKC_D,             game.EGA_MOVE_RIGHT_STRAFE )
	    InpDisp:mapKey(io.EKC_S,             game.EGA_MOVE_BACKWARD     ) 
	    InpDisp:mapKey(io.EKC_W,             game.EGA_MOVE_FORWARD      ) 
	    InpDisp:mapKey(io.EKC_A,             game.EGA_MOVE_LEFT_STRAFE  ) 
	    InpDisp:mapKey(io.EKC_ADD,           game.EGA_VIEW_ZOOM_IN      ) 
	    InpDisp:mapKey(io.EKC_MINUS,         game.EGA_VIEW_ZOOM_OUT     ) 
	    InpDisp:mapKey(io.EKC_LBRACKET,      game.EGA_SELECT_PREV_WEAPON)
	    InpDisp:mapKey(io.EKC_RBRACKET,      game.EGA_SELECT_NEXT_WEAPON)
	    InpDisp:mapKey(io.EKC_1,             game.EGA_SELECT_WEAPON_0   )
	    InpDisp:mapKey(io.EKC_2,             game.EGA_SELECT_WEAPON_1   ) 
	    InpDisp:mapKey(io.EKC_3,             game.EGA_SELECT_WEAPON_2   )
	    InpDisp:mapKey(io.EKC_4,             game.EGA_SELECT_WEAPON_3   )
	    InpDisp:mapKey(io.EKC_5,             game.EGA_SELECT_WEAPON_4   )
	    InpDisp:mapKey(io.EKC_6,             game.EGA_SELECT_WEAPON_5   )
	    InpDisp:mapKey(io.EKC_7,             game.EGA_SELECT_WEAPON_6   )
	    InpDisp:mapKey(io.EKC_8,             game.EGA_SELECT_WEAPON_7   )
	    InpDisp:mapKey(io.EKC_9,             game.EGA_SELECT_WEAPON_8   )
	    InpDisp:mapKey(io.EKC_0,             game.EGA_SELECT_WEAPON_9   )

	    InpDisp:mapMouse(io.EMC_LMOUSE,      game.EGA_ATTACK_PRIMARY    )   
	    InpDisp:mapMouse(io.EMC_RMOUSE,      game.EGA_ATTACK_SECONDARY  )
	    InpDisp:mapMouse(io.EMC_MWHEEL_UP,   game.EGA_SELECT_PREV_WEAPON)
	    InpDisp:mapMouse(io.EMC_MWHEEL_DOWN, game.EGA_SELECT_NEXT_WEAPON)

	else

	    -- load options from file

	    local i = 0
	    local g = 0

	    for line in file:lines() do 

	        if i==0 then    

	            local bright_val = tonumber(line)   
	            -- setting monitor brightness ( 0.5 - 3.0 )
	            OSOp:setMonitorBrightness(bright_val)

	        elseif i==1 then    

	            local mus_vol = tonumber(line)
	            -- setting music volume (0.0 - 1.0)
	            GameMgr:setSoundTracksVolume(mus_vol)

	        elseif i==2 then

	            local snd_vol = tonumber(line)
	            -- setting effects volume (0.0 - 1.0)
	            GameMgr:setSoundEffectsVolume(snd_vol)

	        elseif i==3 then

	            local sens_val = tonumber(line)
	            -- setting sensitivity value (0.0 - 1.0)
	            Cursor:setSensitivity(sens_val)

	        elseif g<game.E_GAME_ACTION_COUNT then

	            -- setting game controls
	            local token = {}
	            local to = 0        
	            local t = 0
	            while (t<3) do          
	                from = to+1
	                to = string.find(line, ";", to+1);
	                if to==nil then
	                    break
	                end
	                token[t] = string.sub(line, from, to-1)         
	                t = t + 1                       
	            end     
	            if t==3  then
	                local kcode = tonumber(token[1])
	                local mcode = tonumber(token[2])            
	                if kcode>=0 and kcode<io.E_KEY_CODE_COUNT then
	                    InpDisp:mapKey(kcode, g)
	                end
	                if mcode>=0 and mcode<io.E_MOUSE_CODE_COUNT then
	                    InpDisp:mapMouse(mcode, g)
	                end                     
	            end 
	            g = g + 1
	        elseif i==(4+game.E_GAME_ACTION_COUNT) then
	            CameraStyle = tonumber(line)
	        elseif i==(5+game.E_GAME_ACTION_COUNT) then
				if tonumber(line)==1 then
					CameraAutoZoom = true
				else
					CameraAutoZoom = false
				end
	        end

	        i = i + 1   
	    end

	    file:close()
	end
end

-----------------------------------------

function SaveGameOptions(options_file_name)
	
	local file = io.open (tableOPTIONS.GameOptionsFileName, "w")

    if file~=nil then    

        local bright_val = OSOp:getMonitorBrightness()
        local mus_vol    = GameMgr:getSoundTracksVolume()
        local eff_vol    = GameMgr:getSoundEffectsVolume()
        local sens_val   = Cursor:getSensitivity()

        file:write(string.format("%.2f\n",bright_val))
        file:write(string.format("%.2f\n",mus_vol))
        file:write(string.format("%.2f\n",eff_vol))
        file:write(string.format("%.2f\n",sens_val))
        
        for i=0, game.E_GAME_ACTION_COUNT-1 do              
            local kcode = InpDisp:getActionKey(i)
            local mcode = InpDisp:getActionMouse(i)
            file:write(string.format("%d;%d;%d;\n",i,kcode,mcode))
        end   

        file:write(string.format("%d\n",CameraStyle))

        if CameraAutoZoom then
            file:write(string.format("%d\n",1))
        else
            file:write(string.format("%d\n",0))
        end

        file:close()

    end
	
end

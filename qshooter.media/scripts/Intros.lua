
function PlayMovie(table_frames, sound_track_file_name, sound_offset_ms, fadeout_time_ms)
	
	if type(table_frames)~="table" then
		return
	end	
	
	if type(sound_track_file_name)~="string" then
		return
	end	
	
	local sound_track = GetSoundEffect(sound_track_file_name)
	
	if sound_track==nil then
		return
	end	

	local mouse_input_flag = {}
	
	-- saving mouse input flags
	for i=0, io.E_MOUSE_INPUT_EVENT_COUNT-1 do
		mouse_input_flag[i] = InpDisp:getMouseInputFilterFlag(i)
	end

	-- setting needed mouse input flags
	InpDisp:setMouseInputFilterFlag(io.EMIE_MOUSE_MOVED, false)	
	InpDisp:setMouseInputFilterFlag(io.EMIE_MOUSE_WHEEL, false)
	
	local movie_time_ms = 0
	
	local table_materials={}
	local materials_count=0
	
	-- loading textures
	for key, value in table_frames do	
	
		local tex_name= value.TEX_NAME
		local time_ms = value.TIME_MS		
		local tex = GetTexture(tex_name)

		if tex==nil then
			return
		end			
		
		movie_time_ms = movie_time_ms + time_ms
		
		table_frames[key].TIME_MS = movie_time_ms
		table_materials[key] = vid.SMaterial()	
		
		local pass = table_materials[key]:getPass(0)		
		pass.Layers[0]:setTexture(tex)
		pass.ZBuffer   = false  
		pass.Lighting  = false
		pass.FogEnable = false
		pass.MipMapOff = true	
		materials_count = materials_count + 1
	
	end
		
	Device:run()	
	
	local snd_vol = GameMgr:getSoundEffectsVolume()
	
	sound_track:setVolume(snd_vol)	

	--  render view port
	
	local scr_vp = Driver:getViewPort() 
	
	local out_vp = core.recti()
	
	out_vp.Left = scr_vp:getCenter().X-320
	out_vp.Top  = scr_vp:getCenter().Y-240
	out_vp.Right  = scr_vp:getCenter().X+320
	out_vp.Bottom = scr_vp:getCenter().Y+240
	
	---------------------------
	-- playing intro movie
	---------------------------
	
	local frame_idx = 1

	local intro_begin_time_ms = Device:getDeviceSystemTime()

	while Device:run() do

		-- getting current time (ms)
		local sys_time_ms = Device:getDeviceSystemTime()
		local delta_time_ms = sys_time_ms-intro_begin_time_ms	

		if delta_time_ms>movie_time_ms or InpDisp:getInputEventsQueueSize()>0 then
			break
		end
		
		if delta_time_ms>=table_frames[frame_idx].TIME_MS then
			frame_idx = frame_idx+1
		end
		
		if delta_time_ms>=sound_offset_ms and sound_track:isPlaying()==false then
			sound_track:play()	
		end
		
		if frame_idx>materials_count then
			break
		end
		
		-- prepare for rendering
		if Driver:beginRendering() then 
			if Driver:beginRendering2D() then  				
				local pass_cnt = table_materials[frame_idx]:getPassesCount()  
				for p=0, pass_cnt-1 do      
					Driver:draw2DImage(table_materials[frame_idx]:getPass(p), out_vp)
				end  
			end			
			Driver:endRendering2D()   
		end
		-- end rendering
		Driver:endRendering()
		
	end
	
	sound_track:stop()

	-------------------------------------
	-- smooth fadeout intro image
	-------------------------------------
	
	intro_begin_time_ms = Device:getDeviceSystemTime()

	if InpDisp:getInputEventsQueueSize()>0 then
		fadeout_time_ms = fadeout_time_ms/2
	end

	while Device:run() do

		-- getting current time (ms)
		local sys_time_ms = Device:getDeviceSystemTime()	
		local delta_time_ms = sys_time_ms-intro_begin_time_ms

		if delta_time_ms>fadeout_time_ms then		
			break
		end
		
		-- prepare for rendering
		if Driver:beginRendering() then 
			if Driver:beginRendering2D() then               
				local pass_cnt = table_materials[materials_count]:getPassesCount()  
				for p=0, pass_cnt-1 do  
					local col = img.SColor(255*delta_time_ms/fadeout_time_ms,0,0,0) 
					Driver:draw2DImage(table_materials[materials_count]:getPass(p), out_vp) 
					Driver:draw2DRectangle(col, scr_vp)
				end  
			end
			Driver:endRendering2D()   
		end
		-- end rendering
		Driver:endRendering()
		
	end		
	
	-- restore mouse input flags
	for key,value in mouse_input_flag do
		InpDisp:setMouseInputFilterFlag(key, value)	
	end

end



-- binding key actions --
--[[
	Each functions are called when a key pressed and gamestate
	points them.
]]

function logoKeyAction(key)
	if controls.check("return", key) then
		gamestate = "title"
		love.graphics.setBackgroundColor( 0, 0, 0)
		love.audio.play(musictitle)
		oldtime = love.timer.getTime()
	end
end

function creditsKeyAction(key)
	if controls.check("return", key) then
		gamestate = "title"
		love.graphics.setBackgroundColor( 0, 0, 0)
		love.audio.play(musictitle)
		oldtime = love.timer.getTime()
	end
end

function titleKeyAction(key)
	if controls.check("return", key) then
		if playerselection ~= 3 then
			if soundenabled then
				love.audio.stop(musictitle)
				if musicno < 4 then
					love.audio.play(music[musicno])
				end
			end
		end
		if playerselection == 1 then
			gamestate = "menu"
		elseif playerselection == 2 then
			gamestate = "multimenu"
		else
			gamestate = "options"
			if soundenabled then
			love.audio.stop(musictitle)
			love.audio.play(musicoptions)
			end
			optionsselection = 1
		end
	elseif controls.check("escape", key) then
		love.event.push("q")
	elseif controls.check("left", key) and playerselection > 1 then
		playerselection = playerselection - 1
	elseif controls.check("right", key) and playerselection < 3 then
		playerselection = playerselection + 1
	end
end

function menuKeyAction(key)
	oldmusicno = musicno
	if controls.check("escape", key) then
		if musicno < 4 then
			love.audio.stop(music[musicno])
		end
		gamestate = "title"
		if soundenabled then
		love.audio.stop(musictitle)
		love.audio.play(musictitle)
		end
	elseif key == "backspace" then
		newhighscores()
	elseif controls.check("return", key) then
		if gameno == 1 then
			gameA_load()
		else
			gameB_load()
		end
	elseif controls.check("left", key) then
		if selection == 2 or selection == 4 or selection == 6 then
			selection = selection - 1
			selectblink = true
			oldtime = love.timer.getTime()
		end
	elseif controls.check("right", key) then
		if selection == 1 or selection == 3 or selection == 5 then
			selection = selection + 1
			selectblink = true
			oldtime = love.timer.getTime()
		end
	elseif controls.check("up", key) then
		if selection == 3 or selection == 4 or selection == 5 or selection == 6 then
			selection = selection - 2
			selectblink = true
			oldtime = love.timer.getTime()
			if selection < 3 then
				selection = gameno
				selectblink = false
				oldtime = love.timer.getTime()
			end
		elseif selection == 1 or selection == 2 then
			selection = musicno + 2
			selectblink = false
			oldtime = love.timer.getTime()
		end
	elseif controls.check("down", key) then
		if selection == 1 or selection == 2 or selection == 3 or selection == 4 then
			selection = selection + 2
			selectblink = true
			oldtime = love.timer.getTime()
			if selection > 2 and selection < 5 then
				selection = musicno + 2
				selectblink = false
				oldtime = love.timer.getTime()
			end
		elseif selection == 5 or selection == 6 then
			selection = gameno
			selectblink = false
			oldtime = love.timer.getTime()
		end
	end
	if selection > 2 and not controls.check("escape", key) then
		musicno = selection - 2
		if oldmusicno ~= musicno and oldmusicno ~= 4 then
			love.audio.stop(music[oldmusicno])
		end
		if musicno < 4 then
			love.audio.play(music[musicno])
		end
	elseif not controls.check("escape", key) then
		gameno = selection
		loadhighscores()
	end
end

function optionKeyAction(key)
	if controls.check("escape", key) then
		if soundenabled then
			love.audio.stop(musicoptions)
			love.audio.stop(musictitle)
			love.audio.play(musictitle)
		end
		saveoptions()
		loadimages()
		gamestate = "title"
	elseif controls.check("down", key) then
		optionsselection = optionsselection + 1
		if optionsselection > #optionschoices then
			optionsselection = 1
		end
		selectblink = true
		oldtime = love.timer.getTime()
		
	elseif controls.check("up", key) then
		optionsselection = optionsselection - 1
		if optionsselection == 0 then
			optionsselection = #optionschoices
		end
		selectblink = true
		oldtime = love.timer.getTime()
			
	elseif controls.check("left", key) then
		if optionsselection == 1 then
			if volume >= 0.1 then
				volume = volume - 0.1
				if volume < 0.1 then
					volume = 0
				end
				changevolume(volume)
			end
				
		elseif optionsselection == 3 then
			if fullscreen == false then
				if scale > 1 then
					scale = scale - 1
					changescale(scale)
				end
			end
				
		elseif optionsselection == 4 then
			if fullscreen == false then
				togglefullscreen(true)
			end
			
		end
			
	elseif controls.check("right", key) then
		if optionsselection == 1 then
			if volume <= 0.9 then
				volume = volume + 0.1
				changevolume(volume)
			end
				
		elseif optionsselection == 3 then
			if fullscreen == false then
				if scale < maxscale then
					scale = scale + 1
					changescale(scale)
				end
			end
				
		elseif optionsselection == 4 then
			if fullscreen == true then
				togglefullscreen(false)
			end
				
		end
			
	elseif controls.check("return", key) then
		if optionsselection == 1 then
			volume = 1
			changevolume(volume)
		elseif optionsselection == 2 then
			hue = 0.08
			optionsmenu = newPaddedImage("graphics/options.png");optionsmenu:setFilter( "nearest", "nearest" )
			volumeslider = newPaddedImage("graphics/volumeslider.png");volumeslider:setFilter( "nearest", "nearest" )
		elseif optionsselection == 3 then
			if fullscreen == false then
				if scale ~= suggestedscale then
					scale = suggestedscale
					changescale(scale)
				end
			end
		elseif optionsselection == 4 then
			if fullscreen == true then
				togglefullscreen(false)
			end
		end
			
	end
end

function multimenuKeyAction(key)
	oldmusicno = musicno
	if controls.check("escape", key) then
		if musicno < 4 then
			love.audio.stop(music[musicno])
		end
		gamestate = "title"
		love.audio.stop(musictitle)
		love.audio.play(musictitle)
	elseif controls.check("return", key) then
		gameBmulti_load()
	elseif controls.check("left", key) then
		if selection == 2 or selection == 4 or selection == 6 then
			selection = selection - 1
			selectblink = true
			oldtime = love.timer.getTime()
		end
	elseif controls.check("right", key) then
		if selection == 1 or selection == 3 or selection == 5 then
			selection = selection + 1
			selectblink = true
			oldtime = love.timer.getTime()
		end
	elseif controls.check("up", key) then
		if selection == 3 or selection == 4 or selection == 5 or selection == 6 then
			selection = selection - 2
			selectblink = true
			oldtime = love.timer.getTime()
			if selection < 3 then
				selection = gameno
				selectblink = false
				oldtime = love.timer.getTime()
			end
		elseif selection == 1 or selection == 2 then
			selection = musicno + 2
			selectblink = false
			oldtime = love.timer.getTime()
		end
	elseif controls.check("down", key) then
		if selection == 1 or selection == 2 or selection == 3 or selection == 4 then
			selection = selection + 2
			selectblink = true
			oldtime = love.timer.getTime()
			if selection > 2 and selection < 5 then
				selection = musicno + 2
				selectblink = false
				oldtime = love.timer.getTime()
			end
		elseif selection == 5 or selection == 6 then
			selection = gameno
			selectblink = false
			oldtime = love.timer.getTime()
		end
	end
	
	if selection > 2 and not controls.check("return", key) and not controls.check("escape", key) then
		musicno = selection - 2
		if oldmusicno ~= musicno and oldmusicno ~= 4 then
			love.audio.stop(music[oldmusicno])
		end
		if musicno < 4 then
			love.audio.play(music[musicno])
		end
	elseif not controls.check("return", key) and not controls.check("escape", key) then
		gameno = selection
		loadhighscores()
	end	
end

-- TODO: config controls of gameA
function gameAKeyAction(key)
	if controls.check("return", key) then
		pause = not pause

		if pause == true then
			if musicno < 4 then
				love.audio.pause(music[musicno])
			end
			love.audio.stop(pausesound)
			love.audio.play(pausesound)
		else
			if musicno < 4 then
				love.audio.resume(music[musicno])
			end
		end
	elseif controls.check("escape", key) then
		oldtime = love.timer.getTime()
		gamestate = "menu"
	end
	
	if pause == false and cuttingtimer == lineclearduration then
		-- if key == "up" then --STOP ROTATION OF BLOCK (makes it too easy..)
		--	tetribodies[counter]:setAngularVelocity(0)
		-- end
		if controls.check("left", key) or controls.check("right", key) then
			love.audio.stop(blockmove)
			love.audio.play(blockmove)
		elseif controls.check("rotateleft", key) or controls.check("rotateright", key) then
			love.audio.stop(blockturn)
			love.audio.play(blockturn)
		end
	end
end

function gameBKeyAction(key)
	if controls.check("return", key) then
			pause = not pause

			if pause == true then
				if musicno < 4 then
					love.audio.pause(music[musicno])
				end
				love.audio.stop(pausesound)
				love.audio.play(pausesound)
			else
				if musicno < 4 then
					love.audio.resume(music[musicno])
				end
			end
	elseif controls.check("escape", key) then
		oldtime = love.timer.getTime()
		gamestate = "menu"
	end
	
	if pause == false  then
		--if key == "up" then --STOP ROTATION OF BLOCK (makes it too easy..)
		--	tetribodies[counter]:setAngularVelocity(0)
		--end
		if controls.check("left", key) or controls.check("right", key) then
			love.audio.stop(blockmove)
			love.audio.play(blockmove)
		elseif controls.check("rotateleft", key) or controls.check("rotateright", key) then
			love.audio.stop(blockturn)
			love.audio.play(blockturn)
		end
	end
		
end

function failingKeyAction(key)
	if controls.check("return", key) then
		pause = not pause

		if pause == true then
			if musicno < 4 then
				love.audio.pause(music[musicno])
			end
			love.audio.stop(pausesound)
			love.audio.play(pausesound)
		else
			if musicno < 4 then
				love.audio.resume(music[musicno])
			end
		end
	end
end
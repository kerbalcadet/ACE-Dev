--Table Main concept. function for all sounds needs to be function ACE_Sound(HitPos ,Energy ,HitWorld ,HitWater, Type). This will cover:
	--Explosions
	--Penetrations
	--Ricochets
	--Impacts (if added)
--Where:
	--Hitpos: The pos where effect was created
	--Energy: Common value to be used to calculate pitch/volume. Each effect has different values to calculate this
	--HitWorld: Boolean if the effect hit world
	--HitWater: Boolean if the effect hit water
	--Type: Type of effect. Here will define if its a blast, penetration, etc....
--Due to different values, a GunFire sound function will be required by separated, as caliber is required there.
	--Rack Missile need this another function too. Since they are weapons as guns
--This concept must be stored in the same way as rest of shared files if used manually. Otherwise, using a file discovery system is better

ACE.Sounds = ACE.Sounds or {}

--Insert all the tables
local TableTypes = {
	{ Type = "Blasts", 			Path = "explosions/ambient", 			Category = { "tiny","small","medium","large","huge"}, 	Distance = { "close", "mid", "far"}	},
	{ Type = "Penetrations", 	Path = "penetratingshots/penetrations", Category = { "large"}, 									Distance = { "close" }				},
	{ Type = "Ricochets", 		Path = "ricochets/props", 				Category = { "small","medium","large"}, 				Distance = { "close", "mid" }		},
	{ Type = "Cracks", 			Path = "fly/cracks", 					Category = { "small","medium","large"}, 				Distance = { "close" }				},
	{ Type = "Debris", 			Path = "explosions/debris", 			Category = { "low", "high"}, 							Distance = { "close" }				}
}

for k, Data in pairs(TableTypes) do

	ACE.Sounds[Data["Type"]] = {}

	local Category 	= Data["Category"]
	local Distance 	= Data["Distance"]
	local Path 		= Data["Path"]

	local Iteration = 0

	--Check for category
	while Iteration < #Category do

		local Iteration2 = 0

		Iteration = Iteration + 1
		if Iteration > 1000 then break end 		--if the while becomes dumb
		--print("Iteration: "..Iteration)

		--Check for Distance
		while Iteration2 < #Distance do

			Iteration2 = Iteration2 + 1
			if Iteration2 > 1000 then break end 		--if the while becomes dumb
			--print("Iteration2: "..Iteration2)

			-- Look for sounds in the designated path
			local TxtToFind = "sound/acf_other/"..Path.."/"..Category[Iteration].."/"..Distance[Iteration2].."/*.wav"	--print( "\n"..TxtToFind.."\n" )
			local ExSounds = file.Find( TxtToFind, "GAME" )

			--if table.IsEmpty(ExSounds) then print("No se encontro nada!") end

			ACE.Sounds[Data["Type"]][Category[Iteration]] = ACE.Sounds[Data["Type"]][Category[Iteration]] or {} 		

			ACE.Sounds[Data["Type"]][Category[Iteration]][Distance[Iteration2]] = ACE.Sounds[Data["Type"]][Category[Iteration]][Distance[Iteration2]] or {}


			for i,Sound in pairs(ExSounds) do

				local Str = "acf_other/"..Path.."/"..Category[Iteration].."/"..Distance[Iteration2].."/"..Sound  	--print('Loading sound: '..Str)
		
				table.insert(ACE.Sounds[Data["Type"]][Category[Iteration]][Distance[Iteration2]], Str )

			end
		end
	end
end

--[[
--Blasts. This will store all sounds related to blasts, includes underwater sounds
ACE.Sounds.Blasts = {
	tiny = {
		close = {},
		mid = {},
		far = {}		
	},
	small = {
		close = {},
		mid = {},
		far = {}		
	},
	medium = {
		close = {},
		mid = {},
		far = {}		
	},
	large = {
		close = {},
		mid = {},
		far = {}		
	},
	underwater = {
		close = {}
	}
}






-- Debris. They will not follow the main concept, but this will be called alongside blasts, so doesnt conflict with the main one
ACE.Sounds.Debris = {
	low = {
		close = {}

	},
	high = {

	}
}

--Penetrations. Note that it has underwater table as blast one.
ACE.Sounds.Penetrations = {
	tiny = {
		close = {}
	},
	small = {
		close = {}
	},
	medium = {
		close = {}	
	},
	large = {
		close = {}
	}
}

--Ricochets. Same format than pen table
ACE.Sounds.Ricochets = {
	tiny = {
		close = {}	
	},
	small = {
		close = {}		
	},
	medium = {
		close = {}
	},
	large = {
		close = {}
	}
}

--Cracks. Same format atm
ACE.Sounds.Cracks = {
	tiny = {
		close = {}		
	},
	small = {
		close = {}		
	},
	medium = {
		close = {}
	},
	large = {
		close = {}
	}
}


--Debug tool to see if tables are being populated. Change values in tableToTest to see if there are sounds inside.
timer.Simple(2, function()

	local tableToTest = ACE.Sounds["Penetrations"]["large"]["close"]
	local MaxCount = #tableToTest --print("Table total entries: "..#tableToTest)

	print("Test if we have something in this sample table")
	print(tableToTest[math.random(1, MaxCount)] )

end)

]]--
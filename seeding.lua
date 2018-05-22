local seed = nil
-- In die Maschine
local dir = get_dir()
local start = nil

function set_seed(node)
	for _, val in ipairs(farmingmachine_registrations) do
		if node == farmingmachine_registrations[val][1] then
			seed == farmingmachine_registrations[val]
			minetest.chat_send_all("set_seed: True")
			return true
		end
	end
	minetest.chat_send_all("set_seed: False")
	return false
end

function get_seedling(node)
	if not seed == nil then
		minetest.chat_send_all("get_seedling: ".. seed[2])
		return seed[2]
	else
		minetest.chat_send_all("get_seedling: (nil)")
		return ""
	end
end

function get_dir()
	--In after_place testen
	local dir = minetest.facedir_to_dir(node.param2)
	local pos = new.vector(pos)
	
	if pos.y ~=0 then
		minetest.chat_send_all("Replace the machine, you cheater!")
		return
	elseif pos.x ~= 0 then
		
	else
		
	end
end

function search_left()
	
end

--[[

--- Iterator over positions to try to saw around a sawed node.
-- This returns positions in a 3x1x3 area around the position, plus the
-- position above it.  This does not return the bottom position to prevent
-- the seeder from cutting down nodes below the cutting position.
-- @param pos Sawing position.
function farmingNG.iterSawTries(pos)
	-- Copy position to prevent mangling it
	local pos = vector.new(pos)
	local i = 0

	return function()
		i = i + 1
		-- Given a (top view) area like so (where 5 is the starting position):
		-- X -->
		-- Z 123
		-- | 456
		-- V 789
		-- This will return positions 1, 4, 7, 2, 8 (skip 5), 3, 6, 9,
		-- and the position above 5.
		if i == 1 then
			-- Move to starting position
			pos.x = pos.x - 1
			pos.z = pos.z - 1
		elseif i == 4 or i == 7 then
			-- Move to next X and back to start of Z when we reach
			-- the end of a Z line.
			pos.x = pos.x + 1
			pos.z = pos.z - 2
		elseif i == 5 then
			-- Skip the middle position (we've already run on it)
			-- and double-increment the counter.
			pos.z = pos.z + 2
			i = i + 1
		elseif i <= 9 then
			-- Go to next Z.
			pos.z = pos.z + 1
		elseif i == 10 then
			-- Move back to center and up.
			-- The Y+ position must be last so that we don't dig
			-- straight upward and not come down (since the Y-
			-- position isn't checked).
			pos.x = pos.x - 1
			pos.z = pos.z - 1
			pos.y = pos.y + 1
		else
			return nil
		end
		return pos
	end
end

-- This function does all the hard work. Recursively we dig the node at hand
-- if it is in the table and then search the surroundings for more stuff to dig.
local function recursive_dig(pos, remaining_charge, seednum,seedstack, user)
	local uppos = {x =pos.x, y =(pos.y) +1,z =pos.z}
	local toppos = {x =pos.x, y =(pos.y) +2,z =pos.z}
	local name = user:get_player_name()
	
	if remaining_charge < farmingNG.seeder_charge_per_node or seedstack:is_empty() then
		return remaining_charge, seednum, seedstack
	end
	local node = minetest.get_node(pos)
	local upper = minetest.get_node(uppos)
	local top = minetest.get_node(toppos)
	local seedname = seedstack:get_name()
	local helpers = check_valid_util(upper.name)
	
	if node.name == "farming:weed" then
	    remaining_charge, seednum, seedstack = recursive_dig( {x=pos.x, y=pos.y-1, z=pos.z}, remaining_charge, seednum, seedstack, user)
	    return remaining_charge, seednum, seedstack
	end

	if not soil_nodenames[node.name] then
		return remaining_charge, seednum, seedstack
	end	
	
	if not check_valid_util(seedname) then
	      if upper.name == "air" or upper.name == "farming:weed" then
		    minetest.set_node(uppos, {name="air"})
		    remaining_charge = remaining_charge - farmingNG.seeder_charge_per_node
		    seednum = seednum +1
		    seedstack:take_item()
		    if remaining_charge < 1 then remaining_charge = 1 end
		    
		    if give_seedling(seedname,false) then
			  minetest.add_node(uppos, {name = give_seedling(seedname,false), param2 = 1})
			  minetest.get_node_timer(uppos):start(math.random(166, 286))
		    end
	      else
		    return remaining_charge, seednum, seedstack
	      end
	else
	     if (upper.name == "air" or upper.name == "farming:weed") and top.name == "air" then 
		    minetest.set_node(uppos, {name="air"})
		    remaining_charge = remaining_charge - farmingNG.seeder_charge_per_node
		    seednum = seednum +1
		    seedstack:take_item()
		    if remaining_charge < 1 then remaining_charge = 1 end
		    
		    if give_seedling(seedname, true) then
			  minetest.add_node(uppos, {name = give_seedling(seedname, true), param2 = 1})
			  minetest.get_node_timer(uppos):start(math.random(166, 286))
		    end
	     else
		    return remaining_charge, seednum, seedstack
	     end
	end

	-- Check surroundings and run recursively if any charge left
	for npos in farmingNG.iterSawTries(pos) do
		if remaining_charge < farmingNG.seeder_charge_per_node then
			break
		end
		if soil_nodenames[minetest.get_node(npos).name] then
			remaining_charge, seednum, seedstack = recursive_dig(npos, remaining_charge, seednum, seedstack, user)
		end
	end
	return remaining_charge, seednum, seedstack
end



-- Seeder entry point
local function seeder_dig(pos, current_charge, seednum, seedstack, user)
	-- Start sawing things down
	local remaining_charge, seednum, seedstack = recursive_dig(pos, current_charge, seednum, seedstack, user)
	minetest.sound_play("farming_nextgen_seeder", {pos = pos, gain = 1.0, max_hear_distance = 10})
	return remaining_charge, seednum, seedstack
end]]

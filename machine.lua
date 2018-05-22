-- Einige Tube-Funktionen fehlen noch
-- Aktuell ohne Pipeworks testen !

local is_craftable = false
local tube_entry = ""

if minetest.get_modpath("pipeworks") then
	tube_entry = "^pipeworks_tube_connection_metallic.png"
end

-- Anpassen:
local machine_eject_dir = vector.new(0,1,0)

local function set_machine_formspec(meta)
	local formspec = "size[8,9]"..
			"listcolors[#000000;#A9A9A9]"..
      		"bgcolor[#DEB887;false]"
	
	local mainspec =
      		"label[0,0;Input:]"..
      		"list[context;input;1,0;1,1;]"..
      		"button[4,0;3,1;seed;Seed]"..
      		"label[0,2;Output:]"..
      		"list[context;output;1,2;2,2;]"..
      		"button[4,2;3,1;harvest;Harvest]"..
			"button_exit[5,4;3,1;exit;Exit]"..
      		"list[current_player;main;0,5;8,4]"..
      		"listring[context;output]"..
      		"listring[current_player;main]"..
      		"listring[context;input]"..
      		"button[0,4;3,1;conf;Configuration]"
	
	--local infotext = "How to use this thing"
	
	local confspec =
		"label[0,0;Configuration Menu]"..
		"field[6,1;1,1;width;Width (1-16) :;8]"..
		"field[6,2;1,1;depth;Depth (1-16) :;8]"..
		"textarea[0.5,1;4,3.5;info;Description:;]"..
		"button[5,4;3,1;back;Return]"
		
	if meta:get_int("spec") == 0 then
		formspec = formspec.. mainspec
	elseif meta:get_int("spec") == 1 then
		formspec = formspec.. confspec
	end

	meta:set_string("formspec", formspec)
end

local function machine_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	if fields.seed then
		if inv:is_empty("input") then
			minetest.chat_send_player(sender:get_player_name(), "There are no seeds in the machine!")
		else
			--TODO: Übergabe des Stackitems
			if set_seed("blub") then
				-- Eigentliche arbeit einfügen
				if minetest.get_modpath("mobs_animal") then
					minetest.sound_play("mobs_chicken", {pos = pos, gain = 1.0, max_hear_distance = 10})
				end			
			else
				minetest.chat_send_player(sender:get_player_name(), "There is no valid seed in the machine!")
			end					
		end
	end
	
	if fields.harvest then
		if minetest.get_modpath("mobs_animal") then
			minetest.sound_play("mobs_cow", {pos = pos, gain = 1.0, max_hear_distance = 10})
		end
		minetest.chat_send_all(inv:get_size("output"))
	end
	
	if fields.conf then
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_int("spec", 1)
			set_machine_formspec(meta)
		end
	end
	
	if fields.back or fields.quit then
		meta:set_int("spec", 0)
		set_machine_formspec(meta)
	end
end

-- Craft ausdenken und prüfen
if is_craftable then    
	minetest.register_craft({
		output = 'farmingmachine:machine',
  		recipe = {
	  		{'', '', ''},
			{'', '', ''},
			{'', '', ''},
  		},
 	})
end

minetest.register_node("farmingmachine:machine", {
	description = "Farming Machine",
	tiles = {
		"default_copper_block.png"..tube_entry,
		"default_copper_block.png"..tube_entry,
		"default_copper_block.png"..tube_entry,
		"default_copper_block.png"..tube_entry,
		"default_copper_block.png^farming_wheat.png",
		"default_copper_block.png"..tube_entry
	},
	-- Schauen, ob tubedevice stört, wenn Pipeworks nicht vorhanden
	groups = {cracky=2, tubedevice=1, tubedevice_receiver=1},
	paramtype2 = "facedir",

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Farming Machine")
		local inv = meta:get_inventory()
		inv:set_size("input", 1)
		inv:set_size("output", 4)
	end,
		
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", (placer:get_player_name() or ""))
		meta:set_string("infotext", "Farming Machine (owned by ".. (placer:get_player_name() or "").. ")")
		set_machine_formspec(meta)
	end,
	
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:is_empty("input") and inv:is_empty("output") then
			return true
		end
		minetest.chat_send_player(player:get_player_name(), "The machine is not empty!")
		return false
	end,
	
	on_receive_fields = machine_receive_fields,
	
	-- TODO und prüfen
	--[[if minetest.get_modpath("pipeworks") then
		after_dig_node = pipeworks.scan_for_tube_objects
		tube = {
			insert_object = function(pos, node, stack, direction)
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				return inv:add_item("input", stack)
			end,
			can_insert = function(pos, node, stack, direction)
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				if meta:get_int("splitstacks") == 1 then
					stack = stack:peek_item(1)
				end
				return inv:room_for_item("input", stack)
			end,
			input_inventory = "input",
			connect_sides = {left=1, right=1, back=1, top=1,bottom=1}
	end]]
})
	
	
	
	
	
	

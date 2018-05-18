-- Einige Tube-Funktionen fehlen noch
-- Aktuell ohne Pipeworks testen !

local is_craftable = false

if minetest.get_modpath("pipeworks") then
	local tube_entry = "^pipeworks_tube_connection_metallic.png"
-- Prüfen, ob überhaupt nötig
else
	local tube_entry = ""
end

-- Anpassen:
local machine_eject_dir = vector.new(0,1,0)

local function set_machine_formspec(meta)
	local formspec = "size[10,14]"..
      		"label[1,0;Input:]"..
      		"list[context;input;1,1,;2,2;]"..
      		"label[1,3;Output:]"..
      		"list[context;output;4,1;4,4;]"..
      		"button[1,6;3,1;seed;Seed]"..
      		"button[3,6;3,1;harvest;Harvest]"..
		-- Prüfen (Falls Probleme: on_rightclick mit config_formspec implementieren)
		if meta:get_string("owner") == (current_player or "") then
      			"button[5,6;3,1;config;Configuration]"..
		end
      		"button_exit[7,6;3,1;exit;Exit]"..
      		"list[current_player;main;0,5;8,4]"..
      		"listring[context;output]"..
      		"listring[current_player;main]"..
      		"listring[context;input]"..
      		"listcolors[#000000;#A9A9A9]"..
      		"bgcolor[#DEB887;true]"
		-- Prüfen auf Notwendigkeit
		meta:set_string("formspec", formspec)
end

local function set_config_formspec(meta)
	local formspec = "size[10,14]"..
		"label[1,0;Configuration Menu]"..
		"field[3,1;1,1;width;Width (1-16) :]"..
		"field[5,1;1,1;depth;Depth (1-16) :]"..
		"button[7,6;3,1;return;Return]"..
		"listcolors[#000000;#A9A9A9]"..
      		"bgcolor[#DEB887;true]"
end

local function machine_recieve_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	
	--if fields.input
	--if fields.output
	if fields.seed then
		if minetest.get_modpath("mobs_animal") then
			minetest.sound_play("mobs_chicken", {pos = pos, gain = 1.0, max_hear_distance = 10})
		end
		--TODO
	end
	if fields.harvest then
		if minetest.get_modpath("mobs_animal") then
			minetest.sound_play("mobs_cow", {pos = pos, gain = 1.0, max_hear_distance = 10})
		end
		--TODO
	end
	if fields.config then
		set_config_formspec(meta)
	end
	if fields.return then
		set_machine_formspec(meta)
	end
	--if fields.exit
	--if fields.main
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
		set_machine_formspec(meta)
		-- Prüfen auf Notwendigkeit
		local inv = meta:get_inventory()
		inv:set_size("input", 2*2)
		inv:set_size("output", 4*4)
	end,
		
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", (placer:get_player_name()) or ""))
		meta:set_string("infotext", "Farming Machine (owned by ".. (placer:get_player_name() or "").. ")")
	end,
	
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:is_empty("input") and inv:is_empty("output")
			return true
		end
		return false
	end,
	
	on_receive_fields = machine_recieve_fields,
	
	-- TODO und prüfen
	if minetest.get_modpath("pipeworks") then
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
	end
}
	
	
	
	
	
	

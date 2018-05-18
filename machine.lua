local is_craftable = false
local tube_entry = "^pipeworks_tube_connection_metallic.png"
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
		-- Prüfen
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
--TODO	
end

local function machine_recieve_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	
	--if fields.input
	--if fields.output
	if fields.seed
	if fields.harvest
	if fields.config
	--if fiedls.exit
	--if fields.main
end

local function config_recieve_fields(pos,formname,fields,sender)
--TODO	
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
	groups = {cracky=2},
	--inventory_image = "",
	--tiles =
	-- Design ergänzen
	paramtype2 = "facedir",
	--sound = {} 

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Farming Machine")
		set_machine_formspec(meta)
		-- Prüfen auf Notwendigkeit
		local inv = meta:get_inventory()
		inv:set_size("input", 2*2)
		inv:set_size("output", 4*4)
	end,
	
	-- Um Tube-Funktionalität erweitern (siehe Quarry)
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
	
	--[[on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()]]
	--after_dig_node =
}

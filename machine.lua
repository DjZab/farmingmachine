local is_craftable = false

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
  groups = {oddly_breakable_by_hand=2},
  --inventory_image = "",
  paramtype2 = "facedir",
  --sound = {}
    
	--tiles = {"mymeshnodes_cubemap.png"},
	--drawtype = "mesh",
	--mesh = "mymeshnodes_machine.obj",
	--paramtype = "light",
	--paramtype2 = "facedir",
	--selection_box = {
--		type = "fixed",
	--	fixed = {
		--	{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		--}
},
  
--[[after_place_node = function(pos, placer)
	local meta = minetest.get_meta(pos);
			meta:set_string("owner",  (placer:get_player_name() or ""));
			meta:set_string("infotext",  "Farming Machine (owned by " .. (placer:get_player_name() or "") .. ")");
		end,

can_dig = function(pos,player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	if not inv:is_empty("input") then
		return false
	elseif not inv:is_empty("output") then
		return false
	end
	return true
end,]]

on_construct = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string(
      "formspec", "size[10,14]"..
      "label[1,0;Input:]"..
      "list[context;input;1,1,;2,2;]"..
      "label[1,3;Output:]"..
      "list[context;output;4,1;4,4;]"..
      "button[1,6;3,1;seed;Seed]"..
      "button[3,6;3,1;harvest;Harvest]"..
      "button[5,6;3,1;config;Configuration]"..
      "button_exit[7,6;3,1;exit;Exit]"..
      "list[current_player;main;0,5;8,4]"..
      "listring[context;output]"..
      "listring[current_player;main]"..
      "listring[context;input]"..
      "listcolors[#000000;#A9A9A9]"..
      "bgcolor[#DEB887;true]"
  )
	meta:set_string("infotext", "Farming Machine");
	local inv = meta:get_inventory()
	inv:set_size("input", 2*2)
	inv:set_size("output", 4*4)
end,

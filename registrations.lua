-- The default soils
local soil_nodenames = {
	"farming:soil",
	"farming:soil_wet",
	"farming:desert_sand_soil",
	"farming:desert_sand_soil_wet"
}

local farmingmachine_registrations = {
-- farming
	{"farming:beetroot", "farming:beetroot_1", "farming:beetroot_5"},
	{"farming:blueberries", "farming:blueberry_1", "farming:blueberry_4"},
	{"farming:carrot", "farming:carrot_1", "farming:carrot_8"},	
	{"farming:chili_pepper", "farming:chili_1", "farming:chili_8"},
	{"farming:coffee_beans", "farming:coffee_1", "farming:coffee_5"},	
	{"farming:corn", "farming:corn_1", "farming:corn_8"},
	{"farming:cucumber", "farming:cucumber_1", "farming:cucumber_4"},
	{"farming:garlic_clove", "farming:garlic_1", "farming:garlic_5"},
	{"farming:melon_slice", "farming:melon_1", "farming:melon_8"},
	{"farming:onion", "farming:onion_1", "farming:onion_5"},
	{"farming:pea_pod", "farming:pea_1", "farming:pea_5"},
	{"farming:peppercorn", "farming:pepper_1", "farming:pepper_5"},
	{"farming:pineapple_top", "farming:pineapple_1", "farming:pineapple_8"},
	{"farming:potato", "farming:potato_1", "farming:potato_4"},
	{"farming:pumpkin_seed", "farming:pumpkin_1", "farming:pumpkin"},			--ok
	{"farming:raspberries", "farming:raspberry_1", "farming:raspberry_4"},
	{"farming:rhubarb", "farming:rhubarb_1", "farming:rhubarb_3"},	
	{"farming:seed_barley", "farming:barley_1", "farming:barley_7"},
	{"farming:seed_cotton", "farming:cotton_1", "farming:cotton_8"},
	{"farming:seed_hemp", "farming:hemp_1", "farming:hemp_8"},
	{"farming:seed_wheat", "farming:wheat_1", "farming:wheat_8"},
	{"farming:tomato", "farming:tomato_1", "farming:tomato_8"},
	{"", "", "farming:weed"},
-- farming_plus
	{"farming_plus:carrot_seed", "farming_plus:carrot_1", "farming_plus:carrot"},
	{"farming_plus:chilli_seeds", "farming_plus:chilli_1", "farming_plus:chilli"},
	{"farming_plus:coffee_beans", "farming_plus:coffee_1", "farming_plus:coffee"},
	{"farming_plus:corn_seed", "farming_plus:corn_1", "farming_plus:corn"},		--ok
	{"", "", "farming_plus:cornb"},	--ok
	{"", "", "farming_plus:cornc"},	--ok
	{"farming_plus:cucumber_seed", "farming_plus:cucumber_1", "farming_plus:cucumber"},
	{"farming_plus:garlic_seed", "farming_plus:garlic_1", "farming_plus:garlic"},
	{"farming_plus:lemon_seed", "farming_plus:lemon_1", ""},	
	{"farming_plus:melon_seed", "farming_plus:melon_1", "farming_plus:melon"},
	{"farming_plus:orange_seed", "farming_plus:orange_1", ""},
	{"farming_plus:peach_seed", "farming_plus:peach_1", ""},	
	{"farming_plus:potato_seed", "farming_plus:potato_1", "farming_plus:potato"},
	{"farming_plus:rhubarb_seed", "farming_plus:rhubarb_1", "farming_plus:rhubarb"},
	{"farming_plus:raspberry_seed", "farming_plus:raspberry_1", ""},
	{"farming_plus:seed_barley", "farming_plus:barley_1", "farming_plus:barley_7"},
	{"farming_plus:seed_hemp", "farming_plus:hemp_1", "farming_plus:hemp_8"},		
	{"farming_plus:strawberry_seed", "farming_plus:strawberry_1", ""},
	{"farming_plus:soy_seed", "farming_plus:soy_plant_1", "farming_plus:soy_plant"},
	{"farming_plus:tomato_seed", "farming_plus:tomato_1", "farming_plus:tomato"},
	{"farming_plus:walnut_item", "farming_plus:walnut_1", ""},	
-- beer_test
	{"beer_test:seed_oats", "beer_test:seed_oats", "beer_test:oats_8"}
 } 
  
--[[-- Harvesting
local farmingmachine_harvests = {
-- farming
	harvester_names["farming:beanpole_5"]	= true
	harvester_names["farming:grapes_8"]	= true
	harvester_names["farming_plus:beanpole_5"]= true
	harvester_names["farming_plus:grapes_8"]= true]]


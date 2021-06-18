
--
-- Oxidized Blocks
--

minetest.register_node("xcopper:oxidizedblock", {
	description = ("Oxidized Block"),
	tiles = {"xcopper_oxidized_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

-- Stairs

if minetest.get_modpath("stairs") then

stairs.register_stair(
	"oxidized",
	"xcopper:oxidizedblock",
	{cracky = 1, level = 2},
	{"xcopper_oxidized_block.png"},
	"Oxidized Stair",
	default.node_sound_metal_defaults(),
	false
)

stairs.register_slab(
	"oxidized",
	"xcopper:oxidizedblock",
	{cracky = 1, level = 2},
	{"xcopper_oxidized_block.png"},
	"Oxidized Slab",
	default.node_sound_metal_defaults(),
	false
)

stairs.register_stair_inner(
	"oxidized",
	"xcopper:oxidizedblock",
	{cracky = 1, level = 2},
	{"xcopper_oxidized_block.png"},
	"Oxidized Inner Stair",
	default.node_sound_metal_defaults(),
	false
)

stairs.register_stair_outer(
	"oxidized",
	"xcopper:oxidizedblock",
	{cracky = 1, level = 2},
	{"xcopper_oxidized_block.png"},
	"Oxidized Outer Stair",
	default.node_sound_metal_defaults(),
	false
)
end

-- Make Copper and Bronze have the group "oxidizes"

minetest.override_item("default:bronzeblock", {
	description = ("Bronze Block"),
	tiles = {"default_bronze_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2, oxidizes=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.override_item("default:copperblock", {
	description = ("Copper Block"),
	tiles = {"default_copper_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2, oxidizes=3},
	sounds = default.node_sound_metal_defaults(),
})

--
-- Oxidation ABM
--

local oxide_correspondences = {
	["default:copperblock"] = "xcopper:oxidizedblock",
	["default:bronzeblock"] = "xcopper:oxidizedblock",
	["stairs:stair_copperblock"] = "stairs:stair_oxidized",
	["stairs:slab_copperblock"] = "stairs:slab_oxidized",
	["stairs:stair_inner_copperblock"] = "stairs:stair_inner_oxidized",
	["stairs:stair_outer_copperblock"] = "stairs:stair_outer_oxidized",
	["stairs:stair_bronzeblock"] = "stairs:stair_oxidized",
	["stairs:slab_bronzelock"] = "stairs:slab_oxidized",
	["stairs:stair_inner_bronzeblock"] = "stairs:stair_inner_oxidized",
	["stairs:stair_outer_bronzeblock"] = "stairs:stair_outer_oxidized",
}

minetest.register_abm({
	label = "Oxidation",
	nodenames = {"group:oxidizes"},
	neighbors = {"group:water"},
	interval = 20,
	chance = 150,
	catch_up = false,
	action = function(pos, node)
		node.name = oxide_correspondences[node.name]
		if node.name then
			minetest.set_node(pos, node)
		end
	end
})

-- You can craft Oxidized Block too

if minetest.get_modpath("bucket") then

minetest.register_craft({
	type = "shapeless",
	output = "default:oxidizedblock",
	recipe = {
		"group:oxidizes","bucket:bucket_water"
	},
	replacements = { {"bucket:bucket_water", "bucket:bucket_empty"} }
})

end

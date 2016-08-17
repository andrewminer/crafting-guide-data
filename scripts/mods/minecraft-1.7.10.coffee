WOOD_TYPES = [ 'Oak Wood', 'Birch', 'Spruce', 'Jungle', 'Acacia Wood', 'Dark Oak' ]

exports.slug = 'minecraft'
exports.version = '1.7.10'

exports.contains = (item)->
    return false if item.minecraftId.mod.indexOf('minecraft') is -1
    return false if item.minecraftId.name in [ 'end_portal', 'portal', 'mob_spawner', 'monster_egg', 'spawn_egg' ]
    return true

exports.correctItem = (item)->
    item.isGatherable = true if item.gameName in [
        'Coal', 'Diamond', 'Emerald', 'Lapis Lazuli', 'Nether Quartz', 'Redstone', 'Stone', 'Wheat', 'Wool'
    ]

    item.isGatherable = true if item.minecraftId.name in [
        'melon_block'
    ]

    item.isGatherable = false if item.gameName in [
        'Bottle o\' Enchanting', 'Command Block', 'Farmland', 'Lava', 'Water', 'Written Book'
    ]

exports.normalizeName = (item)->
    name = item.gameName

    switch item.minecraftId.name
        when 'clay' then name = 'Clay (block)'
        when 'clay_ball' then name = 'Clay (item)'
        when 'filled_map' then name = 'Map (filled)'
        when 'melon_block' then name = 'Melon (block)'
        when 'netherbrick' then name = 'Nether Brick (item)'
        when 'nether_brick' then name = 'Nether Brick (block)'
        when 'planks'
            index = item.minecraftId.meta || 0
            name = "#{WOOD_TYPES[index]} Planks"
        when 'stone_button' then name = 'Button (stone)'
        when 'stone_pressure_plate' then name = 'Pressure Plate (stone)'
        when 'wooden_button' then name = 'Button (wooden)'
        when 'wooden_pressure_plate' then name = 'Pressure Plate (wooden)'
        when 'wooden_slab'
            index = item.minecraftId.meta || 0
            name = "#{WOOD_TYPES[index]} Slab"

    return name

exports.shouldNormalizeGrid = (item, grid)->
    return true if item.gameName in [
        'Bed', 'Bowl', 'Boat', 'Brewing Stand', 'Bucket', 'Cobblestone Slab', 'Diamond Boots', 'Diamond Helmet',
        'Minecart', 'Oak Wood Slab', 'Stone Slab', 'Trapdoor', 'Weighted Pressure Plate (Heavy)',
        'Weighted Pressure Plate (Light)'
    ]
    return false
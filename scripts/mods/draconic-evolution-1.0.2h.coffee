exports.slug = 'draconic_evolution'
exports.version = '1.0.2h'

exports.assignGroup = (item)->
    item.groupName = 'Other'

    item.groupName = 'Armor' if item.gameName.match /Boots|Chestplate|Helm|Leggings/
    item.groupName = 'Energy' if item.gameName.match /Energy|Generator|Reactor|Wireless/
    item.groupName = 'Crafting Components' if item.gameName.match /Assembly|Binder|Capacitor|Core|Rotor/
    item.groupName = 'Materials' if item.gameName.match /Block|Dust|Fragment|Infused|Ingot|Nugget|Ore|Shard/
    item.groupName = 'Tools' if item.gameName.match /Arrow|Axe|Bow|Charm|Hoe|Match|Key|Pickaxe|Shovel|Staff|Sword|Tablet/

    item.groupName = 'Machines' if item.gameName in [
        'Advanced Player Detector'
        'Awakened Item Dislocator'
        'Disenchanter'
        'Dislocator Pedestal'
        'Dislocator Receptacle'
        'Distortion Flame'
        'Draconic Chest'
        'Enhanced Charm of Dislocation'
        'Fluid Gate'
        'Flux Gate'
        'Item Dislocator'
        'Mob Grinder'
        'Particle Generator'
        'Player Detector'
        'Potentiometer'
        'Rain Sensor'
        'Resurrection Stone'
        'Stabilized Mob Spawner'
        'Sun Dial'
        'Upgrade Modifier'
        'Weather Controller'
    ]

    item.groupName = 'Materials' if item.gameName in [
        'Dragon Heart'
        'Mob Soul'
    ]

exports.contains = (item)->
    return false if item.minecraftId.mod.indexOf('DraconicEvolution') is -1
    return false if item.minecraftId.name in [
        'longRangeDislocator', 'cKeyStone', 'draconiumBlend', 'adminSpawnEgg'
    ]
    return true

exports.correctItem = (item)->
    item.isGatherable = true if item.gameName in [
        'Awakened Draconium Ingot'
    ]

exports.scrubMinetweakerLine = (lineText)->
    lineText = lineText.replace /\.withTag\({Name: "Any"}\)/g, ''
    return lineText

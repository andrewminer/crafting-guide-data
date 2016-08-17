
FACADE_PATTERN = /^Facade: ([^(]*)$/

GATE_PATTERN = /^.*(OR|AND|Basic) Gate$/

HOLLOW_FACADE_PATTERN = /^Facade: ([^(]*) \(item.Facade.state_hollow\)/

exports.contains = (item)->
    return false if item.minecraftId.mod.indexOf('BuildCraft') is -1
    return false if item.displayName.match /^tile/
    return true if item.displayName.match /Stone( Hollow)? Facade/
    return false if item.displayName.match /Facade/
    return false if item.displayName.match /(Water|Oil) Spring$/
    return true

exports.normalizeName = (item, index=1)->
    name = item.gameName

    if match = name.match FACADE_PATTERN
        return "#{match[1]} Facade"

    if match = name.match GATE_PATTERN
        switch index
            when 2 then return "#{name} (Autarchic Pulsar)"
            when 3 then return "#{name} (Clock Timer)"
            when 4 then return "#{name} (Redstone Fader)"

    if match = name.match HOLLOW_FACADE_PATTERN
        return "#{match[1]} Hollow Facade"

    if name is 'Redstone Board'
        switch index
            when 1 then return "Redstone Board (Bomber)"
            when 2 then return "Redstone Board (Builder)"
            when 3 then return "Redstone Board (Butcher)"
            when 4 then return "Redstone Board (Carrier)"
            when 5 then return "Redstone Board (Crafter)"
            when 6 then return "Redstone Board (Delivery)"
            when 7 then return "Redstone Board (Farmer)"
            when 8 then return "Redstone Board (Knight)"
            when 9 then return "Redstone Board (Harvester)"
            when 10 then return "Redstone Board (Leaf Cutter)"
            when 11 then return "Redstone Board (Lumberjack)"
            when 12 then return "Redstone Board (Miner)"
            when 13 then return "Redstone Board (Picker)"
            when 14 then return "Redstone Board (Planter)"
            when 15 then return "Redstone Board (Pump)"
            when 16 then return "Redstone Board (Shovelman)"
            when 17 then return "Redstone Board (Stripes)"
            when 18 then return "Redstone Board (Tank)"

    if name is 'Robot'
        switch index
            when 1 then return "Robot (Bomber)"
            when 2 then return "Robot (Builder)"
            when 3 then return "Robot (Butcher)"
            when 4 then return "Robot (Carrier)"
            when 5 then return "Robot (Crafter)"
            when 6 then return "Robot (Delivery)"
            when 7 then return "Robot (Farmer)"
            when 8 then return "Robot (Knight)"
            when 9 then return "Robot (Harvester)"
            when 10 then return "Robot (Leaf Cutter)"
            when 11 then return "Robot (Lumberjack)"
            when 12 then return "Robot (Miner)"
            when 13 then return "Robot (Picker)"
            when 14 then return "Robot (Planter)"
            when 15 then return "Robot (Pump)"
            when 16 then return "Robot (Shovelman)"
            when 17 then return "Robot (Stripes)"
            when 18 then return "Robot (Tank)"

    return name

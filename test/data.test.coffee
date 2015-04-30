###
Crafting Guide - data.test.coffee

Copyright (c) 2015 by Redwood Labs
All rights reserved.
###

{Mod}              = require 'crafting-guide'
{ModParser}        = require 'crafting-guide'
{ModVersion}       = require 'crafting-guide'
{ModVersionParser} = require 'crafting-guide'
fs                 = require 'fs'

########################################################################################################################

describe 'data files for', ->

    for modSlug in fs.readdirSync './data/'
        do (modSlug)->
            describe modSlug, ->

                mod = new Mod slug:modSlug
                modParser = new ModParser model:mod, showAllErrors:true
                modParser.parse fs.readFileSync "./data/#{modSlug}/mod.cg", 'utf8'

                it 'loads mod.cg without errors', ->
                    modParser.errors.should.eql []
                    mod.name.should.not.equal ''
                    mod.activeModVersion.should.exist

                it 'has an icon file', ->
                    stats = fs.statSync "./data/#{modSlug}/icon.png"
                    stats.isFile().should.be.true

                mod.eachModVersion (modVersion)->
                    do (modVersion)->
                        describe modVersion.version, ->

                            modVersionParser = new ModVersionParser model:modVersion, showAllErrors:true
                            fileName = "./data/#{modSlug}/versions/#{modVersion.version}/mod-version.cg"
                            modVersionParser.parse fs.readFileSync fileName, 'utf8'

                            it 'loads mod-version.cg without errors', ->
                                modVersionParser.errors.should.eql []
                                _.keys(modVersion._items).length.should.be.greaterThan 0
                                _.keys(modVersion._recipes).length.should.be.greaterThan 0
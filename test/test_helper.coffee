#
# Crafting Guide - test.coffee
#
# Copyright (c) 2014-2017 by Redwood Labs
# All rights reserved.
#

# Test Set-up ##########################################################################################################

chai = require 'chai'
chai.use require 'sinon-chai'
chai.config.includeStack = true

global._        = require 'underscore'
global.Backbone = require 'backbone'
global.assert   = chai.assert
global.expect   = chai.expect
global.should   = chai.should()
global.util     = require 'util'
global.w        = require 'when'
global.window   = {}

Logger = require('crafting-guide-common').util.Logger
global.logger = new Logger level:Logger.ERROR

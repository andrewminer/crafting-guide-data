#
# Copyright © 2015 by Redwood Labs
# All rights reserved.
#

fs = require 'fs'

########################################################################################################################

module.exports = (grunt)->

    grunt.loadTasks tasks for tasks in grunt.file.expand './node_modules/grunt-*/tasks'

    grunt.config.init

        compress:
            static:
                options:
                    mode: 'gzip'
                files: [
                    {expand: true, cwd:'./data', src:'**/*.cg', dest:'./dist/data'}
                ]

        clean:
            dist: ['./dist']

        mochaTest:
            options:
                bail: true
                color: true
                reporter: 'dot'
                require: [
                    'coffee-script/register'
                    './test/test_helper.coffee'
                ]
                verbose: true
            src: ['./test/**/*.test.coffee']

        symlink:
            images:
                files: [
                    {expand:true, cwd:'./data', src:'**/*.png', dest:'./dist/data'}
                ]

        watch:
            data_files:
                files: ['./data/**/*.cg']
                tasks: ['mochaTest']

    # Compound Tasks ###################################################################################################

    grunt.registerTask 'default', 'run tests to verify data files',
        ['test']

    grunt.registerTask 'dist', 'build the project to be run from Amazon S3',
        ['clean', 'symlink:images', 'compress']

    grunt.registerTask 'test', 'run unit tests',
        ['mochaTest']

    grunt.registerTask 'upload:prod', 'upload the project to the production Amazon S3 environment',
        ['script:s3_upload:prod']

    grunt.registerTask 'upload:staging', 'upload the project the staging Amazon S3 environment',
        ['script:s3_upload:staging']

    # Code Tasks #######################################################################################################

    grunt.registerTask 'use-local-deps', ->
        grunt.file.mkdir './node_modules'
        grunt.file.delete './node_modules/crafting-guide', force:true
        grunt.file.delete './node_modules/crafting-guide-common', force:true
        fs.symlinkSync '../../crafting-guide/', './node_modules/crafting-guide'
        fs.symlinkSync '../../crafting-guide-common/', './node_modules/crafting-guide-common'

    # Script Tasks #####################################################################################################

    grunt.registerTask 'script:s3_upload:prod', 'uploads all static content to S3', ->
      done = this.async()
      grunt.util.spawn cmd:'./scripts/s3_upload', args:['--prod'], opts:{stdio:'inherit'}, (error)-> done(error)

    grunt.registerTask 'script:s3_upload:staging', 'uploads all static content to S3', ->
      done = this.async()
      grunt.util.spawn cmd:'./scripts/s3_upload', args:['--staging'], opts:{stdio:'inherit'}, (error)-> done(error)

    # Command-Line Argument Processing #################################################################################

    args = process.argv[..]
    while args.length > 0
        switch args[0]
            when '--grep'
                args.shift()
                grunt.config.merge mochaTest:options:grep:args[0]

        args.shift()

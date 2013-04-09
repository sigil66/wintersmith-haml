haml = require 'haml'
path = require 'path'
fs = require 'fs'

module.exports = (wintersmith, callback) ->

  class HamlTemplate extends wintersmith.TemplatePlugin

    constructor: (@tpl) ->

    render: (locals, callback) ->
      try
        callback null, new Buffer @tpl(locals)
      catch error
        callback error

  HamlTemplate.fromFile = (filename, base, callback) ->  
    fs.readFile path.join(base, filename), (error, contents) ->
      if error then callback error
      else
        try
          tpl = haml contents.toString()
          callback null, new HamlTemplate tpl
        catch error
          callback error

  wintersmith.registerTemplatePlugin '**/*.haml', HamlTemplate
  callback()

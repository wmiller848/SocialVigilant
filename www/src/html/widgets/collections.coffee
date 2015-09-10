#
#  William C Miller
#

class window.CollectionsWidget extends window.Malefic.View

  Context: '[data-id="sv:context:ui:interactions:collections"]'

  Template: 'tmpl/collections.hbs'

  Events:
    'hide:widget:toolbar': 'hide'
    'show:widget:toolbar': 'show'
    'lock:widget:toolbar': 'lock'
    'unlock:widget:toolbar': 'unlock'

  Data:
    'Title': 'collections',
    'Collections': [],
    'Model':
      'Collections': null

  Helpers:
    'log': ->
      @Log(arguments)

  Actions: ->
    'default': =>
      @Log(@)
    'fullscreen': =>
      @ToggleFullScreen()
    'hide': =>
      @Hide()
    'show': =>
      @Show()

  Elements:
    'fullscreen': '[data-id="toolbar:fullscreen"]'
    'account': '[data-id="toolbar:account"]'

  Loaded: ->
    @Log('CollectionsWidget Widget Loaded')
    #@Hide()

    @Broker.On('data:collections:set', (collections) =>
      # console.log('!!Collections:Set!!', collections)
      @Data.Collections.push(collection)
      @Data.Model.Collections = @Data.Collections.reverse()
      @Render()
    )

    @Broker.On('data:collections:add', (collection) =>
      # console.log('!!Collections:Add!!', collection)
      @Data.Collections.push(collection)
      @Data.Model.Collections = @Data.Collections.reverse().slice(0, 50)
      @Render()
    )

  OnBind: ->
    @Log('CollectionsWidget Binded Widget')

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

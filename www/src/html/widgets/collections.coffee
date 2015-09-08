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
    'Model':
      'Collections': new Array(10)

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

    @Broker.On('widget:collections:set', (accounts) =>
      console.log('!!Collections:Set!!', accounts)
    )

  OnBind: ->
    @Log('CollectionsWidget Binded Widget')

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

#
#  William C Miller
#

class window.RealtimeWidget extends window.Malefic.View

  Context: '[data-id="sv:context:ui:realtime"]'

  Template: 'tmpl/realtime.hbs'

  Events:
    'hide:widget:toolbar': 'hide'
    'show:widget:toolbar': 'show'
    'lock:widget:toolbar': 'lock'
    'unlock:widget:toolbar': 'unlock'

  Data:
    'title': 'toolbar'

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
    console.log('Loaded')
    @Log('RealtimeWidget Widget Loaded')
    #@Hide()

  OnBind: ->
    console.log('OnBind')
    @Log('RealtimeWidget Binded Widget')

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

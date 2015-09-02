#
#  William C Miller
#

class window.InteractionsWidget extends window.Malefic.View

  Context: '[data-id="sv:context:ui:interactions"]'

  Template: 'tmpl/interactions.hbs'

  Events:
    'hide:widget:toolbar': 'hide'
    'show:widget:toolbar': 'show'
    'lock:widget:toolbar': 'lock'
    'unlock:widget:toolbar': 'unlock'

  Data:
    'title': 'interactions'

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
    @Log('InteractionsWidget Widget Loaded')
    #@Hide()

  OnBind: ->
    @Log('InteractionsWidget Binded Widget')

    @selectors = new window.SelectorsWidget()
    @selectors.Ready( ->
      console.log('Selectors Loaded')
    )

    @accounts = new window.AccountsWidget()
    @accounts.Ready( ->
      console.log('Accounts Loaded')
    )

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

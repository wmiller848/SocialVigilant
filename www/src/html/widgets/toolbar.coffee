#
#  William C Miller
#

class window.ToolBarWidget extends window.Malefic.View

  Context: '[data-id="sv:context:ui:toolbar"]'

  Template: 'tmpl/toolbar.hbs'

  Events:
    'hide:widget:toolbar': 'hide'
    'show:widget:toolbar': 'show'
    'lock:widget:toolbar': 'lock'
    'unlock:widget:toolbar': 'unlock'

  Data:
    'title': 'toolbar'

  # Helpers:
  #   'widget:toolbar': (widget) ->
  #     action = "window._www.Widgets['#{widget.template}']"

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
    @Log('ToolBarWidget Widget Loaded')
    #@Hide()

    @Broker.On('widget:main', (user) =>
      console.log('!!MAIN!!', user)
      @Broker.Trigger('widget:accounts:set', user.accounts)
      @Broker.Trigger('widget:selectors:set', user.selectors)
      stats =
        hits_per_minute: 0,
        total_hits: 0,
        interactions_per_day: 0,
        total_interactions: 0
      @Broker.Trigger('widget:realtimestats:set', stats)
    )

  OnBind: ->
    @Log('ToolBarWidget Binded Widget')

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

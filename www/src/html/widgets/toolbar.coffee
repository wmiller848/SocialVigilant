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

  OnBind: ->
    @Log('ToolBarWidget Binded Widget')

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

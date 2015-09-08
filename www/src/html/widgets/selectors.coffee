#
#  William C Miller
#

class window.SelectorsWidget extends window.Malefic.View

  Context: '[data-id="sv:context:ui:interactions:selectors"]'

  Template: 'tmpl/selectors.hbs'

  Events:
    'hide:widget:toolbar': 'hide'
    'show:widget:toolbar': 'show'
    'lock:widget:toolbar': 'lock'
    'unlock:widget:toolbar': 'unlock'

  Data:
    'title': 'selectors'
    'Model':
      'Selectors': null

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
    @Log('SelectorsWidget Widget Loaded')
    #@Hide()

    @Broker.On('widget:selectors:set', (selectors) =>
      console.log('!!Selectors:Set!!', selectors)
      @Data.Model.Selectors = selectors
      list = _.reduce(selectors, (memo, selector) ->
        memo.push(selector.key)
        memo
      , [])
      @Data.Model.SelectorsList = list.toString()
      @Data.Model.SelectorsList = @Data.Model.SelectorsList.substring(0,9) + '..' if @Data.Model.SelectorsList.length > 9
      @Render()
    )

  OnBind: ->
    @Log('SelectorsWidget Binded Widget')

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

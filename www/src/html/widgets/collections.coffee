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
      'Interactions': [
        {
          'content': 'blah blahs'
        }
      ]
      'Slide': 0
      'PanelView': 'inherit'
      'PanelViewHeight': 0

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
    'expand': '[data-id="toolbar:collections:expand"]'
    'collection': '[data-id="toolbar:collections:collection"]'
    'panel': '[data-id="toolbar:collections:panel"]'

  Loaded: ->
    @Log('CollectionsWidget Widget Loaded')
    #@Hide()

    @Broker.On('data:collections:set', (collections) =>
      # console.log('!!Collections:Set!!', collections)
      @Data.Model.Collections = collections
      @Render()
    )

    @Broker.On('data:collections:add', (collection) =>
      # console.log('!!Collections:Add!!', collection)
      @Data.Collections.push(collection)
      @Data.Model.Collections = []
      @Data.Model.Collections.push(@Data.Collections[i]) for i in [@Data.Collections.length-1..0]
      @Data.Model.Collections = @Data.Model.Collections.slice(0, 8)
      @Render()
    )

  OnBind: ->
    @Log('CollectionsWidget Binded Widget')

    upCaret = '&#9650;'
    downCaret = '&#9660;'

    @Data.Model.PanelViewHeight = @Elements.panel?.offsetHeight
    @Elements.collection?.on('click', (e) =>
      return if e.isTriggered
      e.preventDefault()
      e.stopPropagation()
      e.isTriggered = true

      dist = 50
      fps = 30
      speed = 2
      step = dist / (fps / speed)
      tick = =>
        @Data.Model.Slide += step
        if @Data.Model.Slide < dist
          setTimeout(tick, 1000 / fps)
        else
          @Data.Model.Slide = dist
          @Data.Model.PanelView = 'inherit'
        @Render()
      tick()
      return false
    )

    @Elements.expand?.on('click', (e) =>
      return if e.isTriggered
      e.preventDefault()
      e.stopPropagation()
      e.isTriggered = true
      el = e.currentTarget
      target = @Q("[data-id=\"#{el.dataset.targetid}\"]")
      if el.dataset.status is 'off'
        el.dataset.status = 'on'
        target.style.display = 'inherit'
      else if el.dataset.status is 'on'
        el.dataset.status = 'off'
        target.style.display = 'none'
      return false
    )

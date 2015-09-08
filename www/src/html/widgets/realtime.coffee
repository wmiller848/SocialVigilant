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
    'title': 'realtime'

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
    'canvas': '[data-id="sv:context:ui:graph"]'

  Loaded: ->
    @Log('RealtimeWidget Widget Loaded')

    @Broker.On('data:realtime:config', (settings) =>
      @time_window = settings.time_window
      @time_window_name = settings.time_window_name
    )

    # Returns a packet on the seleced interval
    @Broker.On('data:realtime:set', (packet) =>
      @path.insert(0, @view.bounds.bottomLeft)
      @path.removeSegments(1, 3)

      @path.removeSegments(110, 111)

      @path.add(new paper.Point(@view.size.width + (10 * @view.size.width/100), @view.size.height - (packet.hits * @realtime_scale)))
      @path.add(new paper.Point(@view.size.width + (10 * @view.size.width/100), @view.size.height + (10 * @view.size.height/100)))

      # @path.lastSegment.point = @view.bounds.bottomRight
      # @path.insert(@path.length-1, new paper.Point(@view.size.width, @view.size.height - packet.hits))
      # # @path.add(@view.bounds.bottomRight)
      # @path.removeSegments(1, 2)
      # @path.firstSegment.point = @view.bounds.bottomLeft
      @path.smooth()
    )

  OnBind: ->
    @Log('RealtimeWidget Binded Widget')
    # realToCSSPixels = window.devicePixelRatio || 1
    paper.setup(@Elements.canvas)
    @realtime_scale = 0.1
    @view = paper.view
    # @view.onResize = =>
    #   # @path.insert(0, @view.bounds.bottomLeft)
    #   # @path.removeSegments(1, 2)
    #   # #
    #   # #
    #   @path.add(@view.bounds.bottomRight)
    #   @path.removeSegments(105, 106)
    #   @path.smooth()
    #   @view.draw()

    @path = new paper.Path()
    @path.strokeColor = '#000000'
    # @path.strokeColor = '#e08285'
    @path.fillColor = '#000000'
    # @path.fullySelected = true
    @path.strokeCap = 'round'

    @path.add(@view.bounds.bottomLeft)
    for n in [1..110]
      @path.add(new paper.Point(n * @view.size.width/100, @view.size.height))
    @path.add(new paper.Point(@view.size.width + (10 * @view.size.width/100), @view.size.height + (10 * @view.size.height/100)))


    @RenderLoop( =>
      for n in [1..105]
        # @path.segments[n].point.y *= @realtime_scale
        @path.segments[n].point.x -= @view.size.width/100

      @view.draw()
    , 60)

    @stats =  new RealtimeStatsWidget()
    @stats.Ready( =>
      console.log('RealtimeStats Loaded')
      @ChildrenReady?()
    )

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

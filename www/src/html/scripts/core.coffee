window.Malefic._broker = new window.Malefic.Stream()

class window.Core extends window.Malefic.Core
  constructor:  ->
    @widget = {}
    @Broker = window.Malefic._broker

    @widget.login = new window.LoginWidget()
    @widget.login.Ready( ->
      console.log('Login Loaded')
    )

    @widget.toolbar = new window.ToolBarWidget()
    @widget.toolbar.Ready( ->
      console.log('Toolbar Loaded')
    )

    @widget.realtime = new window.RealtimeWidget()
    @widget.realtime.Ready( =>
      console.log('Realtime Loaded')
      # In fake mode stream some bullshit
      if window._fake is true
        time_window_name = 'minute'
        time_window = 60000
        @widget.realtime.ChildrenReady = =>
          console.log('Realtime Children Loaded')
          settings =
            time_window_name: time_window_name,
            time_window: time_window
          console.log(settings)
          @Broker.Trigger('data:realtimestats:config', settings)

        # time_window_name = 'second'
        # time_window = 1000

        time_slice = 100
        running_hits = 0
        total_hits = 0
        running_interactions = 0
        total_interactions = 0
        canvas = @Q('[data-id="sv:context:ui:graph"]')
        setInterval( =>
          next = Math.random()
          up_or_down = 1
          if Math.random() > 0.4
            up_or_down = -1

          running_hits += next * up_or_down
          if running_hits < 0
            running_hits = 0
          total_hits += running_hits

          running_interactions += next * up_or_down * 0.25 * Math.random()
          if running_interactions < 0
            running_interactions = 0
          total_interactions += running_interactions

          ##############
          size = canvas.height / (window.devicePixelRatio || 1)
          if running_hits > size * 0.45
            running_hits -= size/2 * Math.random()

          stats =
            time_slice: time_slice,
            hits_per_time_slice: running_hits * (time_window / time_slice),
            total_hits: total_hits,
            interactions_per_time_slice: running_interactions * (time_window / time_slice),
            total_interactions: total_interactions

          @Broker.Trigger('data:realtimestats:set', stats)
          @Broker.Trigger('data:realtime:set', hits: running_hits * (time_window / time_slice))
        , time_slice)
    )

    @widget.interactions = new window.InteractionsWidget()
    @widget.interactions.Ready( ->
      console.log('Interactions Loaded')
    )

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
        completed_interactions = 0
        canvas = @Q('[data-id="sv:context:ui:graph"]')
        setInterval( =>
          next = Math.random() / 3.0
          up_or_down = 1
          if Math.random() > 0.4
            up_or_down = -1

          running_hits += next * up_or_down
          if running_hits < 0
            running_hits = 0
          total_hits += running_hits

          current_interactions = next * up_or_down * 0.25 * Math.random()
          running_interactions += current_interactions
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

          networks = ['images/twitter.png', 'images/facebook.png']
          concaters = ['', '-', '_', 'x', '']
          names_p1 = ['Llama', 'Bob', 'Shitz', 'Cobra', 'Grim', 'Nicknak', 'Tits', 'Dick']
          names_p2 = ['Of', 'For', 'Warrior', 'Hero', 'Evil', 'Quest', 'So', 'Eater']
          names_p3 = ['Doom', 'Hire', 'McGee', 'Man', 'Boss', 'Seeker', 'Big', 'Pimp']

          len = parseInt(total_interactions) - completed_interactions
          return if len <= 0

          shuffle = (text, char=' ') ->
            text_array = text.split('')
            n = parseInt(text_array.length * 0.25)
            while n--
              text_array.splice(Math.floor(Math.random() * (text_array.length+1)), 0, char)
            text_array.join('')

          for i in [0...len]
            @Broker.Trigger('data:collections:add', {
              network_icon: networks[parseInt(Math.random() * networks.length)],
              handle: names_p1[parseInt(Math.random() * names_p1.length)] + concaters[parseInt(Math.random() * concaters.length)] +
                      names_p2[parseInt(Math.random() * names_p2.length)] + concaters[parseInt(Math.random() * concaters.length)] +
                      names_p3[parseInt(Math.random() * names_p3.length)],
              interactions: {content: shuffle(@Random(Math.random() * 256)).substring(0,22) + '..'} for a in [0..(Math.random()*5)],
              time: new Date()
            })
            completed_interactions++

        , time_slice)
    )

    @widget.interactions = new window.InteractionsWidget()
    @widget.interactions.Ready( ->
      console.log('Interactions Loaded')
    )

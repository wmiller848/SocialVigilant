#
#  William C Miller
#

class window.RealtimeStatsWidget extends window.Malefic.View

  Context: '[data-id="sv:context:ui:realtime:stats"]'

  Template: 'tmpl/realtime_stats.hbs'

  Events:
    'hide:widget:toolbar': 'hide'
    'show:widget:toolbar': 'show'
    'lock:widget:toolbar': 'lock'
    'unlock:widget:toolbar': 'unlock'

  Data:
    'Title': 'realtimestats',
    'Model':
      'Stats': null

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
    @Log('RealtimeStatsWidget Widget Loaded')
    #@Hide()

    @Broker.On('data:realtimestats:config', (settings) =>
      @Data.Model.time_window = settings.time_window
      @Data.Model.time_window_name = settings.time_window_name
    )

    @Broker.On('data:realtimestats:set', (stats) =>
      @Data.Model.Stats = stats

      @Data.Model.hits_per_time_slice = parseInt(stats.hits_per_time_slice)
      @Data.Model.total_hits = parseInt(stats.total_hits)

      @Data.Model.interactions_per_time_slice = parseInt(stats.interactions_per_time_slice)
      @Data.Model.total_interactions = parseInt(stats.total_interactions)

      @Render()
    )

  OnBind: ->
    @Log('RealtimeStatsWidget Binded Widget')

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

window.Malefic._broker = new window.Malefic.Stream()

class window.Core
  constructor:  ->
    @widget = {}

    @widget.login = new window.LoginWidget()
    @widget.login.Ready( ->
      console.log('Login Loaded')
    )

    @widget.toolbar = new window.ToolBarWidget()
    @widget.toolbar.Ready( ->
      console.log('Toolbar Loaded')
    )

    @widget.realtime = new window.RealtimeWidget()
    @widget.realtime.Ready( ->
      console.log('Realtime Loaded')
    )

    @widget.interactions = new window.InteractionsWidget()
    @widget.interactions.Ready( ->
      console.log('Interactions Loaded')
    )

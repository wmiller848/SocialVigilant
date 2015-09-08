#
#  William C Miller
#

class window.LoginWidget extends window.Malefic.View

  Context: '[data-id="sv:context:ui:window"]'

  Template: 'tmpl/login.hbs'

  Events:
    'hide:widget:toolbar': 'hide'
    'show:widget:toolbar': 'show'
    'lock:widget:toolbar': 'lock'
    'unlock:widget:toolbar': 'unlock'

  Data:
    'title': 'login'

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
    # Alerts
    ########
    'alert_failure': '[data-id="sv:context:ui:login:alert_failure"]'

    # Required
    ##########
    'username': '[data-id="sv:data:username"]'
    'password': '[data-id="sv:data:password"]'
    'password_verify': '[data-id="sv:data:password_verify"]'
    'submit': '[data-id="sv:data:submit"]'

    # Optional
    ##########
    'keypair_file': '[data-id="sv:data:keypair_file"]'
    'keypair': '[data-id="sv:data:keypair"]'
  Loaded: ->
    @Log('LoginWidget Widget Loaded')
    #@Hide()

    setTimeout( =>
      if @Cache('user_logged_in') is true
        return @_onLogin(@Cache('user'))
    , 200)

  OnBind: ->
    @Log('LoginWidget Binded Widget')

    @Show(@container)
    @Hide(@Elements.alert_failure)

    @Elements.submit.on('click', (e) =>
      e.preventDefault()
      @Hide(@Elements.alert_failure)
      username = @Elements.username.value
      password = @Elements.password.value
      @_onLoginFailure() if username.length is 0 or password.length is 0
      # # We transform the string into an arraybuffer.
      # buf = new TextEncoder("utf-8").encode(password)
      # hash_promise = crypto.subtle.digest("SHA-256", buf)
      # hash_promise.then((hash) ->
      #   console.log('Things....')
      #   console.log(hash)
      # )

      if window._fake is true
        if username is 'test_user' and password is 'password'

          now = new Date()
          created = new Date()
          # console.log(now, created)
          @_onLogin(
            pubKey: null,
            pubUserID: @Random(128),
            accessToken: @Random(256),
            userName: username,
            accounts: [
              {
                network: 'facebook',
                handle: 'jwiggles'
              },
              {
                network: 'twitter',
                handle: 'silentwiggles'
              }
            ],
            selectors: [
              {
                key: 'wiggles',
                created: created.toUTCString(),
                modified: now.toUTCString()
              },
              {
                key: 'purple balls',
                created: created.toUTCString(),
                modified: now.toUTCString()
              },
              {
                key: 'rob mighty',
                created: created.toUTCString(),
                modified: now.toUTCString()
              },
              {
                key: 'the magic room',
                created: created.toUTCString(),
                modified: now.toUTCString()
              }
            ]
          )
        else
          # console.log('Auth failed')
          @_onLoginFailure()
      else
        console.log("Do AJAX stuff")
    )

  _onLoginFailure: ->
    @Show(@Elements.alert_failure)
    @Elements.username.value = ''
    @Elements.password.value = ''
    setTimeout( =>
      @Hide(@Elements.alert_failure)
    , 2000)

  _onLogin: (user) ->
    @Cache('user_logged_in', true, true)
    @Cache('user', user, true)
    overlay = @Q('[data-id="sv:context:ui:window"]')
    @Hide(overlay)
    @Broker.Trigger('widget:main', user)

  _onCreate: (user) ->
    console.log(user)

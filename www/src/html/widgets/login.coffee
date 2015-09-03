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

  OnBind: ->
    @Log('LoginWidget Binded Widget')
    @Show(@container)

    @Elements.submit.on('click', (e) =>
      console.log(e)
      e.preventDefault()

      username = @Elements.username.value
      password = @Elements.password.value
      # We transform the string into an arraybuffer.
      buf = new TextEncoder("utf-8").encode(password)
      hash_promise = crypto.subtle.digest("SHA-256", buf)
      hash_promise.then((hash) ->
        console.log('Things....')
        console.log(hash)
      )

      if window._fake is true
        @_onLogin(
          pubkey: null,
          userid: @Random(128),
          username: username,
          accounts: [
            {
              network: 'facebook',
              handle: 'jwiggles'
            },
            {
              network: 'twitter',
              handle: 'silentwiggles'
            }
          ]
        )
      else
        console.log("Do AJAX stuff")
    )

  _onLogin: (user) ->
    console.log(user)
    overlay = @Q('[data-id="sv:context:ui:window"]')
    @Hide(overlay)
    @Broker.Trigger('widget:main')

  _onCreate: (user) ->
    console.log(user)

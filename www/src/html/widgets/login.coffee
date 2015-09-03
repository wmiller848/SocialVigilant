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
    console.log(@)
    @Show(@container)

    console.log(@)
    @Elements.submit?.on('submit', (e) =>
      console.log(e, @)
      e.preventDefault()
    )

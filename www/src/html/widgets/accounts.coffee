#
#  William C Miller
#

class window.AccountsWidget extends window.Malefic.View

  Context: '[data-id="sv:context:ui:interactions:accounts"]'

  Template: 'tmpl/accounts.hbs'

  Events:
    'hide:widget:toolbar': 'hide'
    'show:widget:toolbar': 'show'
    'lock:widget:toolbar': 'lock'
    'unlock:widget:toolbar': 'unlock'

  Data:
    'Title': 'accounts',
    'Model':
      'Accounts': null

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
    @Log('AccountsWidget Widget Loaded')
    #@Hide()

    @Broker.On('widget:accounts:set', (accounts) =>
      # console.log('!!Accounts:Set!!', accounts)
      @Data.Model.Accounts = accounts
      list = _.reduce(accounts, (memo, account) ->
        memo.push(account.handle)
        memo
      , [])
      @Data.Model.AccountsList = list.toString()
      @Data.Model.AccountsList = @Data.Model.AccountsList.substring(0,9) + '..' if @Data.Model.AccountsList.length > 9
      @Render()
    )

  OnBind: ->
    @Log('AccountsWidget Binded Widget')

    @Elements.fullscreen?.on('click', =>
      @Actions['fullscreen']()
    )
    @Elements.account?.on('click', =>
      @Actions['select']('account')
    )

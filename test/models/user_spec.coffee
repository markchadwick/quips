test    = require '../setup'
expect  = require('chai').expect
$       = require 'jqueryify'

User = require 'models/user'


describe 'User Model', ->
  beforeEach ->
    @state = test.create()

  afterEach ->
    @state.destroy()

  it 'should provide a default form error', (done) ->
    test.when 'POST', '/session/', (req) ->
      status: 403

    deferred = User.authenticate('bad', 'login')
    deferred.fail (msg) ->
      expect(msg).to.equal 'Invalid Login'
      done()

  it 'should accept a custom form error', (done) ->
    test.when 'POST', '/session/', (req) ->
      status: 403
      body: '{"password": "You must return here with a shrubbery"}'

    deferred = User.authenticate('bad', 'login')
    deferred.fail (msg) ->
      expect(msg).to.equal 'You must return here with a shrubbery'
      done()

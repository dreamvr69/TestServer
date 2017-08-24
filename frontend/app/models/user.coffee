`import DS from 'ember-data'`

User = DS.Model.extend
  email:                 DS.attr 'string'
  name:                  DS.attr 'string'
  mobile:                DS.attr 'string'
  sex:                   DS.attr 'string'
  age:                   DS.attr 'number'
  authDate:              DS.attr 'string'
  selectedClubName:      DS.attr 'string'
  selectedFranchiseName: DS.attr 'string'

  password:              DS.attr 'string'
  passwordConfirmation:  DS.attr 'string'

  isAdmin:        DS.attr 'boolean'
  isOwner:        DS.attr 'boolean'
  isAdminOrOwner: DS.attr 'boolean'
  isClient:       DS.attr 'boolean'

  rolesList:     DS.attr()

  userType:     DS.belongsTo 'user-type'
  franchise:    DS.belongsTo 'franchise'
  selectedClub: DS.belongsTo 'club', { inverse: 'selectedAdmin'}
  clubs:        DS.hasMany   'club'

  loyalty:      DS.belongsTo 'loyalty'

  createdPushes: DS.hasMany 'push', { inverse: 'creator' }
  createdScoreHistories: DS.hasMany 'history/score', { inverse: 'manager' }

  formattedAuthDate: Ember.computed 'authDate', ->
    if @get('authDate')?
      moment(@get('authDate')).format('DD.MM.YYYY H:m')
    else
      'Еще не авторизован'

  panelAccountsScope: Ember.computed 'isOwner', 'isAdmin', 'isAdminOrOwner', ->
    if @get('isOwner')
      ''
    else if @get('isAdmin')
      'franchise_users'
    else
      'club_users'

`export default User`

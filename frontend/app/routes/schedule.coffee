`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ScheduleRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
#   TODO FIX
    return this.get('store').findAll('project');

  # setupController: (controller, model) ->
  #   controller.set 'model',     model
  #   controller.set 'types',     @store.findAll('workout/type')
  #   controller.set 'templates', @store.findAll('workout/template')
  #   controller.set 'scheduleTemplates', @store.findAll('schedule-template')
  #   controller.set 'coaches',   @store.findAll('coach')
  #   controller.set 'events',   @store.findAll('event')
  #
  #   workout = @get('store').createRecord('workout')
  #   @get('session.currentUser').then (user) ->
  #     workout.set 'club', user.get('selectedClub')
  #   controller.set 'workout', workout

`export default ScheduleRoute`

`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

NewClientController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  session: Ember.inject.service()
  selectedClub: null

  actions:
    save: ->
      @get('model').save().then (model) =>
        @transitionToRoute 'client', model.id
        @scrollToTop()
        @showToast('Клиент успешно создан!')

    clubOnSelect: (club) ->
      @set 'model.clubs', []
      @get('model.clubs').pushObject club

`export default NewClientController`

`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

NewCoachController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  store: Ember.inject.service('store')
  selectedTrainingPackage: null

  selectedTrainingPackageObserver: Ember.observer 'selectedTrainingPackage', ->
    if !Ember.isEmpty(@get('selectedTrainingPackage'))
      @get('model.trainingPackages').pushObject @get('selectedTrainingPackage')
      @set 'selectedTrainingPackage', null

  actions:
    save: ->
      @get('model').save().then (model) =>
        @get('model.coachEducations').forEach (education, i) ->
          education.save()
        @get('model.coachAchievements').forEach (achievement, i) ->
          achievement.save()
        @get('model.coachSpecializations').forEach (specialization, i) ->
          specialization.save()
        @transitionToRoute 'coach', model.id
        @showToast('Тренер успешно создан!')

    removePackage: (tmpPackage) ->
      @get('model.trainingPackages').removeObject(tmpPackage)

    deleteItem: (item) ->
      item.destroyRecord()
      @showToast('Запись удалена!')

    addEducation: ->
      @get('store').createRecord('coach/education', {coach: @get('model')})
      @showToast('Запись создана!')

    addAchievement: ->
      @get('store').createRecord('coach/achievement', {coach: @get('model')})
      @showToast('Запись создана!')

    addSpecialization: ->
      @get('store').createRecord('coach/specialization', {coach: @get('model')})
      @showToast('Запись создана!')

`export default NewCoachController`

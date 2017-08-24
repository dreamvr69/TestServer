`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

EditCoachController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  store: Ember.inject.service('store')
  selectedTrainingPackage: null

  selectedTrainingPackageObserver: Ember.observer 'selectedTrainingPackage', ->
    if !Ember.isEmpty(@get('selectedTrainingPackage'))
      @get('model.trainingPackages').pushObject @get('selectedTrainingPackage')
      @set 'selectedTrainingPackage', null

  actions:
    save: ->
      @get('model').save().then =>
        @get('model.coachEducations').forEach (education, i) ->
          education.save()
        @get('model.coachAchievements').forEach (achievement, i) ->
          achievement.save()
        @get('model.coachSpecializations').forEach (specialization, i) ->
          specialization.save()
        @transitionToRoute 'coach', @get('model.id')
        @scrollToTop()
        @showToast('Тренер успешно сохранен!')

    removePackage: (tmpPackage) ->
      @get('model.trainingPackages').removeObject(tmpPackage)

    deleteItem: (item) ->
      item.destroyRecord()
      @showToast('Запись удалена!')

    deleteImage: ->
      @set 'model.imageUrl', null
      @set 'model.removeImage', true
      @showToast('Изображение помечено как удаленное!')
      return false

    addEducation: ->
      @get('store').createRecord('coach/education', {coach: @get('model')})
      @showToast('Запись создана!')

    addAchievement: ->
      @get('store').createRecord('coach/achievement', {coach: @get('model')})
      @showToast('Запись создана!')

    addSpecialization: ->
      @get('store').createRecord('coach/specialization', {coach: @get('model')})
      @showToast('Запись создана!')

`export default EditCoachController`

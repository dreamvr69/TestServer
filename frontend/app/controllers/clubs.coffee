`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`

ClubsController = Ember.Controller.extend ToastMixin,
  session: Ember.inject.service()
  queryParams: ['scope', 'page', 'perPage']
  scope: null
  page: 1
  perPage: 10

  paginationContent: Ember.computed 'model.meta.current_page', 'model.meta.total_pages', ->
    {
      page: @get('model.meta.current_page')
      totalPages: @get('model.meta.total_pages')
    }

  isPaginationEnabled: Ember.computed.gt 'model.meta.total_pages', 1

  actions:
    changePage: (num) ->
      @set('page', num)

    show: (club) ->
      @transitionToRoute 'club', club.id

    edit: (club) ->
      @transitionToRoute 'edit-club', club.id

    destroy: (club) ->
      if confirm('Удалить клуб?')
        club.destroyRecord()
        @showToast('Клуб успешно удален!')

`export default ClubsController`

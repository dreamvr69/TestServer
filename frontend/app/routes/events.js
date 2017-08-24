import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return this.get('store').findAll('project');
  },
  afterModel(models, transition){
    console.log(models.get('length'));
  }
});

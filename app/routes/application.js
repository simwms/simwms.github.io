import Ember from 'ember';

export default Ember.Route.extend({
  queryParams: {
    modal: {
      refreshModel: true
    }
  },
  actions: {
    closeModal () {
      this.set("modal", null);
    }
  }
});

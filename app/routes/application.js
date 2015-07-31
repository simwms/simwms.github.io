import Ember from 'ember';

export default Ember.Route.extend({
  queryParams: {
    modal: {
      refreshModel: true
    }
  },
  model () {
    return this.get("currentUser");
  },
  actions: {
    closeModal () {
      this.set("modal", null);
    }
  }
});

import Ember from 'ember';

export default Ember.Controller.extend({

  disableBackSpace: function() {
    Ember.$(document).on("keydown", function (e) {
      if (e.which === 8 && !Ember.$(e.target).is("input, textarea")) {
          e.preventDefault();
      }
    });
  }.on('init')

});

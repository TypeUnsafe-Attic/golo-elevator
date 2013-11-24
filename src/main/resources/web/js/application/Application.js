define([
  'jquery',
  'underscore',
  'backbone',
  'bootstrap',
  'lazy'
], function(
		$, _, Backbone
	, bootstrap
  , Lazy)
{

  var Application = Lazy.Application.extend({ // application is a router

    routes : {
        "help": "help"    // #help
      , '*actions': 'defaultAction'
    },

    initialize : function() { //initialize models, collections and views ...

    },
    help : function(){
      console.log("=== HELP ===");
    },
    defaultAction: function(action) {
      console.log("defaultAction", action)
    }
  });

    return Application;
});

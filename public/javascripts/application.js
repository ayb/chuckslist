// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe('dom:loaded', function() {  
  // add some lowpro
  Event.addBehavior.reassignAfterAjax = true;  
  Event.addBehavior({
    'a.clone:click' : function(e) {
      
      // jquery is much nicer... w
      $("image_attachment").insert({
        after: "<br /><input type='file' name='image_attachments[]' />"
      });            
    }
  });
}); 


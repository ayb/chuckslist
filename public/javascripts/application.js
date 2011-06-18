// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function validate_new_ad_form()
{	

   // Regular Expression to validate email formats
   var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

   // Must enter a Title
   if( document.getElementById('title').value == "" ) {
    	alert('Please enter a Title');
		document.getElementById('title').focus();
   		return false;
   };

   // Must enter a Description
   if( document.getElementById('ad').value == "" ) {
    	alert('Please enter a Description');
		document.getElementById('ad').focus();
   		return false;
   };

   // Must enter an Email
   if( document.getElementById('email').value == "" ) {
    	alert('Please enter an Email');
		document.getElementById('email').focus();
   		return false;
   };

   // Invalid email format
   var address = document.getElementById('email').value;
   if(reg.test(address) == false) {
      alert('Invalid Email Address Format');
	  document.getElementById('email').focus();
      return false;
   }

   // Must enter a Verification Email
   if( document.getElementById('email_verify').value == "" ) {
    	alert('Please enter a Verification Email');
		document.getElementById('email_verify').focus();
   		return false;
   };

   // Invalid email format
   var address = document.getElementById('email_verify').value;
   if(reg.test(address) == false) {
      alert('Invalid Email Address Format');
	  document.getElementById('email_verify').focus();
      return false;
   }

   // Must enter a Verification Email Does Not Match Email
   if( document.getElementById('email_verify').value != document.getElementById('email').value ) {
    	alert('Email Address Does Not Match');
		document.getElementById('email_verify').focus();
   		return false;
   };

  //alert('This is cool...haha...hahahaha...haha');
  // Everything passed(return true) - submit form
  //document.forms["form_name"].submit();
  return true;
}

function validate_update_ad_form()
{	

   // Must enter a Title
   if( document.getElementById('title').value == "" ) {
    	alert('Please enter a Title');
		document.getElementById('title').focus();
   		return false;
   };

   // Must enter a Description
   if( document.getElementById('ad').value == "" ) {
    	alert('Please enter a Description');
		document.getElementById('ad').focus();
   		return false;
   };

  //alert('This is cool...haha...hahahaha...haha');
  // Everything passed(return true) - submit form
  //document.forms["form_name"].submit();
  return true;
}
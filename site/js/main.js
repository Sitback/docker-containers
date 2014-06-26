//(function ($) {

var images = new Array()
function preload() {
  for (i = 0; i < preload.arguments.length; i++) {
    images[i] = new Image()
    images[i].src = preload.arguments[i]
  }
}

function loopHeaders(){
  var current_header = jQuery('#headerbkgd > #header-img');
  var new_header_class = 'c1';

  //if (!header_class) new_header_class = 'c1';
  if (jQuery(current_header).hasClass('c1')) new_header_class = 'c2';
  if (jQuery(current_header).hasClass('c2')) new_header_class = 'c3';
  if (jQuery(current_header).hasClass('c3')) new_header_class = 'c1';

  jQuery(current_header).fadeOut('fast', function() {
    jQuery(current_header).removeClass().addClass(new_header_class).fadeIn('fast');
  });

  setTimeout(loopHeaders, 8000);
};

jQuery(document).ready(function(){

  loopHeaders();

  preload(
    "https://hudhosting.com/images/header-blazing-fast-servers.jpg",
    "https://hudhosting.com/images/header-phone-support.jpg",
    "https://hudhosting.com/images/header_formspring.jpg"
  );

  jQuery('#nav li').hover(function() {
    jQuery(this).find('ul').fadeIn('fast');
  }, function() {
    jQuery(this).find('ul').fadeOut('fast');
  });


	jQuery("input[type=password], input[type=text], textarea").focus(function(){
		val = jQuery(this).attr('def');
		if (jQuery(this).val() == val) jQuery(this).val('');
		jQuery(this).blur(function(){
			if (jQuery(this).val() == '') jQuery(this).val(val);
		});
	});

	jQuery(".fx").click(function(){
		jQuery(this).addClass("hit");
	});
	jQuery(".fx").blur(function(){
		jQuery(this).removeClass("hit");
	});

	//contact form
	jQuery('#contactForm .form-submit').click(function(){
		if (!jQuery('#fname').val()){
			alert('Full Name is required.');
			jQuery('#fname')[0].focus();
			return false;
		}
		if (!jQuery('#fphone').val()){
			alert('Phone Number is required.');
			jQuery('#fphone')[0].focus();
			return false;
		} else if (jQuery('#fphone').val().search(/[0-9\-()\s+]{8,}$/i) == -1){
			alert('Enter a valid Phone Number');
			jQuery('#fphone')[0].focus();
			return false;
		}
		if (!jQuery('#fmessage').val()){
			alert('Message field is required.');
			jQuery('#fmessage')[0].focus();
			return false;
		}
	});

});

//})(jQuery);
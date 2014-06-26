/* Copyright (c) 2008 Jordan Kasper
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * Copyright notice and license must remain intact for legal use
 * Requires: jQuery 1.2+
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS 
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN 
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 * Fore more usage documentation and examples, visit:
 *          http://jkdesign.org/imagecheck/
 * 
 * Basic usage:
    <label for='someCheckbox'>Check it?</label>
    <input type='checkbox' id='someCheckbox' />
    
    $('#someCheckbox').simpleImageCheck({
      image: 'unchecked.png',             // String The image source to show when the checkbox IS NOT checked (REQUIRED) 
      imageChecked: 'checked.png',        // String The image source to show when the checkbox IS checked (REQUIRED)
      afterCheck: function(isChecked) {   // Function Optional callback function for when the image/checkbox is toggled
        // do something if isChecked === true
      }
    });
 * 
 * Note that when hovered, the image will have a class called 
 * imageCheckHover allowing you to alter its appearance if desired
 * 
 * TODO:
 *   Full testing suite
 *   tri/multi-state checkboxes
 *   broadcast hover events in addition to imageCheckHover class?
 * 
 * REVISIONS:
 *   0.1 Initial release
 * 
 */
;(function($) {
  $.fn.simpleImageCheck = function(o) {
    var n = this;
	//console.log("%o", n[1]);
    if (n.length < 1) { return n; }
    
    // Set up options (and defaults)
    o = (o) ? o : {};
	
    //o = auditOptions(o);
    
    n.each(function() {
      var i = $(this);
      if (i.is(':checkbox')) {
        setup(i, o);
      }
    });
    return n;
  };
  
  var setup = function(n, o){
    var c = $(n).is(':checked');
    var src = o.image;
    if (c) { src = o.imageChecked; }
    
    // set id on input if it doesn't have one
    var id = n.attr('id');
    if (typeof(id) === 'undefined') {
      id = n.attr('id', 'imageCheckInput_'+$.fn.simpleImageCheck.uid++).attr('id');
    }
    
    // use text of label for alt and title on image
    var t = $('label[for="'+id+'"]').text();
	
    // Create image node
    var im = n.before("<img src='"+src+"' id='ic_"+id+"' alt='"+t+"' title='"+t+"' class='imageCheck"+((c)?' checked':'')+"' role='checkbox' aria-checked='"+((c)?'true':'false')+"' aria-controls='"+id+"' />")
    .parent()
    .find('img#ic_'+id);
    
      // attach handlers to the original input node to redirect to ours
      $(n).next().click(function(e, triggered){
		//$(n[0]).css('background', 'red');
        // Avoid infinite loop & double checking
        if (triggered === true) { return; }
        handleClick(n, im, o, true);
      });
      $(n).next().keypress(function(e){
        var k = (e.which) ? e.which : ((e.keyCode) ? e.keyCode : 0);
        // trigger on space or enter keys
        if (k == 13 || k == 32){
          e.preventDefault();
		  console.log("%o", this);
          $(this).prev().click();
		  //handleClick(n, im, o, true);
        }
      });
      // Hide the original input box
      //.next().hide();
    
      // make image look 'clickable'
      /*$(im).css({cursor: 'pointer'})
      // attach handlers to the image
      .click(function(e){
        e.preventDefault();
		handleClick(n, im, o, false);
      });*/
	  
      /*.keypress(function(e){
        var k = (e.which) ? e.which:((e.keyCode) ? e.keyCode : 0);
        // trigger on space or enter keys
        if (k == 13 || k == 32){
          e.preventDefault();
          //$(this).click();
        }
      })*/
      // add class to image on hover
      /*.hover(
        function() {
          $(this).addClass('imageCheckHover');
        },
        function() {
          $(this).removeClass('imageCheckHover');
        }
      );*/
  }
  
  var handleClick = function(n, im, o, inputClick){
    // determine if we need to check input box. i.e. if input is 
    // checked and img has 'checked' class, need to flip it
    //if (im.hasClass('checked') === n.is(':checked') && !inputClick) {
	var hasclass = ($(im).attr('class').indexOf('checked') <= -1) ? true : false;
	if (hasclass === $(n).is(':checked') && !inputClick){
      n.trigger('click', true).change();
    }
    // Now toggle the image source and change attributes to complete the ruse
    var c = $(n).next().is(':checked');
    $(im)
      .toggleClass('checked')
      .attr({
        'aria-checked': ''+((c) ? 'true' : 'false'),
        'src': ''+((c) ? o.imageChecked : o.image)
      });
    
    // Timeout to allow for 'checking' to occur before callback
    setTimeout(function() {  
      //o.afterCheck(c);
    }, 25);
  }
  
  // Defined outside simpleImageCheck to allow for usage during construction
  /*var auditOptions = function(o) {
    //if (!$.isFunction(o.afterCheck)) { o.afterCheck = function() {}; }
		o.afterCheck = function() {};
    //
	if (typeof(o.image) != 'string') { o.image = ''; }
	if (typeof(o.imageChecked) != 'string') { o.imageChecked = ''; }
    return o;
  }*/
  
  // Static properties
  $.fn.simpleImageCheck.uid = 0;
  
})(jQuery);
$(document).ready(function(){
  // Add scrollspy to <body>
  $('body').scrollspy({
  	//target: ".navbar", 
  	offset: 50
  });   

  // Add smooth scrolling on all links inside the navbar
  $("a").on('click', function(event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
        event.preventDefault();

        // Store hash
        var hash = this.hash;

        // Using jQuery's animate() method to add smooth page scroll
        // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
        $('html, body').animate({
          scrollTop: $(hash).offset().top
        }, 800, function(){
     
          // Add hash (#) to URL when done scrolling (default click behavior)
          // window.location.hash = hash;
        });
    }  // End if
  });
});

// $(document).ready(function(){

//      $('a[href*=#]').click(function() {

//      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'')
//          && location.hostname == this.hostname) {

//              var $target = $(this.hash);

//              $target = $target.length && $target || $('[name=' + this.hash.slice(1) +']');

//              if ($target.length) {

//                  var targetOffset = $target.offset().top;

//                  $('html,body').animate({scrollTop: targetOffset}, 1000);

//                  return false;

//             }

//        }

//    });

// });
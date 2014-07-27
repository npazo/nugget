$(document).ready(function() {
    $('.nugget_img').hover(function() {
      var newWidth = $(this).width() * 3;
      var newHeight = $(this).height() * 3;

      $(this).css({
        position: "relative",
        zIndex: 1000,
        width: newWidth,
        height: newHeight,
        maxWidth: "none",
        maxHeight: "none"
        });
    
    }, 
function() {
        $(this).css({
          width: "initial",
          height: "initial",
          maxWidth: "100px",
          maxHeight: "100px",
          zIndex: 0
          });
    });


    $('.nugget_img').click(function() {

      var newWidth = $(this).width() * 3;
      var newHeight = $(this).height() * 3;

      $(this).css({
          width: "initial",
          height: "initial",
          maxWidth: "100px",
          maxHeight: "100px",
          zIndex: 0
          });
    
    });

});
$(document).ready(function(){
  $(".b_describe").mouseenter(function(){
    $(this).css("overflow-y","scroll");
  });
  $(".b_describe").mouseleave(function(){
    $(this).css("overflow-y","hidden");
  });
});

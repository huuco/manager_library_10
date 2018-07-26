$(document).ready(function(){
  $(".b_describe").mouseenter(function(){
    $(this).css("overflow-y","scroll");
  });
  $(".b_describe").mouseleave(function(){
    $(this).css("overflow-y","hidden");
  });

  $(".filter-show").click(function(e){
    e.preventDefault();
    $(".filter").toggle("fast");
  });

  if ($("#book-describe").height() < $("#book-describe p").height()){
    $("#read-more").removeClass("hidden");
  }
  $("#read-more").click(function(e){
    e.preventDefault();
    $("#book-describe").removeClass("book-describe");
    $(this).addClass("hidden");
    $("#show-less").removeClass("hidden");
  });
  $("#show-less").click(function(e){
    e.preventDefault();
    $("#book-describe").addClass("book-describe");
    $(this).addClass("hidden");
    $("#read-more").removeClass("hidden");
  });
});

$(window).on("shown.bs.modal", function(){
  $("#date-borrow").change(function(){
    date_return();
  });
  $("#num-days").change(function(){
    date_return();
  });
});

function date_return(){
  var date = new Date($("#date-borrow").val());
  var newdate = new Date(date);
  var num = parseInt($("#num-days").val());
  
  newdate.setDate(newdate.getDate() + num);
  var dd = newdate.getDate();
  var mm = newdate.getMonth() + 1;
  var yyyy = newdate.getFullYear();
  $("#date_return").html(mm +"/"+ dd +"/"+ yyyy);
};

$(document).ready(function() {
  $("#_all").click(function() {
    $("#_role").val("");
    $("#search-users").submit();
    return false;
  });
  $("#_users").click(function() {
    $("#_role").val(0);
    $("#search-users").submit();
    return false;
  });
  $("#_managers").click(function() {
    $("#_role").val(1);
    $("#search-users").submit();
    return false;
  });
  $("#_admins").click(function() {
    $("#_role").val(2);
    $("#search-users").submit();
    return false;
  });
});

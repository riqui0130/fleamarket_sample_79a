$(function () {
  $("li.Header__left--category").hover(function () {
    $("ul.category1").toggle()});
  $("li.Header__left--category li").hover(function () {
    $(">ul", this).toggle();
  }, function () {
    $(">ul", this).toggle();
  });
});
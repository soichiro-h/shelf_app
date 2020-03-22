// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

//= require popper
//= require bootstrap
//= require bootstrap-sprockets




/*=========================
        Universal
=========================*/

//flash
$(function(){
  setTimeout("$('.notice').fadeOut('slow')", 1500);
})

/*=========================
         Button
=========================*/

//submit
var submit = function(){
    $('form').submit();
}

//booksページへ
var toBooks = function(){
    window.location.href = '/books'; 
}

//detailsページへ
var toDetails = function(id){
    window.location.href = '/details/'+ id; 
}

/*=========================
          Menu
=========================*/


var openMenu = function(){
  $('.menu_side_area').css('transform', 'translate(0)');
  $('.layer').css('opacity', '1');
  $('.layer').css('visibility', 'visible');
}

var closeMenu = function(){
  $('.menu_side_area').css('transform', 'translate(300px)')
  $('.layer').css('opacity', '0');
  $('.layer').css('visibility', 'hidden');
}

var btnClick = function(){
  $('#btn2').css('background', '#f00');
}


/*=========================
          Tags
=========================*/

var updateTags = function(){
  document.tags.submit();
}

$(document).on('click touchstart',function(e) {
   if(!$(e.target).closest('.tag_wrapper').length) {
     document.tags.submit();
   } else {
    
   }
});


/*=========================
        Book_new
=========================*/

// plus video_url
let num = 3 
var addVideo_url = function(){
  $('#last').before('<div id="vf_' + num + '" class="col-12 video_url_field "><input type="text" class="video_url" name="[videos][' + num + ']" placeholder="YouTubeのURL" ><button type="button" id="' + num + '" class="delete_video" onclick="deleteVideo_url(this)"><i id=""class="fas fa-times"></i></button></div>');
  num ++
}

// delete video_url
var deleteVideo_url = function(ele){
  var id_value = ele.id
  $('#vf_' + id_value).remove();
}

//　エンターキー無効
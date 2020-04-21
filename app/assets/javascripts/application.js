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

var toBackPage = function(id){
    window.history.back(-1) ; return false;
}



// Ajax のメソッド

    //var div = document.getElementById('test');
    //div.innerHTML = "<%= @books.count %>";
    
    
    //var url = "/test";
    //var div = document.getElementById('test');
    //ajaxUpdate(url, div);


function ajaxUpdate(url, element) {
    url = url + '?ver=' + new Date().getTime();
    var ajax = new XMLHttpRequest;
    ajax.open('GET', url, true);
    ajax.onload = function () {
       //　element.innerHTML = ajax.responseText;
    };
    ajax.send(null);
}

//file uploader

$(function() {
     $('#files').css({
         'position': 'absolute',
         'top': '-9999px'
     })
     
     .change(function() {
         var val = $(this).val();
         var path = val.replace(/\\/g, '/');
         var match = path.lastIndexOf('/');
    $('#filename').css("display","inline-block");
         $('#filename').val(match !== -1 ? val.substring(match + 1) : val);
     });
     $('#filename').bind('keyup, keydown, keypress', function() {
         return false;
     });
     $('#filename, #btn_file_uploader').click(function() {
         $('#files').trigger('click');
     });
 });


/*=========================
       Menu drawer
=========================*/


var openMenu = function(){
  $('.menu_side_area').css('transform', 'translate(0)');
  $('.layer').css('opacity', '1');
  $('.layer').css('visibility', 'visible');
  
  no_scroll();
  
}

var closeMenu = function(){
  $('.menu_side_area').css('transform', 'translate(300px)')
  $('.layer').css('opacity', '0');
  $('.layer').css('visibility', 'hidden');
  
  return_scroll() ;
  
}

var btnClick = function(){
  $('#btn2').css('background', '#f00');
  $('body').css('background', '#f00');
}

function no_scroll() {
    // PCでのスクロール禁止
    document.addEventListener("mousewheel", scroll_control, { passive: false });
    // スマホでのタッチ操作でのスクロール禁止
    document.addEventListener("touchmove", scroll_control, { passive: false });
}

function return_scroll() {
    // PCでのスクロール禁止解除
    document.removeEventListener("mousewheel", scroll_control, { passive: false });
    // スマホでのタッチ操作でのスクロール禁止解除
    document.removeEventListener('touchmove', scroll_control, { passive: false });
}
function scroll_control(event) {
    event.preventDefault();
}

/*=========================
          Tags
=========================*/

var saveTags = function(){
  $('.tag_form').submit();
}

$(window).bind("load", function(){
    if(document.URL.match(/tag-new/) ) {
    	
    	$('#create_tag').modal({
          show: true
        })
            	
    }else{
        
    }
});

var clearErrors = function(){
    if(document.URL.match(/tag-new/) ) {
        window.location.href = '/clear_tags_error';
    }
}


/*=========================
        Profile
=========================*/

var editComment = function(){
     $('#edit_comment').removeClass("no_display");
     $('#display_comment').addClass("no_display");
     $('.edit_comment').addClass("no_display");
     $('.save_comment').removeClass("no_display");
}

var saveComment = function(){
    $('#comment_form').submit(); 
}

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

/*=========================
       Books_index
=========================*/

//　tooltips
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

var cxlTooltip = function(){
  setTimeout("$('#tooltip_add_book').tooltip('hide')", 350);
}

//不要 onclick 消す
var displayGuess = function(){
  //  $('#guess_area').addClass("guess_area_margin");
  //  setTimeout("$('#guess_area').removeClass('no_display')", 1000);
}


var submitGuessBook = function(book){
    $(book).parent().submit();
}


var sortBy = function(){
    $('#sort_by').submit(); 
}

var openTagsArea = function(){

  //if #collapse_sort_area .collapse show
   $('.card-body').css('padding', '20px 0');
   $('.btns').css('margin-right', '15px');
  
  if ($('#collapse_sort_area').hasClass('tags')){
    //$('#collapse_sort_area').removeClass("show");
    $('#collapse_sort_area').removeClass("tags");
    
  }else if ($('#collapse_sort_area').hasClass('order')){
    $('#collapse_sort_area').removeClass("show");
    //$('#collapse_sort_area').collapse('hide')
    $('#order_area').css('display', 'none');
    $('#tags_area').css('display', 'block');
    
    $('#collapse_sort_area').removeClass("order");
    $('#collapse_sort_area').addClass("tags");
    
    $('#collapse_sort_area').collapse({
      show: true
    })
    
  }else{
    $('#order_area').css('display', 'none');
    $('#tags_area').css('display', 'block');
    
    $('#collapse_sort_area').addClass("tags");
  }
}

var openOrderArea = function(){
  
  $('.card-body').css('padding', '20px 15px');
  $('.btns').css('margin-right', '0');
  
  if ($('#collapse_sort_area').hasClass('order')){
    $('#collapse_sort_area').removeClass("order");
    //$('#collapse_sort_area').removeClass("show");
    
  }else if ($('#collapse_sort_area').hasClass('tags')){
    //$('#collapse_sort_area').collapse('hide')
    $('#collapse_sort_area').removeClass("show");
    
    $('#tags_area').css('display', 'none');
    $('#order_area').css('display', 'block');
    
    //$('#collapse_sort_area').collapse('hide')
    //$('#collapse_sort_area').collapse('show')
    $('#collapse_sort_area').removeClass("tags");
    $('#collapse_sort_area').addClass("order");
    //$('#collapse_sort_area').addClass("show");
    
    $('#collapse_sort_area').collapse({
      show: true
    })
    
    
  }else{
    $('#tags_area').css('display', 'none');
    $('#order_area').css('display', 'block');
    
    $('#collapse_sort_area').addClass("order");
  }
}


//チェックボックス全外し
var allClear = function() {
   var nums = document.sort_form.elements.length; // チェックボックスの数
   for( i=0 ; i<nums ; i++ ) {
      document.sort_form.elements[i].checked = false; // ON・OFFを切り替え
   }
}


var switchToGallery = function() {
 
     $('#switch_to_thumb').removeClass("no_display");
     $('#switch_to_gallery').addClass("no_display");
     $('.books_card_wrapper_center').addClass("no_display");
     $('.books_card_wrapper_right').addClass("no_display");
     $('.card_books').addClass("for_gallery");
     $('.for_gallery_row').addClass("row");
     $('.for_gallery_col').addClass("col-3");
}

var switchToThumb = function() {
  
     $('#switch_to_gallery').removeClass("no_display");
     $('#switch_to_thumb').addClass("no_display");
     $('.books_card_wrapper_center').removeClass("no_display");
     $('.books_card_wrapper_right').removeClass("no_display");
     $('.card_books').removeClass("for_gallery");
     $('.for_gallery_row').removeClass("row");
     $('.for_gallery_col').removeClass("col-3");
}

var toggleOn = function(ele) {
    //主語として使うときは、$(ele) と書く
    a = $(ele).parent().parent().find('input[name="sort_by"]');
    a.prop('checked', true);
}

//card_books

$(function() {
  
  var num = ($('.card_books').length);
  
  for ( var i = 1; i <= num; i++){
  var book = $("#book_"+ i)
  var title = book.children('.books_card_wrapper_center').children('.title_card_books');
  var memo = book.children('.books_card_wrapper_center').children('.memo_card_books');
  
    if ( title.height() == 32 ){
      memo.css('max-height', '48px');
    }
  }
})
  /*
  var book = $("#book_1")
  var title = book.children('.books_card_wrapper_center').children('.title_card_books');
  console.log(title.height());
  console.log($('.card_books').length)
 
  var memo = book.children('.books_card_wrapper_center').children('.memo_card_books');
  
  if ( title.height() == 32 ){
    memo.css('max-height', '48px');
  }
  */
  

//ループ

/*

for ([初期化式]; [条件式]; [加算式])
for (let i = 1; i =< $('.card_books').length; i++){
  var book = $("'#book_' + i")
  var title = book.children('.books_card_wrapper_center').children('.title_card_books');
  var memo = book.children('.books_card_wrapper_center').children('.memo_card_books');
  
  if ( title.height() == 32 ){
    memo.css('max-height', '48px');
  }


book_1 
books_card_wrapper_center
card_title


$("#book_1").children('.books_card_wrapper_center').children('.card_title');

book_1 
books_card_wrapper_center
memo_card_books


//book_title が２行の時だけ
// title height 取得
// >= xx
// memo css max-height: xxx; を追加
//book_memo を max-height 3行分に！


*/


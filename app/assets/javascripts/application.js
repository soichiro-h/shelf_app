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
         Debug
=========================*/

$(function(){
  var ws = window.innerWidth;
  console.log(ws)
})


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

//チェックボックスデフォルトへ

var orderReset = function() {
    allClear();
    
    $('#sort_by_updated_at').prop('checked', true);
    $('#updated_at_desc').prop('checked', true);
    $('#created_at_desc').prop('checked', true);
    $('#title_asc').prop('checked', true);
    
}

//display, gallery

$(function() {
  var gallery = sessionStorage.getItem('gallery');
    if( gallery == 'true'){
        switchToGallery();
    }
})

var switchToGallery = function() {
 
     $('#switch_to_thumb').removeClass("no_display");
     $('#switch_to_gallery').addClass("no_display");
     $('.books_card_wrapper_center').addClass("no_display");
     $('.books_card_wrapper_right').addClass("no_display");
     $('.card_books').addClass("for_gallery");
     $('.image_card_books').addClass("img_for_gallery");
     $('.for_display_row').addClass("gallery");
     $('.for_display_row').removeClass("thumb");
     
     sessionStorage.setItem('gallery', 'true' );
     
     displayRow();
}

var switchToThumb = function() {
  
     $('#switch_to_gallery').removeClass("no_display");
     $('#switch_to_thumb').addClass("no_display");
     $('.books_card_wrapper_center').removeClass("no_display");
     $('.books_card_wrapper_right').removeClass("no_display");
     $('.card_books').removeClass("for_gallery");
     $('.image_card_books').removeClass("img_for_gallery");
     $('.for_display_row').removeClass("gallery");
     $('.for_display_row').addClass("thumb");
     
     sessionStorage.removeItem('gallery');
     
     adjustCardMemoHeight();
     displayRow();
}

var toggleOn = function(ele) {
    a = $(ele).parent().parent().find('input[name="sort_by"]');
    a.prop('checked', true);
}

//card_books

function adjustCardMemoHeight() {
  
  var num = ($('.card_books').length);
  
  for ( var i = 1; i <= num; i++){
  var book = $("#book_"+ i)
  var title = book.children('.books_card_wrapper_center').children('.title_card_books');
  var memo = book.children('.books_card_wrapper_center').children('.memo_card_books');
  
    if ( title.height() == 32 ){
      memo.css('max-height', '48px');
    }
  }
}


/*=========================
       Responsive
=========================*/


$(function() {
    tagsRow();
    displayRow();
    adjustCardMemoHeight();
    mobileOr();
})

//ウィンドウサイズ変更時に更新
window.onresize = window_load;

//ディスプレイ調整
function window_load() {
    tagsRow();
    displayRow();
    adjustCardMemoHeight();
}

function tagsRow(){
    var sW = window.innerWidth;
    
  if( sW >= 992 ){
 $('.tag_col').addClass("col-3");
    $('.tag_col').removeClass("col-6");
  }else{
 $('.tag_col').addClass("col-6");
    $('.tag_col').removeClass("col-3");
  }
}

function removeDisplayCol(){
    $('.for_display_col').removeClass("col-1-5");
    $('.for_display_col').removeClass("col-2");
    $('.for_display_col').removeClass("col-3");
    $('.for_display_col').removeClass("col-4");
    $('.for_display_col').removeClass("col-6");
    $('.for_display_col').removeClass("col-12");
}

function displayRow(){
    var sW = window.innerWidth;
    
    removeDisplayCol();
    
    if($('.for_display_row').hasClass('gallery')){
        
        if( sW >= 1200 ){
            $('.for_display_col').addClass("col-1-5");
      }else if ( sW >= 768 ){
         $('.for_display_col').addClass("col-2");
        }else{
            $('.for_display_col').addClass("col-3");
        }
        
    }else{
        
        if( sW >= 1200 ){
            $('.for_display_col').addClass("col-4");
      }else if ( sW >= 768 ){
         $('.for_display_col').addClass("col-6");
        }else{
            $('.for_display_col').addClass("col-12");
        }
    }
}

/*=========================
         Mobile
=========================*/

function mobileOr() {
    var ua = navigator.userAgent;
    if ((ua.indexOf('iPhone') > 0 || ua.indexOf('Android') || ua.indexOf('iPad') > 0) && ua.indexOf('Mobile') > 0) {
        
        // books index のみ
        $('.card_books').addClass("for_mobile_size");
        $('.search_field').addClass("for_mobile_size");
        $('.sort_btns').addClass("for_mobile_size");
        $('#btn_plus_book').addClass("for_mobile_size");
        $('.sort_window').addClass("for_mobile_size");
        $('.search_btn').addClass("for_mobile_size");
        
        $('.for_display_row').addClass("for_display_row_mb");
        $('.for_display_row').addClass("gallery_mb");
        $('#btn_plus_book').addClass("btn_plus_book_mb");
        $('.sort_area').addClass("sort_area_mb");
        $('.search_btn').addClass("search_btn_mb");
        $('.guess_wrapper > .btn_wrapper').addClass("btn_wrapper_mb");
        
  
        // side menu
        $('.icon_close_menu').addClass("for_mobile_size");
        $('.icon_close_menu').addClass("icon_close_menu_mb");
        $('.menu_list').addClass("for_mobile_size");
        
        
        // tag ページ
        
        $('#tag_page').addClass("tag_page_mb");
        $('.tag_col > .tag_wrapper').addClass("tag_wrapper_mb");
        $('.tag_col > .tag_wrapper').removeClass("tag_wrapper");
        
        
        // tag index
        $('.tags_area > .tags_label').addClass("tags_label_mb");
        $('.tags_container > label').removeClass("tags_label");
        $('.tags_container > label').addClass("tags_label_mb");
        
        
        // new
        
        //$('.tag_section > .row >.tag').addClass("tag_mb");
        
        
        //details
        
        $('.tag_wrapper_details >.tags_container > .tag_field').addClass("tag_field_mb");
        $('.tag_wrapper_details >.tags_container > .tag_field_mb').removeClass("tag_field");
        
    } else {
        // PC
    
    }
}

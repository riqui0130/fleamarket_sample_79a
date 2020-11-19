// 入力フォームチェック
//クレジットカードナンバー
$(document).on('click', function(){

  $('.number').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-number').text('*入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-number').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

// 月
$(document).on('click', function(){
  $("select[ type='text' ]").on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-exp_month').text('*入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-exp_month').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});
// 年
$(document).on('click', function(){
  $("select[ type='text' ]").on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-exp_year').text('*入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-exp_year').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

// cvc
$(document).on('click', function(){
  $('.cvc').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-cvc').text('*入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-cvc').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});
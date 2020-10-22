$(document).on('turbolinks:load', function(){
  //商品名
  $('.sell-container__content__name').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-name').text('*入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-name').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
  //商品説明
  $('.sell-container__content__description').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-text').text('*入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-text').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
  //状態
  $('#status-select').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-status').text('*選択して下さい');
      $(this).css('border-color','red');
    }else{
      $('#error-status').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
  //送料負担
  $('#postage-select').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-postage').text('*選択して下さい');
      $(this).css('border-color','red');
    }else{
      $('#error-postage').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
  //発送元
  $('#prefecture-select').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-prefecture').text('*選択して下さい');
      $(this).css('border-color','red');
    }else{
      $('#error-prefecture').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
  //発送までの日数
  $('#shippingday-select').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-shippingday').text('*選択して下さい');
      $(this).css('border-color','red');
    }else{
      $('#error-shippingday').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
  //価格
  $('.sell-container__content__price__form__box').on('blur',function(){
    let value = $(this).val();
    if(value < 300 || value > 9999999){
      $('#error-price').text('*300以上9999999以下で入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-price').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});
$(document).on('turbolinks:load', function(){
  // 画像が選択された時プレビュー表示、inputの親要素のdivをイベント元に指定
  $('#image-input').on('change', function(e){

    //ファイルオブジェクトを取得する
    let files = e.target.files;
    $.each(files, function(index, file) {
      let reader = new FileReader();

      //画像でない場合は処理終了
      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        return false;
      }
      //アップロードした画像を設定する
      reader.onload = (function(file){
        return function(e){
          let imageLength = $('#output-box').children('li').length;
          // 表示されているプレビューの数を数える

          let labelLength = $("#image-input>label").eq(-1).data('label-id');
          // #image-inputの子要素labelの中から最後の要素のカスタムデータidを取得

          // プレビュー表示
          $('#image-input').before(`<li class="preview-image" id="upload-image${labelLength}" data-image-id="${labelLength}">
                                      <figure class="preview-image__figure">
                                        <img src='${e.target.result}' title='${file.name}' >
                                      </figure>
                                      <div class="preview-image__button">
                                        <a class="preview-image__button__edit">編集</a>
                                        <a class="preview-image__button__delete" data-image-id="${labelLength}">削除</a>
                                      </div>
                                    </li>`);
          $("#image-input>label").eq(-1).css('display','none');
          // 入力されたlabelを見えなくする

          if (imageLength < 9) {
            // 表示されているプレビューが９以下なら、新たにinputを生成する
            $("#image-input").append(`<label for="item_images${labelLength+1}" class="sell-container__content__upload__items__box__label" data-label-id="${labelLength+1}">
                                        <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${labelLength+1}" style="display: none;" type="file" name="item[images][]">
                                        <i class="fas fa-camera fa-lg"></i>
                                      </label>`);
          };
        };
      })(file);
      reader.readAsDataURL(file);
    });
  });

  //削除ボタンが押された時
  $(document).on('click', '.preview-image__button__delete', function(){
    let targetImageId = $(this).data('image-id');
    // イベント元のカスタムデータ属性の値を取得
    $(`#upload-image${targetImageId}`).remove();
    //プレビューを削除
    $(`[for=item_images${targetImageId}]`).remove();
    //削除したプレビューに関連したinputを削除

    let imageLength = $('#output-box').children('li').length;
    // 表示されているプレビューの数を数える
    if (imageLength ==9) {
      let labelLength = $("#image-input>label").eq(-1).data('label-id');
      // 表示されているプレビューが９なら,#image-inputの子要素labelの中から最後の要素のカスタムデータidを取得
      $("#image-input").append(`<label for="item_images${labelLength+1}" class="sell-container__content__upload__items__box__label" data-label-id="${labelLength+1}">
                                  <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${labelLength+1}" style="display: none;" type="file" name="item[images][]">
                                  <i class="fas fa-camera fa-lg"></i>
                                </label>`);
    };
  });

  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function categoryOption(category){
      var optionHtml = `<option value="${category.id}">${category.name}</option>`;
      return optionHtml;
    }
    // 親カテゴリー選択後のイベント
    $('#category-select-parent').on('change', function(){
      let parentCategoryId = $(this).val();
      //選択された親カテゴリーのIDを取得
      if (parentCategoryId == ''){
        //親カテゴリーが空（初期値）の時
        $('#select-children-box').remove();
        $('#select-grandchildren-box').remove();
        //子と孫を削除するする
      }else{
        $.ajax({
          url: '/items/category_children',
          type: 'GET',
          data: { parent_id: parentCategoryId },
          dataType: 'json'
        })
        .done(function(category_children){
          $('#select-children-box').remove();
          $('#select-grandchildren-box').remove();
          //親が変更された時、子と孫を削除するする
          let optionHtml = '';
          category_children.forEach(function(child){
            optionHtml += categoryOption(child);
            //option要素を作成する
          });
          $('#error-category').before(`<div class="sell-collection_select " id="select-children-box">
                                          <label class="sell-collection_select__label" for="item_category_id">
                                            <select class="sell-collection_select__input" id="category-select-children" required="required" name="item[category_id]">
                                              <option value="">選択して下さい</option>
                                              ${optionHtml}
                                            </select>
                                            <i class="fas fa-chevron-down"></i>
                                          </label>
                                        </div>`
          );
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        });
      }
    });
    // 子カテゴリー選択後のイベント
    $('.sell-container__content__details').on('change', '#category-select-children', function(){
      let childrenCategoryId = $(this).val();
      //選択された子カテゴリーのIDを取得
      if (childrenCategoryId == ''){
        //子カテゴリーが空（初期値）の時
        $('#select-grandchildren-box').remove(); 
        //孫以下を削除する
      }else{
        $.ajax({
          url: '/items/category_grandchildren',
          type: 'GET',
          data: { child_id: childrenCategoryId },
          dataType: 'json'
        })
        .done(function(category_grandchildren){
          $('#select-grandchildren-box').remove();
          //子が変更された時、孫を削除するする
          let optionHtml = '';
          category_grandchildren.forEach(function(grandchildren){
            optionHtml += categoryOption(grandchildren);
            //option要素を作成する
          });
          $('#error-category').before(`<div class="sell-collection_select " id="select-grandchildren-box">
                                          <label class="sell-collection_select__label" for="item_category_id">
                                            <select class="sell-collection_select__input" id="category-select-grandchildren" required="required" name="item[category_id]">
                                              <option value="">選択して下さい</option>
                                              ${optionHtml}
                                            </select>
                                            <i class="fas fa-chevron-down"></i>
                                          </label>
                                        </div>`
          );
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        });
      }
    });
  });


  // 各フォームの入力チェック
  $(function(){
    //画像
    $('#image-input').on('focus',function(){
      $('#error-image').text('');
      $('#image-input').on('blur',function(){
        $('#error-image').text('');
        let imageLength = $('#output-box').children('li').length;
        if(imageLength ==''){
          $('#error-image').text('画像がありません');
        }else if(imageLength >10){
          $('#error-image').text('画像を10枚以下にして下さい');
        }else{
          $('#error-image').text('');
        }
      });
    });

    //送信しようとした時
    $('form').on('submit',function(){
      let imageLength = $('#output-box').children('li').length;
      if(imageLength ==''){
        $('body, html').animate({ scrollTop: 0 }, 500);
        $('#error-image').text('画像がありません');
      }else if(imageLength >10){
        $('body, html').animate({ scrollTop: 0 }, 500);
        $('#error-image').text('画像を10枚以下にして下さい');
      }else{
        return true;
      }
    });

     //画像を削除した時
    $(document).on('click','.preview-image__button__delete',function(){
      let imageLength = $('#output-box').children('li').length;
      if(imageLength ==''){
        $('#error-image').text('画像がありません');
      }else if(imageLength >10){
        $('#error-image').text('画像を10枚以下にして下さい');
      }else{
        $('#error-image').text('');
      }
    });

    //商品名
    $('.sell-container__content__name').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-name').text('入力してください');
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
        $('#error-text').text('入力してください');
        $(this).css('border-color','red');
      }else{
        $('#error-text').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //カテゴリーのエラーハンドリング
    function categoryError(categorySelect){
      let value = $(categorySelect).val();
      if(value == ""){
        $('#error-category').text('選択して下さい');
        $(categorySelect).css('border-color','red');
      }else{
        $('#error-category').text('');
        $(categorySelect).css('border-color','rgb(204, 204, 204)');
      }
    };
    //親カテゴリー
    $('#category-select-parent').on('blur',function(){
      categoryError('#category-select-parent')
    });
    //子カテゴリー
    $('.sell-container__content__details').on('blur', '#category-select-children', function(){
      categoryError('#category-select-children')
    });
    //孫カテゴリー
    $('.sell-container__content__details').on('blur', '#category-select-grandchildren', function(){
      categoryError('#category-select-grandchildren')
    });

    //状態
    $('#condition-select').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-condition').text('選択して下さい');
        $(this).css('border-color','red');
      }else{
        $('#error-condition').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //送料負担
    $('#deliverycost-select').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-deliverycost').text('選択して下さい');
        $(this).css('border-color','red');
      }else{
        $('#error-deliverycost').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //発送元
    $('#pref-select').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-pref').text('選択して下さい');
        $(this).css('border-color','red');
      }else{
        $('#error-pref').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //発送までの日数
    $('#delivery_days-select').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-delivery_days').text('選択して下さい');
        $(this).css('border-color','red');
      }else{
        $('#error-delivery_days').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //価格
    $('.sell-container__content__price__form__box').on('blur',function(){
      let value = $(this).val();
      if(value < 300 || value > 9999999){
        $('#error-price').text('300以上9999999以下で入力してください');
        $(this).css('border-color','red');
      }else{
        $('#error-price').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });
  });  
});
$(document).on('turbolinks:load', function(){
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
        url: '/items/get_category_children',
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
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childrenCategoryId },
        dataType: 'json'
      })
      .done(function(category_grandchildren){
        $('#select-grandchildren-box').remove();
        //子が変更された時、孫を削除する
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
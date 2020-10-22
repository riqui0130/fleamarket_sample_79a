$(document).on('turbolinks:load', function(){
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(inserthtml){
    var childSelectHtml = '';
    childSelectHtml = `<select class="sell-collection_select__category__a" id="child_category" name="item[category_id]">
                          <option value>選択して下さい</option>
                          ${inserthtml}
                        </select>`;
    $('.sell-collection_select__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(inserthtml){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<select class="sell-collection_select__category__a" id="grandchild_category" name="item[category_id]">
                              <option value>選択して下さい</option>
                              ${inserthtml}
                            </select>`;
    $('.sell-collection_select__category').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    var parentCategoryId = document.getElementById('parent_category').value;
    if (parentCategoryId != ''){
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: { parent_id: parentCategoryId },
        dataType: 'json'
      })
    .done(function(children){
      $('#child_category').remove();
      $('#grandchild_category').remove();
      var inserthtml = '';
      children.forEach(function(child){
        inserthtml += appendOption(child);
      });
      appendChidrenBox(inserthtml);
    })
    .fail(function(){
      alert('カテゴリー取得に失敗しました');
    })
    }else{
    $('#child_category').remove(); //親カテゴリーが初期値になった時、子以下を削除する
    $('#grandchild_category').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('#child_category').on('change', function(){
    var childCategoryId = document.getElementById('child_category').value;
    if (childCategoryId != ''){
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childCategoryId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_category').remove();
          var inserthtml = '';
          grandchildren.forEach(function(grandchild){
            inserthtml += appendOption(grandchild);
          });
          appendGrandchidrenBox(inserthtml);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      });
    }else{
      $('#grandchild_category').remove();
    }
  });
});

$(document).on('turbolinks:load', function(){
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }

  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<select class="sell-collection_select__category" id="child_category" name="item[category_id]">
                          <option value>選択して下さい</option>
                          ${insertHtml}
                        </select>`;
    $('.sell-collection_select').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<select class="sell-collection_select__category" id="grandchild_category" name="item[category_id]">
                              <option value>選択して下さい</option>
                              ${insertHtml}
                            </select>`;
    $('.sell-collection_select').append(grandchildSelectHtml);
  }

    // 親カテゴリー選択後のイベント
    $('#parent_category').on('change', function(){
      var parentCategory = document.getElementById('parent_category').value;
      if (parentCategory != ''){
        $.ajax({
          url: '/items/category_children',
          type: 'GET',
          data: { parent_id: parentCategoryId },
          dataType: 'json'
        })
      .done(function(children){
        $('#child_category').remove();
        $('#grandchild_category').remove();
        var insertHtml = '';
        children.forEach(function(child){
          insertHtml += appendOption(child);
        });
        appendChidrenBox(insertHTML);
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
  $('.sell-collection_select').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != ''){
      $.ajax({
        url: '/items/category_grandchildren',
        type: 'GET',
        data: { child_id: childrenCategoryId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_category').remove();
          var insertHtml = '';
          category_grandchildren.forEach(function(grandchild){
            insertHtml += categoryOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      });
    }else{
      $('#grandchild-category').remove();
    }
  }); 
});

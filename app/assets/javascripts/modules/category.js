$(document).on('turbolinks:load', function(){
  function appendOption(category){
    var Html = `<option value="${category.id}">${category.name}</option>`;
    return Html;
  }

  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHtml){
    var childSelectHtml = '';
    childSelectHtml = `<select class="sell-collection_select__category__a" id="child_category" name="item[category_id]">
                          <option value>選択して下さい</option>
                          ${insertHtml}
                        </select>`;
    $('.sell-collection_select__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHtml){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<select class="sell-collection_select__category__a" id="grandchild_category" name="item[category_id]">
                              <option value>選択して下さい</option>
                              ${insertHtml}
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
        var insertHtml = '';
        children.forEach(function(child){
          insertHtml += appendOption(child);
        });
        appendChidrenBox(insertHtml);
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
          var insertHtml = '';
          grandchildren.forEach(function(grandchild){
            insertHtml += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHtml);
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

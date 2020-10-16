$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<select class="sell__item-category" id="child_category" name="item[category_id]">
                            <option value="---">選択してください</option>
                            ${insertHTML}
                          </select>`;
    $('.parent_category').after(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `    <select class="sell__item-category" id="grandchild_category" name="item[category_id]">
                                  <option value="---">選択してください</option>
                                  ${insertHTML}
                                  </select>`;
    $('.child-category').after(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#parent_category').change(function(){
    e.preventDefault();
    var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
    if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/items/get_category_children',
          type: 'GET',
          data: { parent_name: parentCategory },
          dataType: 'json'
        })
        .done(function(children){
          $('#child_category').remove(); //親が変更された時、子以下を削除する
          $('#grandchild_category').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(children){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#child_category').remove(); //親カテゴリーが初期値になった時、子以下を削除する
        $('#grandchild_category').remove();
      }
    });
    // 子カテゴリー選択後のイベント
    $(document).on('change', '#child_category', function(){
      var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
      if (child_category_id != "---"){ //子カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/items/get_category_grandchildren',
          type: 'GET',
          data: { child_id: child_category_id },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchild_category').remove(); //子が変更された時、孫以下を削除する
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchild_category').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      }
    });
});
$(document).on('turbolinks:load', function(){
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<select class="product-form__details-container__category-box" id="child_category" name="item[category_id]">
                        <option value>選択してください</option>
                        ${insertHTML}
                      </select>`;
    $('.sell-collection_select__category').append(childSelectHtml);
  }
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<select class="product-form__details-container__category-box" id="grandchild_category" name="item[category_id]">
                              <option value>選択してください</option>
                              ${insertHTML}
                            </select>`;
    $('.sell-collection_select__category').append(grandchildSelectHtml);
  }

  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value;
    if (parentCategory != ""){
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#child_category').remove();
        $('#grandchild_category').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#child_category').remove();
      $('#grandchild_category').remove();
    }
  });
  $('.sell-collection_select__category').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != ""){
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_category').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchild_category').remove();
    }
  });
});
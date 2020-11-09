document.addEventListener("turbolinks:load",function(){
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<select class="listing-select-wrapper__box--select" id="child_category" name="item[category_id]">
                         <option value="---" data-category="---">選択してください</option>
                           ${insertHTML}
                       </select>`;
    $('#parent_category').after(childSelectHtml);
  }
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<select class="listing-select-wrapper__box--select" id="grandchild_category" name="item[category_id]">
                              <option value="aaaa" data-category="---">選択してください</option>
                                ${insertHTML}
                            </select>`;
    $('#child_category').after(grandchildSelectHtml);
  }

  $('#parent_category').change(function(e){
    e.preventDefault();
    var parentCategory = document.getElementById('parent_category').value;
    $('.category-attention').hide();
    if (parentCategory != "---"){ 
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#child_category').remove();
        $('#grandchild_category').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });
  $(document).on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != "---"){
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
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  });
});
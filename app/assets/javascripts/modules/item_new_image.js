$(document).on('turbolinks:load', function(){
  $(function(){
    const buildFileField = (num)=> {
      const html = `<div data-index="${num}" class="js-file_group">
                      <input class="js-file" type="file"
                      name="item[images_attributes][${num}][image]"
                      id="item_images_attributes_${num}_image"><br>
                    </div>`;
      return html;
    }
    const buildImg = (index, url)=> {
      const html = `<div class="preview" data-index="${index}">
                      <image src="${url}" width="100px" height="100px">
                      <div class="js-remove">削除</div>
                    </div>`;
      return html;
    }

    let fileIndex = [1,2,3,4,5,6,7,8,9,10];
    lastIndex = $('.js-file_group:last').data('index');
    fileIndex.splice(0, lastIndex);

      $('#image-box').on('change', '.js-file', function(e) {
        const targetIndex = $(this).parent().data('index');
        const file = e.target.files[0];
        const blobUrl = window.URL.createObjectURL(file);

      if (img = $('img[data-index="${targetIndex}"]')[0]) {
        img.setAttribute('src', blobUrl);
      }
      else {
        if ($(".preview").length >= 10){
          alert('添付できる画像は10枚までです')
          return false
        }
        else {
          $('#previews').append(buildImg(targetIndex, blobUrl));
          $('#image-box').append(buildFileField(fileIndex[0]));
          $("#image-label").prop("for", `item_images_attributes_${fileIndex[0]}_image`)
          fileIndex.shift();
          fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
        }
      }
      });
      
      $('.hidden-destroy').hide();
      $('#data-index').on('click', function(){
    })
    $('#image-box').on('click', '.js-remove', function() {
      const targetIndex = $(this).prev().data('index');
      const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
      if (hiddenCheck) hiddenCheck.prop('checked', true);
      const fileinput =$(`#item_images_attributes_${targetIndex}_image`);
      $(this).parent().remove();
      $(`img[data-index="${targetIndex}"]`).remove();
      fileinput.remove();
      if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
      $(`input[data-index= "${targetIndex}"]`).css({'display': `none`});
    });

    $('#image-box').on('click', '.preview-image', function() {
      const index = $(this).data("index")
      $(`#item_images_attributes_${index}_image`).click()
      $(this).parent().remove();
    });

  });
});
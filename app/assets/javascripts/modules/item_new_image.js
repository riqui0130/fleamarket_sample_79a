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

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

    $('#image-box').on('change', '.js-file', function(e) {
      const targetIndex = $(this).parent().data('index');
      // ファイルのブラウザ上でのURLを取得する
      const file = e.target.files[0];
      const blobUrl = window.URL.createObjectURL(file);

      // 該当indexを持つimgタグがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else { // fileIndexの先頭の数字を使ってinputを作る
      // 画像投稿は10枚までの制限の記述
      if ($(".preview").length >= 10){
        alert('添付できる画像は10枚までです。')
        return false
      } else {
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // for属性を使ってfileIndex[0]がクリックした画像の番号に自動生成される。
      $('#image-box').append(buildFileField(fileIndex[0]));
      $("#image-label").prop("for", `item_images_attributes_${fileIndex[0]}_image`)
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  }
  });
  // $('#image-label').attr('for', `item_images_attributes_${targetIndex + 1}_image`)
  
  $('.hidden-destroy').hide();
  $('#data-index').on('click', function(){
})

//  削除ボタン押した時
  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).prev().data('index'); //削除したい番号 $(this).parent().data('index')
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    const fileinput =$(`#item_images_attributes_${targetIndex}_image`);
    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    fileinput.remove();
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
    $(`input[data-index= "${targetIndex}"]`).css({
      'display': `none`
    })
  });
    //画像をクリックするとその画像と新しい画像を差替える。 削除をクリックすると(`#item_images_attributes_${index}_image`)のindexが削除ボタンの頭上にある画像を識別し、削除する。
  $('#image-box').on('click', '.preview-image', function() {
    const index = $(this).data("index")
    $(`#item_images_attributes_${index}_image`).click()
  });
});
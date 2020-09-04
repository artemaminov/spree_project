$(document).ready(function () {
  const body = $('body');


  const multi_wrapper = $('.file-uploader__image-multi');

  const single_wrapper = $('.file-uploader__image');

  body.on('click', '.file-uploader__button', function(e){
    e.preventDefault();

    let _this = $(this)

    _this.parent().find('.file-uploader__input').click();
  });

  body.on('change', '.file-uploader__input', function(e){
    add_files(e, $(this));
  });


  body.on('click', '.file-uploader__image-img', function(e){
    e.preventDefault();

    remove_file($(this));
  });

});

function remove_file(_this) {
  confirm_delete('Вы действительно хотите удалить?', _this)
}

function add_files(e, _this)  {
  if (_this[0].files.length > 0 ) {

    var formData = '';
    formData = new FormData();

    for (var i = 0; i < _this[0].files.length; i ++) {
      formData.append('files[]', _this[0].files[i]);
    }

    let single = true;

    if (_this.prop('multiple')) {
      single = false
    }

    formData.append('single', single)
    formData.append('name', _this.data('name'))

    $.ajax({
      url: '/admin/galleries/file_upload',
      type: 'POST',
      contentType: false,
      processData: false,
      data: formData,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    }).done(function(result){

      let name = _this.parent().find('.file-uploader__input').data('name')

      _this.parent().find('input[type="hidden"]').attr('name', name)

    }).fail(function(result){
      console.log(result);
    });

  }
}


function confirm_delete(message, _this) {
  $.confirm({
    title: 'Внимание',
    content: 'Вы действительно хотите удалить фотографию?',
    buttons: {
      yes: {
        text: 'Да',
        btnClass: 'btn-blue',
        keys: ['enter'],
        action: function(){
          _this.hide('slow', function(){ _this.remove(); });
        }
      },
      no: {
        text: 'Нет',
        btnClass: 'btn-red',
        keys: [],
        action: function(){
        }
      }

    }
  });
}
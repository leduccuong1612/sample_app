import I18n from 'i18n-js/index.js.erb'
$('#micropost_image').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1048576;
    if (size_in_megabytes > 5) {
      alert(I18n.t('alert'));
    }
  });

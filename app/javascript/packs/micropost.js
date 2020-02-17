import I18n from 'i18n-js/index.js.erb'
$('#micropost_image').on('change', function() {
    var size_in_megabytes = this.files[0].size/Settings.size;
    if (size_in_megabytes > Settings.limit.megabyte) {
      alert(I18n.t('alert'));
    }
  });

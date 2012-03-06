var select_image_by_id = function(image_id) {
  select_image($("#tmb-" + image_id));
}

var add_image_handlers = function() {
  $("#main-image").data('selectedThumb', $('#main-image img').attr('src'));
  $('ul.thumbnails li').eq(0).addClass('selected');

  $('ul.thumbnails').delegate('a', 'click', function(event) {
    select_image($(event.currentTarget).parent());
    return false;
  });
};

var select_image = function(img)
{
  var $main_image = $("#main-image");           // Container around the main image
  var $main_image_link = $("#main-image-link"); // Link around the main image
  var currentThumb = $('#' + $main_image.data('selectedThumbId'));

  if (img.length > 0 && img != currentThumb)
  {
    var thumb = $(img.eq(0));
    var $thumb_link = thumb.find('a');
    var original_img_url = $thumb_link.attr('href');
    var product_img_url = $thumb_link.data("product-image");

    $('ul.thumbnails li.selected').removeClass('selected');
    thumb.addClass('selected');
    $main_image.data('selectedThumbId', thumb.attr('id'));

    $('#main-image img').attr('src', product_img_url);
    $("#main-image-link").attr('href', original_img_url);

    $main_image.trigger('change');
  }
}

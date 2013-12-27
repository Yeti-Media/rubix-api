$(function () {
    $('#file').fileupload({
        dataType: 'json',
        done: function (e, data) {
              var res = data.result;
              var scenario= new Image();
              scenario.src = res.scenario_url;
              $('#matches').html('');
              $('#detection').html(scenario);
              $.each(res.values, function(i, value){
                $('#matches').html("<li><img src='"+ value.pattern_url +"' /></li>");
                var label_link = $('<a class="label_link">*</a>');
                label_link.css({position: 'absolute', top: value.center.y, left: value.center.x});
                label_link.attr({href: "http://" + value.label, target: '_new'});
                $('#detection').append(label_link);
              });
            }
    });
});

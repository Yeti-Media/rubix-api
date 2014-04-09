$(function () {
    $('#feature_file').fileupload({
        dataType: 'json',
        done: function (e, data) {
              var res = data.result;
              var scenario= new Image();
              scenario.src = res.scenario_url;
              $('#matches').html('');
              $('#detection').html(scenario);
              $('#json_response').html(JSON.stringify(res));
              prettyPrint();
              $.each(res, function(i, value){
                $('#matches').append("<div><img src='"+ value.url +"' class='img-thumbnail' /></div>");
                var label_link = $('<a class="label_link">*</a>');
                label_link.css({position: 'absolute', top: value.center.y, left: value.center.x, background: 'white', border: '3px solid blue', 'border-radius': '5px'});
                label_link.attr({href: "http://" + value.label, target: '_new'});
                $('#detection').append(label_link);
                $.each(value.keypoints, function(n,keypoint){
                  var kp = $('<div class="keypoint"></div>');
                  kp.css({position: 'absolute', top: keypoint.pos.y, left: keypoint.pos.x, 
                          border: '3px solid yellow', 'border-radius': '5px',
                          width: 10, height: 10});
                  $('#detection').append(kp);
                });
              });
            }
    });
    $('#histogram_file').fileupload({
        dataType: 'json',
        done: function (e, data) {
              var res = data.result;
              var scenario= new Image();
              scenario.src = res.scenario_url;
              $('#matches').html('');
              $('#detection').html(scenario);
              $('#json_response').html(JSON.stringify(res));
              $.each(res.matches, function(i, value){
                $('#matches').append("<div><img src='"+ value.pattern_url +"' class='img-thumbnail' /></div>");
              });
            }
    });
    $('#ocr_file').fileupload({
        dataType: 'json',
        done: function (e, data) {
              var res = data.result;
              var scenario= new Image();
              scenario.src = res.scenario_url;
              $('#detection').html(scenario);
              $('#json_response').html(JSON.stringify(res));
            }
    });
});

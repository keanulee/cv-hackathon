$(document).ready(function() {
  $("#resumes-list").each(function(){
    $.get("/resumes.json", function(data) {

      var i,j,k;
      for (i = 0; i < data.length; ++i) 
      {
        var source    = $("#resume-template").html();
        var template  = Handlebars.compile(source);

        var context = {
          name: data[i].name,
          id:   data[i].id
        };
        var html = template(context);

        $("ul#resumes-list").append(html);

        $('#section-create-' + data[i].id).editable({
          url: '/sections/',
          title: 'Enter new section',
          success: function() {
            location.reload();
          }
        });

        for(j = 0; j < data[i].sections.length; ++j)
        {
          var source   = $("#section-template").html();
          var template = Handlebars.compile(source);
          
          var section = data[i].sections[j];
          var context = {
            name: section.name,
            id:   section.id
          };
          var html = template(context);
          
          $("ul#sections-list-" + data[i].id).append(html);
          
          $('#part-create-' + section.id).editable({
            url: '/parts/',
            title: 'Enter new part',
            success: function() {
              location.reload();
            }
          });

          for(k = 0; k < section.parts.length; ++k)
          {
            var source   = $("#part-template").html();
            var template = Handlebars.compile(source);

            var part    = section.parts[k];
            var context = {
              name:       part.name,
              location:   part.location,
              start_date: part.start_date,
              end_date:   part.end_date,
              notes:      part.notes,
              id:         part.id
            };
            var html = template(context);
            $("ul#parts-list-" + section.id).append(html);
          }
        }
      }

      $(".editable").editable();

      $(".delete-resume").click(function() {
        if (window.confirm("Are you sure?")) {
          var data = $(this).attr('data');
          $.ajax({
            url: '/resumes/' + $(this).attr('data'),
            type: 'DELETE',
            success: function() {
              $("#resume-"+ data ).fadeOut();
            }
          });
        }
      });

      $(".delete-section").click(function() {
        if (window.confirm("Are you sure?")) {
          var data = $(this).attr('data');
          $.ajax({
            url: '/sections/' + $(this).attr('data'),
            type: 'DELETE',
            success: function() {
              $("#section-"+ data ).fadeOut();
            }
          });
        }
      });

      $(".delete-part").click(function() {
        if (window.confirm("Are you sure?")) {
          var data = $(this).attr('data');
          $.ajax({
            url: '/parts/' + $(this).attr('data'),
            type: 'DELETE',
            success: function() {
              $("#part-"+ data ).fadeOut();
            }
          });
        }
      });
    });
  });
});

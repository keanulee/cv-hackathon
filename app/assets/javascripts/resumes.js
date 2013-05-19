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
              title: 'Enter new section'
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
              title: 'Enter new part'
          });

          $('#section-edit-' + section.id).click(function(){
            console.log('YEAAAAA');
          });
          $('#section-edit-' + section.id).editable({
              url: '/sections/' + section.id ,
              title: 'Enter new section'
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


            //Add the part-editable-field
            //init editables 
            $('.myeditable-' + part.id).editable({
                url: '/parts/'+ part.id  //this url will not be used for creating new user, it is only for update
            });
             
            //make username required
            //$('#new_username').editable('option', 'validate', function(v) {
            //    if(!v) return 'Required field!';
            //});
             
            //automatically show next editable
            $('.myeditable-' + part.id).on('save.newuser', function(){
                var that = this;
                setTimeout(function() {
                    $(that).closest('tr').next().find('.myeditable-' + part.id).editable('show');
                }, 200);
            });
            $('#save-btn-' + part.id ).click(function(e) {
              var id =  $(this).attr('val')
              $('.myeditable-' + part.id).editable('submit', { 
                   url: '/parts/' + id,
                   pk: id, 
                   ajaxOptions: {
                       dataType: 'json' //assuming json response
                   },           
                   success: function(data, config) {
                       if(data && data.id) {  //record created, response like {"id": 2}
                           //set pk
                           $(this).editable('option', 'pk', data.id);
                           //remove unsaved class
                           $(this).removeClass('editable-unsaved');
                           //show messages
                           var msg = 'New user created! Now editables submit individually.';
                           $('#msg').addClass('alert-success').removeClass('alert-error').html(msg).show();
                           $('#save-btn-'+part.id).hide(); 
                           $(this).off('save.newuser');                     
                       } else if(data && data.errors){ 
                           //server-side validation error, response like {"errors": {"username": "username already exist"} }
                           config.error.call(this, data.errors);
                       }               
                   },
                   error: function(errors) {
                       var msg = '';
                       if(errors && errors.responseText) { //ajax error, errors = xhr object
                           msg = errors.responseText;
                       } else { //validation error (client-side or server-side)
                           $.each(errors, function(k, v) { msg += k+": "+v+"<br>"; });
                       } 
                       $('#msg').removeClass('alert-success').addClass('alert-error').html(msg).show();
                   }
               });
          }).append(part.id);

          }
        }
      }

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

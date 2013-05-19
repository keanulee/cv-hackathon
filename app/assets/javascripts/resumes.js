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

        $("#resumes-list").append(html);

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
          
          $("#sections-list-" + data[i].id).append(html);
          
          $("#sections-list-" + data[i].id ).sortable();
          $("#sections-list-" + data[i].id ).disableSelection();

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
              id:         part.id,
              section_id: section.id
            };
            var html = template(context);
            $("#parts-list-" + section.id ).append(html);
            $("#parts-list-" + section.id ).sortable();
            $("#parts-list-" + section.id ).disableSelection();
          }
        }
      }

      $(".editable").editable();

      $(".resume-link").click(function() {
        var data = $(this).attr('data');
        $(".resume").hide();
        $(".resume-"+ data ).show();
        $("#export_btn").data("resume_id",data)

        $(".resume-link").attr("style","");
        $(this).attr("style","color:#e78d0e");
      });

      $(".resume-link:first").click();

      $("#export_btn").click(function() {
        var id = $(this).data("resume_id");
        $.get("/resumes/"+id+".json", function(data) {

          var doc = new jsPDF();
          console.log(data);

          // Header- Name
          doc.setFont("helvetica");
          doc.setFontType("bold");
          doc.setFontSize(30);
          doc.text(70, 20, data.contact_info.first_name + " " + data.contact_info.last_name);

          // Header- Phone, Email, Location
          doc.setFontType("italic");
          doc.setFontSize(14);
          doc.text(55, 26, data.contact_info.email + " | " + "Toronto, Ontario, Canada");
          // -- HEADER FINISHED

          var i,j;
          var height=40;
          for (i = 0; i < data.resume.sections.length; ++i) 
          {          

            // SECTION TITLE
            doc.setFontType("bold");
            doc.setFontSize(20);
            doc.text(20, height, data.resume.sections[i].name);
            height=height+15;

            for (j = 0; j < data.resume.sections[i].parts.length; ++j) 
            { 
              // PART TITLE
              doc.setFontType("italic");
              doc.setFontSize(18);
              doc.text(20, height, data.resume.sections[i].parts[j].name || "");
              height=height+7.5;

              // PART SUBTITLE
              doc.setFontType("bold");
              doc.setFontSize(16);
              doc.text(20, height, data.resume.sections[i].parts[j].location || "");
              height=height+5;

              // PART START & END DATE
              doc.setFontSize(13);
              doc.setFontType("italic");
              doc.text(20, height, data.resume.sections[i].parts[j].start_date + " - " + data.resume.sections[i].parts[j].end_date);
              height=height+7.5;


              // Part DESCRIPTION
              doc.setFontSize(11);
              doc.setFontType("normal");
              doc.text(20, height, data.resume.sections[i].parts[j].notes || "")
              height=height+30;
              // -- PART FINISHED
              // -- SECTION FINISHED
            }
          }
          doc.save(data.resume.name +'.pdf');

        });
      })

      $(".delete-resume").click(function() {
        if (window.confirm("Are you sure?")) {
          var data = $(this).attr('data');
          $.ajax({
            url: '/resumes/' + $(this).attr('data'),
            type: 'DELETE',
            success: function() {
              $(".resume-"+ data ).fadeOut();
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

        $(".pinned").pin({
            containerSelector: ".resumes"
        });
    });
  });
});

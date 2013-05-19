$(document).ready(function() {
    $.get("/resumes.json", function(data){
        //Load 
        console.log(data);

        var i,j,k;
        for (i = 0; i < data.length; ++i) 
        {
            var source   = $("#resume-template").html();
            var template = Handlebars.compile(source);
            console.log(data[i].name);
            var context = {name: data[i].name, id: data[i].id};
            var html = template(context);
            $("ul#resumes-list").append(html);


            for(j = 0; j < data[i].sections.length; ++j)
            {
                var source   = $("#section-template").html();
                var template = Handlebars.compile(source);
                
                var context = {name: data[i].sections[j].name , id: data[i].sections[j].id};
                var html = template(context);
                console.log(html);
                $("ul#sections-list-" + data[i].id).append(html);

                
                for(k = 0; k < data[i].sections[j].parts.length; ++k)
                {
                    var source   = $("#part-template").html();
                    var template = Handlebars.compile(source);
                    var context = {name: data[i].sections[j].parts[k].name, id: data[i].sections[j].parts[k].id };
                    var html = template(context);
                    console.log(html);
                    $("ul#parts-list-" + data[i].sections[j].id).append(html);
                }
            }
        }



        $(".delete-section").click(function() {
             
            var data = $(this).attr('data');
            $.ajax({
                
                url: '/sections/' + $(this).attr('data'),
                type: 'DELETE',
                success: function() {
                    $("#section-"+ data ).fadeOut();
                }
            });
        });

        $(".delete-part").click(function() {
            
            var data = $(this).attr('data');
            $.ajax({
                
                url: '/parts/' + $(this).attr('data'),
                type: 'DELETE',
                success: function() {
                    $("#part-"+ data ).fadeOut();
                }
            });
             
        });

    });
    
    
});

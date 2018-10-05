
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

//Nathaniel Watson notes:
// While in dev mode, it appears that any updates to this file are not be reflected in the browser until the browser cache
// has been cleared. This is at least the case with Google Chrome. Modifying other JS files in this directory don't appear
// to need a clearning of the browser cache, as the changes take effect immediately.

// When doing event delegation, the named event-handler methods don't appear to work; instead, one must use the .on() method. This is
// the case for both jQuery and CoffeeScript. For example, instead of:
//
//    $(funcion() {
//       $(document).click(".someClass",function() {
//          ...
//        })
//    });
//
// it should instead be:
//
//    $(function() {
//      $(document).on("click",".someClass",function() {
//        ...
//      })
//    });



// When the fa icon with class "xfade-out" is clicked, then                                            
// remove the closest container element with class "xfade". The removal will                           
// happed by fading out the element in application.js. Then, any element on the page with class        
// "fade-in" will fade in.  See an example of these classes being used in /app/views/chipseq_experiments/add_replicate.html.erb.
$(document).on("click", ".xfade-out", function(event) {
  event.preventDefault();
  $(this).closest(".xfade").fadeOut( function(event) {
    if ($(this).hasClass("xfade-remove")) {
        $(this).remove()
    }
    $(".xfade-in").fadeIn();
  })
})

//Set select inputs to show 6 rows:
//$(function() {
//  $("select",document).attr("size","8");
//})

// A click handler for elements with the class ".modal-for-image", which is geared towards
// anchor and img elements that have a picture to show up front. For example, in the index view of
// Gels, when the user clicks on the link to a gel image, this will cause a popup to show
// with the image and caption.

// First add mouseenter handler to reveal that it's clickable. 
$(function() {
    $(".modal-for-image").on("mouseenter", function(event, data) {
        event.preventDefault();
        event.stopPropagation();
        $(this).addClass("modal-content-box-shadow");
    })
})

// Second, add mouseleave to undo the above functions work. 
$(function() {
    $(".modal-for-image").on("mouseleave", function(event, data) {
        event.preventDefault();
        event.stopPropagation();
        $(this).removeClass("modal-content-box-shadow");
    })
})
        

$(function() {
    $(".modal-for-image").on("click", function(event, data) {
        event.preventDefault();
        event.stopPropagation();
        node_name = this.nodeName;
        if (node_name === "A") {
            image_url = $(this).attr("href");
        } else if (node_name == "IMG") {
            // Use $(this).attr() instead of $(this).prop() below. When using prop to access the 
            // src attribute of an image tag, the value will be prefixed with the hostname of your app
            // as an HTTP URI. Thus, even if the value of the src attribute is the empty string, when
            // accessed via prop you'll just get your apps HTTP URI as the value.
            image_url = $(this).attr("src");
        }
        if (!image_url) {
          return
        }
        // Caption is optional. If a caption is desired to be display alongside the image, then
        // the link or image tag needs to define caption as a data attribute.
        caption = $(this).data("caption");
        $.get("/welcome/modal_for_image", {"image_url": image_url, "caption": caption}, function(data) {
            $(document.body).append(data);
            $(".modal").show();
        })
    })
})

//Close flash messages with a fade out when the 'x' is clicked:
$(function() {
  $("a.close").on("click", function(event){
    event.stopPropagation();
    event.preventDefault();
    $(this).closest("div").fadeOut();
  })
})

$(function() {
  //Add edit fa-icon for editing the notes attribute of a record in the show view
  $(".notes-row strong").after('<i style="padding-left: 0.6em;" class="edit-notes-pencil fa fa-pencil"></i>')
  $(document).on("click", ".edit-notes-pencil", function(event) {
    $(".edit-notes-pencil").hide();
    orig = $(".notes-row td").html(); // Save a reference to whatever is currently there.
    // Set the td cell to a form field for the notes attribute. This form field is rendered (and initially hidden) in show.html.erb
    // from the partial at /app/views/application_partials/_edit_notes.html.erb, and has a div 
    // wrapper with class 'notes-to-edit', a Cancel button to close the form, and a Submit button 
    // to update the record.
    $(".notes-row td").html($(".notes-to-edit").clone().show());
    $(".cancel-edit-notes").on("click", function(event) {
      event.preventDefault();
      event.stopPropagation();
      $(".notes-row td").html(orig);
      $(".edit-notes-pencil").show();
    })
  })
})



$(function() {
  //Add refresh FontsAwesome icon too all labels with class 'refresh':
  $("label.refresh").after('<i class="refresh fa fa-refresh"></i>')


  //Highlight table columns in the index views when user mouses over a table cell.
  // Note that highlighting the table rows is already taken care of in application.css thanks to
  // bootstrap's .table-hover class.
  function handler_in() {
    index = $(this).index() + 1; //+1 since the first column is the row header.
    $table = $(this).closest("table.index")
    //Set background color of column to same color used in the bootstrap .table-hover class:
    $("tr td:nth-child(" + index + ")",$table).add("thead tr th:nth-child(" + index + ")",$table).css("background-color","#f5f5f5")
  }

  function handler_out() {
    $table = $(this).closest("table.index")
    //Unset background color:
    $("tr td:nth-child(" + index + ")",$table).add("thead tr th:nth-child(" + index + ")",$table).css("background-color","");
  }
  $("table.index td").add("table.index th").hover(handler_in,handler_out)


  //This block is specific for the index views with regards to displaying the model's definition.
  //For this to work properly, for a given index view you must add the class "index-page-header" to <h1> tag (or <h2>, <h3>, etc) in the
  // <header> tag and code a block element immediately after the <h1> tag with a class of 'model-definition'.
  // I suggest using a <p> tag. The textual content of the block should be a definition describing the models purpose.
  // I suggest storing the definition as a class variable within the model's own class, and referencing this within the block using ERB.
  // Take a look at app/views/crispr_modifications/index.html.erb for an example.

  $model_definition = $("header .model-definition");
  if ($model_definition.length == 1) {

    $model_definition.hide();
    //Add a fa-icon plus sign that the user can click in the <header> element to trigger the display of the model's definition.
    $(".index-page-header").css("display","inline-block").after('<span class="define-model btn fa fa-plus-square-o"></span>');
    $define_model_btn = $(".define-model"); //A button that, when clicked, expands to show the model's definition.

    $define_model_btn.on("click", function(event) {
      event.stopPropagation();
      $(this).hide();
      //First wrap definition in <div> in order to add a btn (fa-thumbs-up icon) to hide the definition content.
      // when the user clicks on it. This will only happen the first time the user clicks on the fa-plus btn.
      definition_wrapper_id = "definition_wrapper";
      $definition_wrapper = $("#" + definition_wrapper_id); //Not defined until after first click of $(".define-model").
      if ( $definition_wrapper.length == 0 ) {
        //Then this is the first time the user is clicking to view the model definition.
        $model_definition.wrap('<div id="' + definition_wrapper_id + '" style="padding: 1em; margin-bottom: 1em; background-color: #ffffcc;">');
        //See w3schools color picker at https://www.w3schools.com/colors/colors_picker.asp
        // #ffffcc is a creamy white color.
        $definition_wrapper = $("#" + definition_wrapper_id);
        //Add thumbs-up icon that, when clicked, closes the model definition.
        $model_definition.append('&nbsp;</br><span style="margin-top: 1em;font-size: 0.9em;" class="btn btn-default fa fa-thumbs-up hide-model-definition"></span>')

        //Register handler to close the definition.
        $(".hide-model-definition").on("click",function(event) {
          event.stopPropagation();
          $definition_wrapper.fadeOut("fast", function() {
            $define_model_btn.show();
          })
        })

        $model_definition.show();

      }
      else {
        $definition_wrapper.show();
      }
    })
  }


  //Delete table rows when the user clicks on the trash icon. Does so remotely w/o a page refresh.
  //Create variable that can be used in all other JavaScript files. This one is to add the asterisk next to the label
  // of an input field when the is conditional requirements. For an example of a conditional requirement, see
  // data_storages.js.coffee, which referneces this variable.
  $("a .fa-trash").on("click",function(event) {
    event.preventDefault();
    event.stopPropagation();
    if (confirm("Are you sure you want to delete this?") == true) {
      url = $(this).closest("a").attr("href");
      $rm = $(this).closest("tr");
      if ($rm.length === 0) {
        $rm = $(this).closest(".rm-on-record-del");
      }
      $.ajax(url, {
        method: "DELETE",
        dataType: "json",
        error: function(xhr,errmsg,err) {
          msg = JSON.parse(xhr.responseText)
          alert_msg = msg.exception;
          if (typeof msg.error !== "undefined") {
            alert_msg += ": " + msg.error;
          }
          alert(alert_msg);
          //alert(errmsg) //i.e. error
          //alert(xhr.status) //i.e. 55
          //alert(xhr.statusText) //i.e  Internal Server Error
        },
        success: function(data,status,xhr) {
          status_code = xhr.status;
          if (status_code == 403) {
            alert(data);
            return;
          }
          $rm.fadeOut(function(){
            $rm.remove()
          })
          if ($(event.target).closest("a").hasClass("sequencing_result")) {
            //Then make sure the btn to add new seq res is activated:
            $("#new_sequencing_result",document).removeAttr("disabled"); //See sequencing_results.js.coffee for details.
          }
        }
      })
    }
  })

  //Add spinner cursor whenever the user initiates AJAX request.
  $(document).ajaxSend(function() {
    $("body").addClass("waiting");
  })

  //Add spinner whenever a form's submit btn is clicked.
  $(document).on("click","input[type='submit']", function(event) {
    $("body").addClass("waiting");
  })


  //Remove spinner cursor when AJAX request completes.
  $(document).ajaxComplete(function() {
    $("body").removeClass("waiting")
  })

  //Add fonts awesome icon 'info-circle' after all labels that have a tooltip:
  $("label[data-toggle='tooltip']",document).append('<sup><i style="padding-left: 0.4em;" class="fa fa-info-circle"></i></sup>');
  $(document).on("click",".close-modal",function(event) {
    $(".modal").hide();
  })
  window.onclick = function(event) {
    if (event.target.className == "modal") {
      //i.e. see model in views/sequencing_requests/select_scs_plates.html.erb, which is displayed when
      // the user clicks on the "Add Single Cell Sorting plates" button on the show view of a sequencing_request.
      $(".modal").hide();
    }
  }
  $('[data-toggle="tooltip"]').attr("data-delay",800)
  $('[data-toggle="tooltip"]').tooltip({ trigger: 'hover', placement: 'right' })
  //Above I pass in { trigger: 'click' } - the default is "trigger: 'focus'". The default is an issue for
  //inputs such as checkboxes that maintain focus after selection until another elements gains focus.
});

//The code below was derived from https://devcenter.heroku.com/articles/direct-to-s3-image-uploads-in-rails.
//Also see wiki page https://github.com/blueimp/jQuery-File-Upload/wiki/Options.
$(function() {
  $('.directUpload').each(function(i, elem) {
    var $fileInput    = $(elem); //The file input field jQuery object, that is listening for change events.
    var $form         = $($fileInput.closest('form'));
    var $submitButton = $form.find('input[type="submit"]');
    var $progressBar  = $("<div class='bar'></div>");
    var $barContainer = $("<div class='progress'></div>").append($progressBar);
    $fileInput.after($barContainer);
    $fileInput.fileupload({
      fileInput:       $fileInput,
      url:             $fileInput.data('url'), //The url is set in the form view.
      type:            'POST',
      autoUpload:       true, //upload starts autom. when file is selected.
      formData:         $fileInput.data('form-data'), //includes things like AWS Access Keys.
      paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
      dataType:         'XML',  // The type of data that is expected back from the server. S3 returns XML if success_action_status (set in controller set_s3_direct_post method) is set to 201
      replaceFileInput: false,

      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $progressBar.css('width', progress + '%')
      },

      //Callback for the submit event of each file upload. If this callback returns false, the file upload request is not started.
      submit: function (e) {
        //Only allow the MIME type of text/plain since it will be programatically parsed.
        if ($fileInput.hasClass("text-only")) {
          alert("Invalid file type. Only plain text files are allowed and should have a .txt extension.");
          return false;
        }
      },

      //start: equivalent to the global ajaxStart event (but for file upload requests only)
      start: function (e) {
        $submitButton.prop('disabled', true);

        $progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...");
      },
      done: function(e, data) {
        $submitButton.prop('disabled', false);
        $progressBar.text("Uploading done");

        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = '//' + $fileInput.data('host') + '/' + key;

        // create hidden field
        var input = $("<input />", { type:'hidden', name: $fileInput.attr('name'), value: url })
        $form.append(input);
      },
      fail: function(e, data) {
        $submitButton.prop('disabled', false);
        $progressBar.
          css("background", "red").
          text("Failed");
      }
    });
  });
});


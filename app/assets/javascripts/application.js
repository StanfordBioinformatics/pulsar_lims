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

$(function() {
  //Deletes table rows when the user clicks on the trash icon. Does so remotely w/o a page refresh. 
  $("tr a .fa-trash").on("click",function(event) {
    event.preventDefault();
    event.stopPropagation();
    if (confirm("Are you sure you want to delete this?") == true) {
      url = $(this).closest("a").attr("href");
      $tr = $(this).closest("tr");
      $.ajax(url, {
        method: "DELETE", 
        dataType: "json",
        error: function(xhr,errmsg,err) {
          alert(xhr.responseText) //i.e.
          //alert(errmsg) //i.e. error
          //alert(err)    //i.e. Internal Server Error
          //alert(xhr.status) //i.e. 55
          //alert(xhr.statusText) //i.e  Internal Server Error
        },
        success: function(data,status,xhr) {
          $tr.fadeOut(function(){
            $tr.remove()
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
    $("body").addClass("waiting")
  })

  //Remove spinner cursor when AJAX request completes.
  $(document).ajaxComplete(function() {
    $("body").removeClass("waiting")
  })

  //Add fonts awesome icon 'info-circle' after all labels that have a tooltip:
  $("label[data-toggle='tooltip']",document).append('<sup><i style="padding-left: 0.1em;" class="fa fa-info-circle"></i></sup>');
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
  //$('[data-toggle="tooltip"]').attr("data-delay",900)
  $('[data-toggle="tooltip"]').tooltip({ trigger: 'click' })
  //Above I pass in { trigger: 'hover' }, since the default is "trigger: 'focus'". The default is an issue for 
  //inputs such as checkboxes that maintain focus after selection until another elements gains focus.
});

//The code below was derived from https://devcenter.heroku.com/articles/direct-to-s3-image-uploads-in-rails
$(function() {
  $('.directUpload').find("input:file").each(function(i, elem) {
    var fileInput    = $(elem);
    var form         = $(fileInput.closest('form'));
    var submitButton = form.find('input[type="submit"]');
    var progressBar  = $("<div class='bar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    fileInput.after(barContainer);
    fileInput.fileupload({
      fileInput:       fileInput,
      url:             form.data('url'),
      type:            'POST',
      autoUpload:       true, //upload starts autom. when file is selected.
      formData:         form.data('form-data'), //includes things like AWS Access Keys.
      paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
      dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
      replaceFileInput: false,
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        progressBar.css('width', progress + '%')
      },
      start: function (e) {
        submitButton.prop('disabled', true);

        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...");
      },
      done: function(e, data) {
        submitButton.prop('disabled', false);
        progressBar.text("Uploading done");

        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = '//' + form.data('host') + '/' + key;

        // create hidden field
        var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
        form.append(input);
      },
      fail: function(e, data) {
        submitButton.prop('disabled', false);
        console.log(e)

        progressBar.
          css("background", "red").
          text("Failed");
      }
    });
  });
});


function formInputs(parent){
//textareas
  if($(parent).find("textarea").length>0){
    $(parent).find("textarea:not('.no-wysiwyg')").each(function(i, elem) {
      $(elem).wysihtml5({
      	useLineBreaks: false
      });
    });
  }
//checkboxes and radios
  if($(parent).find('input[type=checkbox], input[type=radio]').length>0){$(parent).find('input').iCheck();}
//selects
  if($(parent).find("select").length>0){
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
      $(parent).find('select').selectpicker('mobile');
    } else {
      $(parent).find("select").selectpicker({
      	size: "auto",
      	selectedTextFormat: "count>3",
      	dropupAuto: false,
      	title: "Select"
      });
    }
  }
//datepicker
  if($(parent).find('.datetimepicker').length>0){
    $(parent).find('.datetimepicker').datetimepicker({
      language: "en",
      pick12HourFormat: true,
      maskInput: false,
      pickTime: false,
      pickSeconds: false
    });
    var picker = $(parent).find('.datetimepicker').data('datetimepicker');
    $(parent).find('.datetimepicker input').focus(function(){
    	picker.show()
    }).blur(function(){
    	picker.hide();
    });
  }
//slider
  if($(parent).find('input.slider').length>0){
    $(parent).find('input.slider').slider({
    	formater: function(value) {
        var minutes = value*15;
        var estimate = "";
        if(minutes>59){
        	var hours = Math.floor(minutes/60);
        	var hourFormatter = hours > 1 ? ' hours ' : ' hour '
        	var minRemaining = (minutes - hours*60) > 0 ? (minutes - hours*60) : "";
        	var minRemainingFormatter = minRemaining > 0 ? " minutes" : ""
        	estimate += hours + hourFormatter + minRemaining + minRemainingFormatter;
        } else {
        	estimate += minutes + " minutes"
        }
    		return estimate;
    	}
    });
  }
}
function onPage(page){
  return $("body").hasClass(page);
}
function loadingIcon(target){                         //loadingIcon(".loading");
  var loaderSymbols = ['0', '1', '2', '3', '4', '5', '6', '7']; 
	var loaderIndex = 0;
	loadAction = setInterval(function(){
		loaderIndex = loaderIndex  < loaderSymbols.length - 1 ? loaderIndex + 1 : 0;
		$(target).addClass("symbols").html(loaderSymbols[loaderIndex]);
	}, 100);
}
function filePreview(input){
  if(input.files && input.files[0]){
    var reader = new FileReader();
    reader.onload = function(e){
      $('.img-preview img').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

$(function(){
//show/hide flash messages
	if($('.msg').html() != ""){
		$('.site-messages').show(0);
	}
	setTimeout(function(){
		$('.site-messages').fadeOut(200);
	}, 2500);
//insert attachment
  $(document).on("click", ".fileAttachment", function(e){
  	e.preventDefault();
  	var ed = $("textarea").data("wysihtml5").editor;
  	var path = $(this).attr("href");
  	var label = $(this).data("label");
  	var ext = path.split(".").pop().replace(/\d/g, "").replace(/\?/, "");
  	var img = (ext == "jpg" || ext == "png" || ext == "gif" || ext == "jpeg" || ext == "png");
  	var host = window.location.hostname;
  	var url = "http://"+host+path;
  	ed.focus();
  	if(img){
  		ed.composer.commands.exec("insertImage", url)
  	} else {
  		ed.composer.commands.exec("insertHTML", "<a href='"+url+"'>"+label+"</a>")
  	}
  	$('#attachments').modal('hide');
  });
//file upload preview
  if(typeof(FileReader) == "undefined") {
  	$("#attachments").addClass("no-fileReader");
  }
  $("#attachment_attached_file").change(function(){
    filePreview(this);
    $(".img-preview img").css("top", (($(".img-preview").outerHeight()-$(".img-preview img").height())/2)+"px");
    $(".path-preview").html("<span class='small-text'>"+$(this).val()+"</span>");
  });
//editor mode switch
  $(".toHTML").click(function(e){
  	e.preventDefault();
  	var ed = $("textarea").data("wysihtml5").editor;
  	if (ed.currentView === ed.textarea) {
      ed.fire("change_view", "composer");
      $(".toHTML").html("HTML Mode");
      $(".wysihtml5-toolbar").show();
    } else {
      ed.fire("change_view", "textarea");
      $(".toHTML").html("Graphical Mode");
      $(".wysihtml5-toolbar").hide();
    }
  });
//submodal parent body
  $(".subModalLaunch").click(function(e){
  	$(this).closest(".modal-content").find(".modal-body").addClass("subModalShown");
  });
  $('#attachmentSubModal').on('hide', function(){
  	$("#attachmentSubModal").closest(".modal-content").find(".modal-body").removeClass("subModalShown");
  });
//load buttons
  $(document).on("click", ".load-button", function(e){
  	//e.preventDefault();
  	//var url = $(this).attr("href");
  	var l = Ladda.create( document.querySelector('.load-button') );
    l.start();
  	//$.post(url, {}, function(){
  		//setTimeout(function(){Ladda.stopAll();}, 2000);
  	//	Ladda.stopAll();
  	//});
  });
//miragejs
  $('#main').height($(window).height());
  $(document).on('click', '.skq a', function(e){
  	e.preventDefault();
  	var ix = $(this).closest('li').index();
  	$(this).closest('li').addClass('active').siblings().removeClass('active');
  	$('.skq-text').eq(ix).addClass('active').siblings().removeClass('active');
  });
  $(document).on('click', '.order_form button:not(:disabled)', function(e){
  	e.preventDefault();
  	var $button = $(this);
  	$button.prop('disabled', true);
  	var $form = $(this).closest('form');
  	var href = $form.attr('action');
  	var eighths = isNaN(parseInt($form.find('input.eighth').val())) ? 0 : parseInt($form.find('input.eighth').val());
  	var halfs = isNaN(parseInt($form.find('input.half').val())) ? 0 : parseInt($form.find('input.half').val());
  	var quantity = eighths+(halfs*4);
  	//console.log(quantity);
  	$.post(href, {quantity: quantity}, function(){
  		$form.find('input').val('');
  	});
  });
});


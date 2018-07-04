$(document).ready(function(){
  // Partial Functions
  function closeMain() {
    $(".home").css("display", "none");
  }
  function openMain() {
	$(".home").css("display", "block");
  }
  function closeAll() {
	$(".body").css("display", "none");
  }

  function openContainer() {
    $(".bank-container").css("display", "block");
  }
  function closeContainer() {
    $(".bank-container").css("display", "none");
  }
  // Listen for NUI Events
  window.addEventListener('message', function(event){
	var item = event.data;

	if(item.showUI == true) {
		openContainer();
		openMain();
	}

	if(item.showUI == false) {
		closeContainer();
		closeMain();
	}

	
	if(item.clearme == true) {
	  if(!$("#btnCar1").hasClass('btnCar')) { $("#btnCar1").addClass('btnCar'); }
	  if(!$("#btnCar2").hasClass('btnCar')) { $("#btnCar2").addClass('btnCar'); }
	  if(!$("#btnCar3").hasClass('btnCar')) { $("#btnCar3").addClass('btnCar'); }
	  if(!$("#btnCar4").hasClass('btnCar')) { $("#btnCar4").addClass('btnCar'); }
	  if(!$("#btnCar5").hasClass('btnCar')) { $("#btnCar5").addClass('btnCar'); }
	  if(!$("#btnCar6").hasClass('btnCar')) { $("#btnCar6").addClass('btnCar'); }
	  if(!$("#btnCar7").hasClass('btnCar')) { $("#btnCar7").addClass('btnCar'); }
	  if(!$("#btnCar8").hasClass('btnCar')) { $("#btnCar8").addClass('btnCar'); }
	  if(!$("#btnCar9").hasClass('btnCar')) { $("#btnCar9").addClass('btnCar'); }
	  if(!$("#btnCar10").hasClass('btnCar')) { $("#btnCar10").addClass('btnCar'); }
	  if(!$("#btnCar11").hasClass('btnCar')) { $("#btnCar11").addClass('btnCar'); }
	  if(!$("#btnCar12").hasClass('btnCar')) { $("#btnCar12").addClass('btnCar'); }
	}

	if(item.addcar == true) {
	  $("#btnCar" + item.number).removeClass('btnCar');
	  $("#btnCar" + item.number).html(item.name);
	  $("#btnCar" + item.number).attr('model', item.model);
	}
  });
  // On 'Esc' call close method
  document.onkeyup = function (data) {
	if (data.which == 27 ) {
	  $.post('http://netr_garages/close', JSON.stringify({}));
	}
  };
  // Handle Button Presses
  $("#btnCar1"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });

  // Handle Button Presses
  $("#btnCar2"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });

  // Handle Button Presses
  $("#btnCar3"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });

  // Handle Button Presses
  $("#btnCar4"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });

  // Handle Button Presses
  $("#btnCar5"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });

  // Handle Button Presses
  $("#btnCar6"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });

  // Handle Button Presses
  $("#btnCar7"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });

  // Handle Button Presses
  $("#btnCar8"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });
  
  // Handle Button Presses
  $("#btnCar9"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });
  
  // Handle Button Presses
  $("#btnCar10"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });
  
  // Handle Button Presses
  $("#btnCar11"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });
  
  // Handle Button Presses
  $("#btnCar12"). click(function(){
	var model = $(this).attr('model');
	$.post('http://netr_garages/pullCar',  JSON.stringify({ model: $(this).attr('model') }));
  });


  $(".btnClose").click(function(){
	  $.post('http://netr_garages/close', JSON.stringify({}));
	});

  $(".btnUpdate").click(function(){
	  $.post('http://netr_garages/update', JSON.stringify({}));
	});
	
  $(".btnHome").click(function(){
	  closeAll();
	  openMain();
	});


});

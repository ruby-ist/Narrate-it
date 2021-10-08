$('document').ready(function() {
	function navShadow() {
		let scrolled = $(window).scrollTop();
		if (scrolled > 10) {
			$('.nav').addClass('shadow');
		} else {
			$('.nav').removeClass('shadow');
		}
	}
	
	setInterval(navShadow, 100);
	
	function navbar() {
		let sandwich = $('.sandwich2');
		$('.sandwich').on('click', function () {
			$('.nav-items').addClass('move');
			$('.screen').css('display', 'block');
			sandwich.addClass('cross');
			sandwich.text("x");
		});
		
		$('.screen, .sandwich2').on('click', function () {
			$('.nav-items').removeClass('move');
			$('.screen').css('display', 'none');
			sandwich.removeClass('cross');
			sandwich.text("");
		});
	}
	
	setInterval(navbar, 10);
});

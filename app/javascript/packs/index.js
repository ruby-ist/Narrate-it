$('document').ready(function() {
	function navShadow() {
		let scrolled = $(window).scrollTop();
		if (scrolled > 10){
			$('nav').addClass('shadow');
		}
		else{
			$('nav').removeClass('shadow');
		}
	}
	
	setInterval(navShadow,100);
	
});
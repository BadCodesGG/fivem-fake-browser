$(document).ready(function () {
	const resourceName = window.GetParentResourceName();
	function closeAll() {
		$(".browser-container").css("opacity", 0);
		$(".body").css("opacity", 0);
	}

	function openBrowserContainer() {
		$(".body").css("opacity", 1.0);
		$(".browser-container").css("opacity", 1.0);
	}

	window.addEventListener("message", function (event) {
		let item = event.data;

		if (item.openUI === true) {
			closeAll();
			if(item.menu == 'browser'){
				openBrowserContainer();
			}
		}
		if (item.closeUI) {
			closeAll();
		}
	});

	function _keyup(e) {
		if (e.which == 27) {
			$.post(`//${resourceName}/close`, JSON.stringify({}));
			closeAll();
		}
	}

	document.onkeyup = _keyup;
});

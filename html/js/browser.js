const ToggleBrowserTabs = function () {
	let tab = $(".browser-tabs .tab");
	let tabContent = ".browser-content-item";
	$(tabContent).each(function (index, value) {
		$(this).attr("data-tab", index);
	});
	tab.click(function (e) {
		let index = $(this).data("index");
		e.preventDefault();
		tab.removeClass("tab-active");
		$(this).addClass("tab-active");
		$(tabContent).removeClass("active");
		$(tabContent + "[data-tab=" + index + "]").addClass("active");
		let url = $(this).find("span").data("url");
		$(".url").empty();
		$(".url").append(url);
	});
};

const JobCarousel = function () {
	let jobCarousel = $(".ls-carousel-job");
	jobCarousel.slick({
		dots: true,
		arrows: false,
		autoplay: true,
		autoplaySpeed: 5000,
		infinite: true
	});
};

$(function () {
	ToggleBrowserTabs();
	JobCarousel();
});

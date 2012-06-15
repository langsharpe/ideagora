// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function($){
	var displayPanel, lists, currentItem;
	
	// Set active inspected article
	function setActiveItem(article) {
		var orig = article,
			shown = article[0].cloneNode(true,false),
			previous = currentItem;

		previous && previous.removeClass("selected");
		displayPanel.empty().append(shown);
		orig.addClass("selected");
		currentItem = orig;
	}
	
	// Bind functionality of summary lists
	$.fn.ready(function() {
		displayPanel = $(".item-detail-panel");
		// Don't bother improving anything if the page didn't define a details area.
		if (!displayPanel.size())
			return;

		// Make the box float if we scroll past it.
		displayPanel.portamento({
			wrapper: $(".expandable-list")
		});

		lists = $(".summary-list");
		lists.children().each(function(i, el) {
			var item = $(el);
			// Bind the whole item to display details on click
			item.addClass("expandable").click(function() {
				var article = item.children().first();
				setActiveItem(article);
			});
			// Prevent clicks on the item's canonical link from taking us away from the page.
			item.find("a.item-link").click(function(e) {
				if (displayPanel.is(":visible")) {
					e.preventDefault();
				}
			});
		});
	});
}(jQuery));
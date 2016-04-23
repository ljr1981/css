note
	description: "[
		Abstract notion of {CSS_DOCS}.
		]"
	design: "[
		See note clause at the end of this class.
		]"

deferred class
	CSS_DOCS

note
	design: "[
		HTML provides structure for data: DOM
			HTML structures can be isolated into components (e.g. navigation)
		CSS provides static rendering rules for the data in the DOM
		JS provides dynamic rendering programs for the DOM data and new data
		
		Themes offer a common framework for HTML, CSS, and JS.
		Themes can be about HTML structure, CSS rendering, or JS computation.
		Themes can be sliced along various lines: size, color, placement, animation.
		
		Libraries and Purpose
		=====================
		Themes are not CSS, nor are they HTML. Themes either apply CSS to HTML or
		HTML to CSS. Themes are a collector and applicative mechanism.
		
		Interestingly enough, when one has HTML as an object, one can derive or
		compute CSS from the HTML as each HTML element has its own "style".
		From the computed CSS, one can then organize, minimize, and otherwise
		"compile" the CSS down to its least common set.
		
		That CSS can be computed does not negate the need for CSS objects and a
		library of CSS classes to describe them. We must have CSS objects for the
		purpose of compiling, minification, and computing least common set.
		
		The fact that CSS can be computed or derived from HTML bears out both that
		HTML and CSS can be made generic or abstract to a degree that generic or
		abstract CSS can be applied to HTML other than that from which it was
		originally derived.
		
		Additionally, the derived or computed and now abstract CSS can be collected
		together into a Theme. Thefore, the notion of Theme is simply that of a
		collected set of sufficiently abstract CSS rules, which have an equally
		and matching set of abstract HTML.
		
		The now abstract HTML and abstract CSS can be sliced along various lines.
		The slices might be for other abstract ideas or functional notions such as
		backgrounds, behaviors, borders, padding, flows, and so on. The HTML can
		be sliced along lines we might call components (navigations, banners, forms,
		sections, articles, asides, and so on).
		
		The basis for abstraction in both HTML and CSS are built upon the notions
		that allow CSS to reference the HTML. Specifically:
		
		(1) Class(es)
		(2) ID
		(3) Psuedo-class (behavior, etc)
		(4) Tag-name
		
		The basis for abstract slicing in HTML is:
		
		(1) Components
		(2) Forms
		(3) Block-tags (nav, section, aside, article, address, data, etc.)
		
		The basis for abstract slicing in CSS is:
		
		(1) Color
		(2) Size
		(3) Position
		(4) Flow
		(5) Behavior
		(6) ???
		
		
		]"

end

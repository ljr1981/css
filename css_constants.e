note
	description: "[
		Representation of {CSS_CONSTANTS}.
		]"

class
	CSS_CONSTANTS

feature -- Access

	pseudo_classes: ARRAYED_LIST [TUPLE [name: STRING; has_argument: BOOLEAN; opt_argument_name: detachable STRING]]
			-- `pseudo_classes' list as a {TUPLE} of `name', `has_argument', an `opt_argument_name'.
		note
			design: "[
				Pseudo_class ::= Tag_name ":" Pseudo_class_name ["(" Optional_argument ")"]
				
				Each Pseudo_class may have an Optional_argument, depending on the specification.
				Defining this list in the CSS (instead of HTML) library indicates that only
				CSS-things are consumers of `pseudo_classes'.
				]"
			EIS: "src=http://www.w3schools.com/css/css_pseudo_classes.asp"
		once
			create Result.make (200)
			Result.force (["active", not has_argument, void_argument_name])
				--:active	a:active	Selects the active link
			Result.force (["checked", not has_argument, void_argument_name])
				--:checked	input:checked	Selects every checked <input> element
			Result.force (["disabled", not has_argument, void_argument_name])
				--:disabled	input:disabled	Selects every disabled <input> element
			Result.force (["empty", not has_argument, void_argument_name])
				--:empty	p:empty	Selects every <p> element that has no children
			Result.force (["enabled", not has_argument, void_argument_name])
				--:enabled	input:enabled	Selects every enabled <input> element
			Result.force (["first-child", not has_argument, void_argument_name])
				--:first-child	p:first-child	Selects every <p> elements that is the first child of its parent
			Result.force (["first-of-type", not has_argument, void_argument_name])
				--:first-of-type	p:first-of-type	Selects every <p> element that is the first <p> element of its parent
			Result.force (["focus", not has_argument, void_argument_name])
				--:focus	input:focus	Selects the <input> element that has focus
			Result.force (["hover", not has_argument, void_argument_name])
				--:hover	a:hover	Selects links on mouse over
			Result.force (["in-range", not has_argument, void_argument_name])
				--:in-range	input:in-range	Selects <input> elements with a value within a specified range
			Result.force (["invalid", not has_argument, void_argument_name])
				--:invalid	input:invalid	Selects all <input> elements with an invalid value
			Result.force (["lang", has_argument, "language"])
				--:lang(language)	p:lang(it)	Selects every <p> element with a lang attribute value starting with "it"
			Result.force (["last-child", not has_argument, void_argument_name])
				--:last-child	p:last-child	Selects every <p> elements that is the last child of its parent
			Result.force (["last-of-type", not has_argument, void_argument_name])
				--:last-of-type	p:last-of-type	Selects every <p> element that is the last <p> element of its parent
			Result.force (["link", not has_argument, void_argument_name])
				--:link	a:link	Selects all unvisited links
			Result.force (["not", has_argument, "n"])
				--:not(selector)	:not(p)	Selects every element that is not a <p> element
			Result.force (["nth-child", has_argument, "n"])
				--:nth-child(n)	p:nth-child(2)	Selects every <p> element that is the second child of its parent
			Result.force (["nth-last-child", has_argument, "n"])
				--:nth-last-child(n)	p:nth-last-child(2)	Selects every <p> element that is the second child of its parent, counting from the last child
			Result.force (["nth-last-of-type", has_argument, "n"])
				--:nth-last-of-type(n)	p:nth-last-of-type(2)	Selects every <p> element that is the second <p> element of its parent, counting from the last child
			Result.force (["nth-of-type", has_argument, "n"])
				--:nth-of-type(n)	p:nth-of-type(2)	Selects every <p> element that is the second <p> element of its parent
			Result.force (["only-of-type", not has_argument, void_argument_name])
				--:only-of-type	p:only-of-type	Selects every <p> element that is the only <p> element of its parent
			Result.force (["only-child", not has_argument, void_argument_name])
				--:only-child	p:only-child	Selects every <p> element that is the only child of its parent
			Result.force (["optional", not has_argument, void_argument_name])
				--:optional	input:optional	Selects <input> elements with no "required" attribute
			Result.force (["out-of-range", not has_argument, void_argument_name])
				--:out-of-range	input:out-of-range	Selects <input> elements with a value outside a specified range
			Result.force (["read-only", not has_argument, void_argument_name])
				--:read-only	input:read-only	Selects <input> elements with a "readonly" attribute specified
			Result.force (["read-write", not has_argument, void_argument_name])
				--:read-write	input:read-write	Selects <input> elements with no "readonly" attribute
			Result.force (["required", not has_argument, void_argument_name])
				--:required	input:required	Selects <input> elements with a "required" attribute specified
			Result.force (["root", not has_argument, void_argument_name])
				--:root	root	Selects the document's root element
			Result.force (["target", not has_argument, void_argument_name])
				--:target	#news:target	Selects the current active #news element (clicked on a URL containing that anchor name)
			Result.force (["valid", not has_argument, void_argument_name])
				--:valid	input:valid	Selects all <input> elements with a valid value
			Result.force (["visited", not has_argument, void_argument_name])
				--:visited	a:visited	Selects all visited links
		end

	pseudo_elements: ARRAYED_LIST [TUPLE [name: STRING; has_argument: BOOLEAN; opt_argument_name: detachable STRING]]
		once
			create Result.make (200)
			--All CSS Pseudo Elements
			--Selector	Example	Example description
			--::after	p::after	Insert content after every <p> element
			--::before	p::before	Insert content before every <p> element
			--::first-letter	p::first-letter	Selects the first letter of every <p> element
			--::first-line	p::first-line	Selects the first line of every <p> element
			--::selection	p::selection	Selects the portion of an element that is selected by a user
		end

feature {NONE} -- Implementation: Constants

	is_quoted: BOOLEAN = True
	has_argument: BOOLEAN = True
	void_argument_name: detachable STRING once Result := Void end
	no_uom: detachable STRING once Result := Void end
	no_name: detachable STRING once Result := Void end

	comma_character: CHARACTER = ','
	colon_character: CHARACTER = ':'
	semicolon_character: CHARACTER = ';'
	space_character: CHARACTER = ' '
	double_quote_character: CHARACTER = '"'
	important_keyword: STRING = "!important"
	single_character: INTEGER = 1
	opening_brace: CHARACTER = '{'
	closing_brace: CHARACTER = '}'

end

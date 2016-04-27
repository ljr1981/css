note
	description: "[
		Representation of a {CSS_RULE}.
		]"
	design: "[
		See notes at the end of this class.
		]"

class
	CSS_RULE

inherit
	CSS_ANY
		redefine
			out
		end

feature -- Access

	selectors: ARRAYED_LIST [CSS_SELECTOR]
			-- `selectors' used for Current {CSS_RULE}.
		attribute
			create Result.make (10)
		end

	declarations: ARRAYED_LIST [CSS_DECLARATION]
			-- `declarations' used for Current {CSS_RULE}.
		attribute
			create Result.make (10)
		end

feature -- Settings: Selectors

	add_class_selector (a_name: STRING)
			-- `add_class_selector' to `selectors'.
		do
			selectors.force (create {CSS_SELECTOR}.make_class_based (a_name))
		end

	add_id_selector (a_id: STRING)
			-- `add_id_selector' to `selectors'.
		do
			selectors.force (create {CSS_SELECTOR}.make_id_based (a_id))
		end

	add_tag_selector (a_name: STRING)
			-- `add_tag_selector' to `selectors'.
		do
			selectors.force (create {CSS_SELECTOR}.make_tag_based (a_name))
		end

	add_pseudo_class_selector (a_tag, a_name: STRING)
			-- `add_pseudo_class_selector' with `a_tag' and `a_name'.
		do
			selectors.force (create {CSS_SELECTOR}.make_pseudo_class_based (a_tag, a_name))
		end

	add_all_selector
			-- `add_all_selector' to `selectors'.
		do
			selectors.force (create {CSS_SELECTOR}.make_for_all)
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			create Result.make_empty

			across
				selectors as ic_selectors
			loop
				Result.append_string (ic_selectors.item.out)
				Result.append_character (',')
			end

			if not Result.is_empty then
				Result.remove_tail (1)
				Result.append_character (' ')
			end

			Result.append_character ('{')

			across
				declarations as ic_declarations
			loop
				Result.append_string (ic_declarations.item.out)
			end

			Result.append_character ('}')
		end

;note
	design: "[
		A {CSS_RULE} consists primarily of a set of {CSS_SELECTOR}s and
		a set of {CSS_DECLARATION}s. The selectors specify what {HTML_TAG}
		items in the universe of an <html> page are to be "selected" for
		application of the "rules" (declarations).
		
		The intent of this class is to hold the selectors and declarations
		for one of two purposes:
		
		(1) Creation of Current from some source (e.g. Theme, JSON, other) and then
			application to {HTML_TAG} (or other target recipient).
		(2) Creation of Current from an {HTML_TAG} and then given to a
			{CSS_RULE} compiler for the purpose of minification.
		]"
	EIS: "src=http://www.w3schools.com/css/css_syntax.asp"

end

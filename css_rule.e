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

	CSS_CONSTANTS
		undefine
			default_create,
			out
		end

create
	default_create,
	make_separate,
	make_inclusive

feature {NONE} -- Initialization

	make_inclusive (a_selectors: ARRAY [CSS_SELECTOR]; a_declarations: ARRAY [CSS_DECLARATION])
		do
			make_separate (a_selectors, a_declarations)
			set_inclusive
		end

	make_separate (a_selectors: ARRAY [CSS_SELECTOR]; a_declarations: ARRAY [CSS_DECLARATION])
		do
			across
				a_selectors as ic_selectors
			loop
				selectors.force (ic_selectors.item)
			end
			across
				a_declarations as ic_declarations
			loop
				declarations.force (ic_declarations.item)
			end
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

	rules: ARRAYED_LIST [attached like rules_tuple_anchor]
			-- Subordinate or enclosed `rules' of Current {CSS_RULE}.
		note
			design: "[
				Subordinate `rules' receive their parent selectors when
				rendered (`out') to CSS.
				]"
		attribute
			create Result.make (10)
		end

feature -- Settings: Selectors

	add_rule (a_rule: CSS_RULE; a_parent: detachable CSS_RULE)
			-- `add_rule' `a_rule' to `rules'.
		do
			rules.force ([a_parent, a_rule])
		end

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

feature -- Settings

	set_inclusive
		do
			is_selector_inclusive := True
		end

	set_separate
		do
			is_selector_inclusive := False
		end

feature -- Queries

	is_selector_inclusive: BOOLEAN
			-- `is_selector_inclusive'?
		note
			design: "[
				Selectors can be separate or inclusive.
				Example:
				
					separate: .main, p, table <-- applies to class main, also to <p> and <table>
					inclusive: .main p table <-- applies to <table> in <p> in class .main (e.g. <div class="main">)
				]"
		attribute
			Result := False
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			create Result.make_empty
			if is_selector_inclusive then
				Result.append_string (selectors_out (space_character))
			else
				Result.append_string (selectors_out (comma_character))
			end
			Result.append_character (opening_brace)

			across
				declarations as ic_declarations
			loop
				Result.append_string (ic_declarations.item.out)
			end

			Result.append_character (closing_brace)
			Result.append_string (subordinate_rules_out)
		end

feature {CSS_RULE} -- Implementation

	selectors_out (a_separator: CHARACTER): STRING
			-- `selectors_out' using `a_separator'.
		do
			create Result.make_empty

			across
				selectors as ic_selectors
			loop
				Result.append_string (ic_selectors.item.out)
				Result.append_character (a_separator)
			end

			if not Result.is_empty then
				Result.remove_tail (single_character)
				Result.append_character (space_character)
			end
		end

	subordinate_rules_out: STRING
			-- `subordinate_rules_out' from `rules'.
		do
			create Result.make_empty
			across
				rules as ic_rules
			loop
				Result.append_string (subordinate_rule_out (ic_rules.item))
			end
		end

	subordinate_rule_out (a_rule: attached like rules_tuple_anchor): STRING
		do
			create Result.make_empty
			Result.append_character (space_character)
			if attached a_rule.parent as al_parent then
				Result.append_string (al_parent.selectors_out (space_character))
			end
			Result.append_string (a_rule.rule.out)
		end

feature -- Anchors

	rules_tuple_anchor: detachable TUPLE [parent: detachable CSS_RULE; rule: CSS_RULE]
			-- Type anchor for `rules_tuple_anchor'.

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

note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CSS_RULE_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

	CSS_ANY
		undefine
			default_create
		end

	CSS_CONSTANTS
		undefine
			default_create
		end

feature -- Testing: {CSS_RULE} Creation

	css_rule_creation_tests
			-- New test routine
		local
			l_rule: CSS_RULE
		do
			create l_rule
			l_rule.add_all_selector
			l_rule.declarations.force (create {CSS_DECLARATION}.make_quoted_value ("color", "black"))
			assert_strings_equal ("all_color_black", "* {color:%"black%";}", l_rule.out)
		end

feature -- Testing: Nested CSS

	css_sub_rule_tests
		note
			example: "[
#main {
  color: black;
  a {
    font-weight: bold;
    &:hover { color: red; }
  }
}

Transforms to:

#main {color: "black";} #main a {font-weight: bold;} #main a:hover {color: "red";}

				]"
		local
			l_rule,
			l_font_rule,
			l_hover_rule: CSS_RULE
		do
			create l_rule
			l_rule.add_id_selector ("main")
			l_rule.declarations.force (create {CSS_DECLARATION}.make_quoted_value ("color", "black"))

			create l_font_rule
			l_font_rule.add_tag_selector ("a")
			l_font_rule.declarations.force (create {CSS_DECLARATION}.make_unquoted_value ("font-weight", "bold"))

			create l_hover_rule
			l_hover_rule.add_pseudo_class_selector ("a", "hover")
			l_hover_rule.declarations.force (create {CSS_DECLARATION}.make_quoted_value ("color", "red"))

			l_rule.add_sub_rule (l_font_rule)
			l_rule.add_sub_rule (l_hover_rule)

			assert_strings_equal ("rule_sub_hover", "#main {color:%"black%";} #main a {font-weight:bold;} #main a:hover {color:%"red%";}", l_rule.out)
		end

	nested_css_test
		note
			EIS: "src=http://sass-lang.com/documentation/file.SASS_REFERENCE.html"
		local
			l_main_p,
			l_redbox: CSS_RULE
		do
				-- Version #1
			create l_main_p
			l_main_p.add_id_selector ("main")
			l_main_p.add_tag_selector ("p")
			l_main_p.set_inclusive
			l_main_p.declarations.force (create {CSS_DECLARATION}.make_unquoted_value ("color", "#00ff00"))
			l_main_p.declarations.force (create {CSS_DECLARATION}.make_unquoted_value ("width", "97%%"))

			create l_redbox
			l_redbox.add_class_selector ("redbox")
			l_redbox.declarations.force (create {CSS_DECLARATION}.make_unquoted_value ("background-color", "#ff0000"))
			l_redbox.declarations.force (create {CSS_DECLARATION}.make_unquoted_value ("color", "#000000"))

			l_main_p.add_sub_rule (l_redbox)
			assert_strings_equal ("nested_css", nested_example, l_main_p.out)

				-- Version #2
			create l_main_p.make_inclusive (<<create {CSS_SELECTOR}.make_id_based ("main"),
												create {CSS_SELECTOR}.make_tag_based ("p")>>,
											<<create {CSS_DECLARATION}.make_unquoted_value ("color", "#00ff00"),
												create {CSS_DECLARATION}.make_unquoted_value ("width", "97%%")>>)
			create l_redbox.make_separate (<<create {CSS_SELECTOR}.make_class_based ("redbox")>>,
											<<create {CSS_DECLARATION}.make_unquoted_value ("background-color", "#ff0000"),
												create {CSS_DECLARATION}.make_unquoted_value ("color", "#000000")>>)

			l_main_p.add_sub_rule (l_redbox)
			assert_strings_equal ("nested_css", nested_example, l_main_p.out)
		end

feature {NONE} -- Implementation: Nested CSS

	nested_example: STRING = "#main p {color:#00ff00;width:97%%;} #main p .redbox {background-color:#ff0000;color:#000000;}"

feature -- Testing: More Nested CSS



end



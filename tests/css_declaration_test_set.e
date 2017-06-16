note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CSS_DECLARATION_TEST_SET

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

	CSS
		undefine
			default_create
		end

feature -- Test routines

	declaration_creation_test
			-- New test routine
		local
			l_declaration: CSS_DECLARATION
		do
			create l_declaration
			assert_strings_equal ("empty_property", create {STRING}.make_empty, l_declaration.property)
			create l_declaration.make ("color", <<["blue", is_quoted, no_uom, no_name]>>)
			assert_strings_equal ("color", "color", l_declaration.property)
			assert_integers_equal ("one_value", 1, l_declaration.values.count)
			l_declaration.set_property ("background-color")
			assert_strings_equal ("background-color", "background-color", l_declaration.property)
			assert_strings_equal ("color_out", "background-color:%"blue%";", l_declaration.out)
			create l_declaration.make ("font-size", <<["12", not is_quoted, "px", "size_in_pixels"]>>)
			assert_strings_equal ("font_size", "font-size:12px;", l_declaration.out)
		end

feature -- Testing: Imporant

	important_declarations_test
			-- `important_declarations_test'.
		local
			l_declaration: CSS_DECLARATION
		do
			create l_declaration
			l_declaration.set_immutable
			assert_booleans_equal ("important_and_immutable", l_declaration.is_important, l_declaration.is_immutable)
			create l_declaration.make_quoted_value ("color", "black")
			l_declaration.set_immutable
			assert_strings_equal ("important_color", important_color_output, l_declaration.out)
		end

feature {NONE} -- Testing: Imporant

	important_color_output: STRING = "color:%"black%" !important;"

end



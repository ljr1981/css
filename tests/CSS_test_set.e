note
	description: "Tests of {CSS}."
	testing: "type/manual"

class
	CSS_TEST_SET

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

feature -- Test routines

	CSS_tests
			-- `CSS_tests'
		local
			l_rule: CSS_RULE
			l_selector: CSS_SELECTOR
		do
			do_nothing -- yet ...
		end

	CSS_color_constants_test
			-- ??
		local
			l_const: CSS_COLOR_CONSTANTS
		do
			create l_const
			assert_strings_equal ("YellowGreen", "#9ACD32", l_const.yellowgreen)
		end

end

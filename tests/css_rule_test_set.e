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

feature -- Test routines

	css_rule_creation_tests
			-- New test routine
		local
			l_rule: CSS_RULE
		do
			create l_rule
			l_rule.add_all_selector
			l_rule.set_attribute_value (agent l_rule.color, "black")
			assert_strings_equal ("all", "* {color:black}", l_rule.out)
		end

end



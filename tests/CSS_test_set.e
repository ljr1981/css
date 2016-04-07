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
		do
			do_nothing -- yet ...
		end

end

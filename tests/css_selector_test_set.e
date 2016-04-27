note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CSS_SELECTOR_TEST_SET

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

feature -- Test routines

	selector_creation_test
			-- `selector_creation_test'
		local
			l_selector: CSS_SELECTOR
		do
				-- Mix up the creations and settings
				-- Effort to break the class invariant
			create l_selector
			l_selector.set_pseudo_class_name ("a", "hover")
			assert_strings_equal ("a_hover", "a:hover", l_selector.out)
			create l_selector.make_class_based ("my_class")
			l_selector.set_tag_name ("h1")
			create l_selector.make_pseudo_class_based ("p", "Hover")
			l_selector.set_class_name ("my_class")
			create l_selector.make_tag_based ("h1")

			create l_selector.make_id_based ("0987654321")
		end

end



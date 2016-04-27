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
			create l_selector.make_for_all
			check attached l_selector.class_name as al_name then assert_strings_equal ("class0", "*", al_name) end
			l_selector.set_pseudo_class_name ("a", "hover")
			check attached l_selector.tag_name as al_name then assert_strings_equal ("tag1", "a", al_name) end
			check attached l_selector.pseudo_class_name as al_name then assert_strings_equal ("pseudo1", "hover", al_name) end
			assert_strings_equal ("a_hover", "a:hover", l_selector.out)
			create l_selector.make_class_based ("my_class")
			check attached l_selector.class_name as al_name then assert_strings_equal ("class1", "my_class", al_name) end
			l_selector.set_tag_name ("h1")
			check attached l_selector.tag_name as al_name then assert_strings_equal ("tag2", "h1", al_name) end
			create l_selector.make_pseudo_class_based ("p", "Hover")
			check attached l_selector.tag_name as al_name then assert_strings_equal ("tag3", "p", al_name) end
			check attached l_selector.pseudo_class_name as al_name then assert_strings_equal ("pseudo2", "hover", al_name) end
			l_selector.set_class_name ("my_class")
			check attached l_selector.class_name as al_name then assert_strings_equal ("class2", "my_class", al_name) end
			create l_selector.make_tag_based ("h1")
			check attached l_selector.tag_name as al_name then assert_strings_equal ("tag4", "h1", al_name) end

			create l_selector.make_id_based ("0987654321")
			check attached l_selector.id as al_id then
				assert_strings_equal ("make_id", "0987654321", al_id)
			end
			l_selector.set_id ("1234567890")
			check attached l_selector.id as al_id then
				assert_strings_equal ("set_id", "1234567890", al_id)
			end
		end

end



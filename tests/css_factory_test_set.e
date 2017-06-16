note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CSS_FACTORY_TEST_SET

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

	CSS_FACTORY
		undefine
			default_create
		end

feature -- Test routines

	css_factory_tests
			-- New test routine
		note
			testing:  "execution/isolated", "execution/serial"
		do
			assert_strings_equal ("background_as_url", background_as_url_string, background_image_as_url ("url1").out)
			assert_strings_equal ("background_as_url_from_urls", background_as_url_string, background_images_as_urls (<<"url1">>).out)
			assert_strings_equal ("background_as_urls", background_as_urls_string, background_images_as_urls (<<"url1", "url2">>).out)
		end

feature {NONE} -- Constants

	background_as_url_string: STRING = "[
background-image:url:("url1");
]"

	background_as_urls_string: STRING = "[
background-image:url:("url1"),url:("url2");
]"

end



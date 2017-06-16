class
	CSS_FACTORY

inherit
	CSS

feature

	background_image_as_url (a_url: STRING): CSS_DECLARATION
			-- background-image url
		do
			Result := background_images_as_urls (<<a_url>>)
		end

	background_images_as_urls (a_urls: ARRAY [STRING]): CSS_DECLARATION
			-- background-image url
		local
			l_set: STRING
		do
			create l_set.make_empty
			across
				a_urls as ic
			loop
				l_set.append_string_general (url_quoted (ic.item))
				l_set.append_character (',')
			end
			if not l_set.is_empty then
				l_set.remove_tail (1)
			end
			create Result.make_unquoted_value ("background-image", l_set)
		end

		-- background-image image( [ [ <image> | <string> ]? , <color>? ]! )
		-- background-image image-set( [ <image> | <string> ] <resolution> )
		-- background-image element()
		-- background-image crossfade()
		-- background-image gradient()

feature -- Functions

	url_quoted (a_value: STRING): STRING
		do
			Result := url (a_value, '"')
		end

	url_single_quoted (a_value: STRING): STRING
		do
			Result := url (a_value, '%'')
		end

	url_unquoted (a_value: STRING): STRING
		do
			Result := url (a_value, '%U')
		end

	url (a_value: STRING; a_enclosing_mark: detachable CHARACTER): STRING
		do
			if attached a_enclosing_mark as al_mark then
				Result := url_kw + ":(" + al_mark.out + a_value + al_mark.out + ")"
			else
				Result := url_kw + ":(" + a_value + ")"
			end
		end

end

note
	description: "[
		Representation of a {CSS_DECLARATION}
		]"
	design: "[
		See design note at the end of this class.
		]"

class
	CSS_DECLARATION

inherit
	CSS_ANY
		redefine
			out
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_property: like property; a_values: ARRAY [attached like value_anchor])
			-- `make' Current with `a_property' name and list of `a_values'.
		do
			property := a_property
			across a_values as ic loop values.force (ic.item) end
		end

feature {CSS_RULE, TEST_SET_BRIDGE} -- Access

	property: STRING
			-- `property' of Current {CSS_DECLARATION}.
		attribute
			create Result.make_empty
		end

	values: ARRAYED_LIST [attached like value_anchor]
			-- `values' of `property' as {STRING}s.
		attribute
			create Result.make (5)
		end

feature {CSS_RULE, TEST_SET_BRIDGE} -- Settings

	set_property (a_property_name: like property)
			-- `set_property' with `a_property_name'.
		do
			property := a_property_name
		ensure
			set: property.same_string (a_property_name)
		end

	add_value (a_value: attached like value_anchor)
			-- `add_value' `a_value' to `values'.
		do
			values.force (a_value)
		ensure
			set: values.has (a_value)
		end

feature {CSS_RULE, TEST_SET_BRIDGE} -- Output

	out: STRING
			-- <Precursor>
		require else
			has_values: not values.is_empty
		do
			create Result.make_empty
			Result.append_string (property)
			Result.append_character (':')
			across
				values as ic_values
			loop
				Result.append_string (ic_values.item.value)
				if attached ic_values.item.unit_of_measure as al_uom then
					Result.append_string (al_uom)
				end
				Result.append_character (' ')
			end
			check Result [Result.count] = ' ' end
			Result.remove_tail (1)
			Result.append_character (';')
		end

feature {NONE} -- Implementation: Anchors

	value_anchor: detachable TUPLE [value: STRING; unit_of_measure, value_name: detachable STRING]
			-- `value_anchor' for `values' and `add_value'.

;note
	design: "[
		Within a {CSS_RULE}, there are {CSS_SELECTOR}s and {CSS_DECLARATION}s.
		See the EIS link for "css_syntax" below. The write-up from the EIS link
		is helpful, but simplistic. In reality, there are can be many selectors
		and many declarations. Additionally, declarations can have more than one
		value for each Property. You can think of Values more as Arguments of a
		Function, where the Property is actually the name of a function receiving
		the Value(s) as Argument(s).
		
		The Values (or arguments) are expressed in various data types. Sometimes
		numeric and other times strings. As numerics, there may also be the notion
		of Unit-of-Measure. For example: The EIS link information shows the following:
		
		h1 {color:blue; font-size:12px}
		
		The "px" is a unit of measure, which tells the rendering engine critical
		information about the font-size Property setting. Values can be set with
		a value-UOM pair. The UOM is detachable, so if you want to set the UOM
		separately, then you can if you want.
		
		Because a declaration can have multiple values, values of precisely the
		same value and unit-of-measure will require further distinction. Again,
		you can think of the "values" are arguments in a feature call. As such,
		the arguments have identifier names. This notion is utilized here to
		provide an identifier to the "value" being added. This also aids in removal.
		]"
	EIS: "src=http://www.w3schools.com/css/css_syntax.asp"

end

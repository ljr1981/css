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

	CSS_CONSTANTS
		undefine
			default_create,
			out
		end

create
	default_create,
	make,
	make_quoted_value,
	make_unquoted_value,
	make_uom_value

feature {NONE} -- Initialization

	make_quoted_value (a_property, a_value: like property)
			-- `make_quoted_value' with `a_property' and `a_value'.
			-- my_property:"my_value";
		do
			make (a_property, <<[a_value, is_quoted, no_uom, no_name]>>)
		end

	make_unquoted_value (a_property, a_value: like property)
			-- `make_unquoted_value' with `a_property' and `a_value'.
			-- my_property:my_value;
		do
			make (a_property, <<[a_value, not is_quoted, no_uom, no_name]>>)
		end

	make_uom_value (a_property, a_value, a_uom: like property)
			-- `make_uom_value' with `a_property', `a_value', and `a_uom'.
			-- my_property:20px;
		do
			make (a_property, <<[a_value, not is_quoted, a_uom, no_name]>>)
		end

	make (a_property: like property; a_values: ARRAY [attached like value_anchor])
			-- `make' Current with `a_property' name and list of `a_values'.
			-- Example: margin: 20px 0; <-- "margin" = `property' and "20px" "0" are `values'.
			-- << TUPLE: [Value], [Is_quoted], [Uom], [Value_name] >>
			-- 	value 		= A value you're setting on `a_property'.
			--	is_quote 	= True/False if in double-quotes or not.
			--	UOM 		= Unit of measure, as in 20 = value, "px" = UOM
			--	Value_name 	= The name of the value. Not generated to CSS.
			-- See also: `value_anchor'
		do
			property := a_property
			across a_values as ic loop values.force (ic.item) end
		end

feature -- Access

	property: STRING
			-- `property' of Current {CSS_DECLARATION}.
			-- Example: margin: 20px 0; <-- "margin" is the `property'.
			-- See also: `values'.
		attribute
			create Result.make_empty
		end

	values: ARRAYED_LIST [attached like value_anchor]
			-- `values' of `property' as {STRING}s.
			-- Example: margin: 20px 0; <-- "20px" and "0" are `values'.
			-- See also: `property'.
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
		require
			consistent: a_value.is_quoted implies not attached a_value.unit_of_measure
		do
			values.force (a_value)
		ensure
			set: values.has (a_value)
		end

	set_immutable
		do
			is_immutable := True
			is_important := is_immutable
		ensure
			set: is_immutable and is_important
		end

	set_mutable
		do
			is_immutable := False
			is_important := is_immutable
		ensure
			reset: not is_immutable and not is_important
		end

feature {CSS_RULE, TEST_SET_BRIDGE} -- Queries

	is_important,
	is_immutable: BOOLEAN
			-- `is_important' (also `is_immutable')?
			-- Example: !important overrides any other setting!
			-- Set and use this with caution.
		note
			design: "[
				If a rule is !important, then it helps to make it "immutable".
				]"
		attribute
			Result := False
		end

feature -- Output

	out: STRING
			-- <Precursor>
		require else
			has_values: not values.is_empty
		do
			create Result.make_empty
			Result.append_string (property)
			Result.append_character (colon_character)
			across
				values as ic_values
			loop
				if ic_values.item.is_quoted then
					Result.append_character (double_quote_character)
				end
				Result.append_string (ic_values.item.value)
				if ic_values.item.is_quoted then
					Result.append_character (double_quote_character)
				end
				if attached ic_values.item.unit_of_measure as al_uom then
					Result.append_string (al_uom)
				end
				Result.append_character (space_character)
			end
			check Result [Result.count] = space_character end
			Result.remove_tail (single_character)

			if is_immutable and is_important then
				Result.append_character (space_character)
				Result.append_string (important_keyword)
			end

			Result.append_character (semicolon_character)
		end

feature {NONE} -- Implementation: Anchors

	value_anchor: detachable TUPLE [value: STRING; is_quoted: BOOLEAN; unit_of_measure, value_name: detachable STRING]
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

note
	description: "[
		Representation of a {CSS_RULE}.
		]"

class
	CSS_RULE

inherit
	CSS_ANY
		redefine
			out
		end

	FW_ATTRIBUTE_HELPER
		undefine
			default_create,
			out
		redefine
			attribute_list
		end

feature -- Access

	selectors: ARRAYED_LIST [STRING]
			-- `selectors' used for Current {CSS_RULE}.
		attribute
			create Result.make (10)
		end

feature -- Settings

	add_class_selector (a_name: STRING)
			-- `add_class_selector' to `selectors'.
		do
			selectors.force ("." + a_name)
		end

	add_id_selector (a_name: STRING)
			-- `add_id_selector' to `selectors'.
		do
			selectors.force ("#" + a_name)
		end

	add_all_selector
			-- `add_all_selector' to `selectors'.
		do
			selectors.force ("*")
		end

feature -- Attributes

	attribute_list: HASH_TABLE [attached like attribute_tuple_anchor, STRING]
			-- `attribute_list'.
		do
			create Result.make (Default_capacity)
			Result.force (align_content, align_content.attr_name)
			Result.force (align_items, align_items.attr_name)
			Result.force (align_self, align_self.attr_name)
			Result.force (color, color.attr_name)
		ensure then
			count: Result.count >= Default_capacity
			matching: across Result as ic all ic.key.same_string (ic.item.attr_name) end
		end

	align_content: 		attached like attribute_tuple_anchor attribute Result := ["stretch", "stretch|center|flex-start|flex-end|space-between|space-around|initial|inherit", Void, "align-content", is_unquoted] end
	align_items: 		attached like attribute_tuple_anchor attribute Result := ["stretch", "stretch|center|flex-start|flex-end|space-between|space-around|initial|inherit", Void, "align-items", is_unquoted] end
	align_self: 		attached like attribute_tuple_anchor attribute Result := ["stretch", "stretch|center|flex-start|flex-end|space-between|space-around|initial|inherit", Void, "align-self", is_unquoted] end
	color: 				attached like attribute_tuple_anchor attribute Result := ["", "", Void, "color", is_quoted] end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			create Result.make_empty
			across
				selectors as ic_selectors
			loop
				Result.append_string (ic_selectors.item)
				Result.append_character (' ')
			end
			Result.append_character ('{')
			across
				attribute_list as ic_declarations
			loop
				Result.append_string (ic_declarations.item.attr_name)
				Result.append_character (':')
				check string_values: attached {STRING} ic_declarations.item.attr_value as al_value then
					Result.append_string (al_value)
				end
				Result.append_character (';')
			end
			Result.remove_tail (1)
			Result.append_character ('}')
		end

feature {NONE} -- Implementation: Anchors

	declaration_anchor: detachable TUPLE [property, value: STRING]

	Default_capacity: INTEGER = 4

end

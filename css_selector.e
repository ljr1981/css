note
	description: "[
		Representation of a {CSS_SELECTOR}.
		]"
	design: "[
		See design note at the end of this class.
		]"

class
	CSS_SELECTOR

inherit
	CSS_ANY
		redefine
			out
		end

	CSS_CONSTANTS
		undefine
			out
		end

create
	default_create,
	make_for_all,
	make_class_based,
	make_tag_based,
	make_pseudo_class_based,
	make_id_based

feature {NONE} -- Initialization

	make_for_all
			-- `make_for_all' (starred).
		do
			make_tag_based ("*")
		end

	make_class_based (a_name: attached like class_name)
			-- `make_as_class_based' with `a_name' to `class_name'.
			-- Example: .Main <-- where the first selector is a `class_name'.
		do
			set_class_name (a_name)
		end

	make_id_based (a_id: attached like id)
			-- `make_id_based' with `a_id' to `id'.
			-- Example: #Unique-id <-- where the first selector is an `id'.
		do
			set_id (a_id)
		end

	make_tag_based (a_name: attached like tag_name)
			-- `make_as_class_based' with `a_name' to `tag_name'.
			-- Example: form <-- where the first selector is just a tag name.
		do
			set_tag_name (a_name)
		end

	make_pseudo_class_based (a_tag, a_name: attached like pseudo_class_name)
			-- `make_as_class_based' with `a_name' to `pseudo_class_name'.
			-- Example: a:hover <-- where the first selector is a Psuedo-class.
		do
			set_pseudo_class_name (a_tag, a_name)
		end

feature -- Access

	class_name: detachable STRING
			-- Optional `class_name'.

	tag_name: detachable STRING
			-- Optional `tag_name'.

	pseudo_class_name: detachable STRING
			-- Optional `pseudo_class_name'.

	id: detachable STRING
			-- Optional `id'.

feature -- Settings

	set_class_name (a_name: attached like class_name)
			-- `set_class_name' with `a_name'.
			-- Reset others to Void.
		do
			class_name := a_name
			id := Void
			tag_name := Void
			pseudo_class_name := Void
		ensure
			set: attached class_name as al_name and then al_name.same_string (a_name)
			not_set: not attached tag_name and not attached pseudo_class_name and not attached id
		end

	set_id (a_id: attached like id)
			-- `set_class_name' with `a_id'.
			-- Reset others to Void.
		do
			class_name := Void
			id := a_id
			tag_name := Void
			pseudo_class_name := Void
		ensure
			set: attached id as al_id and then al_id.same_string (a_id)
			not_set: not attached class_name and not attached tag_name and not attached pseudo_class_name
		end

	set_tag_name (a_name: attached like tag_name)
			-- `set_tag_name' with `a_name'.
			-- Reset others to Void.
		do
			class_name := Void
			id := Void
			tag_name := a_name
			pseudo_class_name := Void
		ensure
			set: attached tag_name as al_name and then al_name.same_string (a_name)
			not_set: not attached class_name and not attached pseudo_class_name and not attached id
		end

	set_pseudo_class_name (a_tag, a_class_name: attached like pseudo_class_name)
			-- `set_pseudo_class_name' with `a_class_name'.
			-- Reset others to Void.
		do
			class_name := Void
			id := Void
			tag_name := a_tag
			pseudo_class_name := a_class_name
		ensure
			set: attached pseudo_class_name as al_class_name and then al_class_name.same_string (a_class_name) and then
					attached tag_name as al_tag_name and then al_tag_name.same_string (a_tag)
			not_set: not attached class_name and not attached id
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			create Result.make_empty
			if attached class_name as al_name then
				Result := class_selector_out (al_name)
			elseif attached id as al_id then
				Result := id_selector_out (al_id)
			elseif attached tag_name as al_tag_name and then attached pseudo_class_name as al_name then
				Result := pseudo_class_selector_out (al_tag_name, al_name)
			elseif attached tag_name as al_name then
				Result := al_name
			end
		end

feature {NONE} -- Implementation: Outputs

	class_selector_out (a_class_name: STRING): STRING
			-- `class_selector_out' for Current {CSS_SELECTOR} from `a_class_name'.
		do
			Result := formatted_selector_out (class_character, a_class_name)
		end

	id_selector_out (a_tag_name: STRING): STRING
			-- `id_selector_out' for Current {CSS_SELECTOR} from `a_tag_name'.
		do
			Result := formatted_selector_out (id_character, a_tag_name)
		end

	pseudo_class_selector_out (a_tag_name, a_pseudo_class_name: STRING): STRING
		require
			valid_pseudo_class: across pseudo_classes as ic some ic.item.name.same_string (a_pseudo_class_name) end
		do
			Result := formatted_pseudo_selector_out (a_tag_name, pseudo_class_character.out, a_pseudo_class_name)
		ensure
			valid_order: attached Result.split (pseudo_class_character) as al_list and then
							al_list.count = 2 and then
							al_list [1].same_string (a_tag_name) and then
								al_list [2].same_string (a_pseudo_class_name)
		end

	pseudo_element_selector_out (a_tag_name, a_pseudo_element_name: STRING): STRING
		require
			valid_pseudo_class: across pseudo_elements as ic some ic.item.name.same_string (a_pseudo_element_name) end
		do
			Result := formatted_pseudo_selector_out (a_tag_name, pseudo_class_character.out, a_pseudo_element_name)
		end

feature {NONE} -- Implementation

	formatted_selector_out (a_character: CHARACTER; a_selector: STRING): STRING
		require
			valid_character: a_character = class_character xor a_character = id_character
			no_whitespace: not a_selector.has_substring (" ")
		do
			Result := a_character.out
			Result.append_string (a_selector)
			Result.adjust
		ensure
			valid_start: not Result.is_empty and then Result [1] = a_character
			valid_class: Result.has_substring (a_selector)
		end

	formatted_pseudo_selector_out (a_tag_name, a_resolver, a_pseudo_class_name: STRING): STRING
		require
			valid_pseudo_class: across pseudo_classes as ic some ic.item.name.same_string (a_pseudo_class_name) end
			valid_resolver: a_resolver.same_string (Pseudo_attribute_string) xor
								(a_resolver.count = 1 and then a_resolver [1] = Pseudo_class_character)
		do
			Result := a_tag_name.twin
			Result.append_string (a_resolver)
			Result.append_string (a_pseudo_class_name)
		ensure
			framing: attached tag_name as al_tag_name and then
						attached old tag_name as al_old_tag_name and then
						al_tag_name.same_string (al_old_tag_name)
			has_tag: Result.has_substring (a_tag_name)
			has_colon: Result.has_substring (a_resolver)
			has_pseudo: Result.has_substring (a_pseudo_class_name)
		end

feature -- Constants

	class_character: CHARACTER = '.'
	id_character: CHARACTER = '#'
	pseudo_class_character: CHARACTER = ':'
	pseudo_attribute_string: STRING = "::"

invariant
	unique_class_name: attached class_name implies (not attached tag_name and not attached pseudo_class_name and not attached id)
	unique_id: attached id implies (not attached tag_name and not attached pseudo_class_name and not attached class_name)
	valid_pseudo: attached pseudo_class_name implies attached tag_name and then (not attached class_name and not attached id)
	no_colon: attached tag_name as al_tag_name implies not al_tag_name.has (':')

;note
	design: "[
		Four basic types of selection:
		
		(1) Tag-based
		(2) Class-based
		(3) ID-based
		(4) Psuedo-class-based
		
		Tag-based ::= Tag_name
		======================
		{CSS_RULE}s are applied to {HTML_TAG}s based on the tag itself. When a
		rule is Tag-based, the signal is to list the tag by name.
		
		Class-based ::= "." Class_name
		==============================
		{CSS_RULE}s are applied to {HTML_TAG}s based on the class(es) ascribed
		to the tag. Each tag may have zero, one, or more classes. When a rule
		is Class-based, the signal is a class name prefixed with a period (".").
		
		ID-based ::= "#" Tag_name
		=========================
		{CSS_RULE}s are appliied to an {HTML_TAG} within an {HTML_PAGE} (or
		tag-universe) by means of an ID value. Within the page, the ID must
		be unique, which is how the Webkit finds the tag in order to apply
		the {CSS_RULE} to it. When a rule is ID-based, the signal is an ID
		name prefixed with a pound-sign ("#").
		
		Pseudo-class-based ::= Tag_name ":" Pseudo_class_name
		=====================================================
		{CSS_RULE}s are applied to {HTML_TAG}s based on pseudo-classes like
		"Hover" (a:Hover for example is what happens when the user hovers
		the mouse over an href link). Pseudo-classes are signaled by the
		tag-name, then a colon-character (":"), and then the name of the
		pseudo-class (e.g. "Hover").
		]"

end

note
	description: "[
		Representation of a {CSS_SELECTOR}.
		]"

class
	CSS_SELECTOR

inherit
	CSS_ANY

	CSS_CONSTANTS

--	HTML_CONSTANTS

feature -- Access


feature -- Queries

	class_selector (a_class_name: STRING): STRING
			-- `class_selector' for Current {CSS_SELECTOR} from `a_class_name'.
		do
			Result := formatted_selector (class_character, a_class_name)
		end

	id_selector (a_tag_name: STRING): STRING
			-- `id_selector' for Current {CSS_SELECTOR} from `a_tag_name'.
		require
--			valid_tag: valid_tags.has (a_tag_name)
		do
			Result := formatted_selector (id_character, a_tag_name)
		end

	pseudo_class_selector (a_tag_name, a_pseudo_class_name: STRING): STRING
		require
--			valid_tag: valid_tags.has (a_tag_name)
			valid_pseudo_class: across pseudo_classes as ic some ic.item.name.same_string (a_pseudo_class_name) end
		do
			Result := formatted_pseudo_selector (a_tag_name, pseudo_class_character.out, a_pseudo_class_name)
		ensure
			valid_order: attached Result.split (pseudo_class_character) as al_list and then
							al_list.count = 3 and then
							al_list [1].same_string (a_tag_name) and then
								al_list [2].same_string (a_pseudo_class_name)
		end

	pseudo_element_selector (a_tag_name, a_pseudo_element_name: STRING): STRING
		require
--			valid_tag: valid_tags.has (a_tag_name)
			valid_pseudo_class: across pseudo_elements as ic some ic.item.name.same_string (a_pseudo_element_name) end
		do
			Result := formatted_pseudo_selector (a_tag_name, pseudo_class_character.out, a_pseudo_element_name)
		end

feature {NONE} -- Implementation

	formatted_selector (a_character: CHARACTER; a_selector: STRING): STRING
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

	formatted_pseudo_selector (a_tag_name, a_resolver, a_pseudo_class_name: STRING): STRING
		require
--			valid_tag: valid_tags.has (a_tag_name)
			valid_pseudo_class: across pseudo_classes as ic some ic.item.name.same_string (a_pseudo_class_name) end
			valid_resolver: a_resolver.same_string (Pseudo_attribute_string) xor
								(a_resolver.count = 1 and then a_resolver [1] = Pseudo_class_character)
		do
			Result := a_tag_name
			Result.append_string (a_resolver)
			Result.append_string (a_pseudo_class_name)
		ensure
			has_tag: Result.has_substring (a_tag_name)
			has_colon: Result.has_substring (a_resolver)
			has_pseudo: Result.has_substring (a_pseudo_class_name)
		end

feature -- Constants

	class_character: CHARACTER = '.'
	id_character: CHARACTER = '#'
	pseudo_class_character: CHARACTER = ':'
	pseudo_attribute_string: STRING = "::"

note
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

note
	description: "[
		Representation of a {CSS_RULE}.
		]"

class
	CSS_RULE

feature -- Access

	selectors: ARRAYED_LIST [STRING]
			-- `selectors' used for Current {CSS_RULE}.
		attribute
			create Result.make (10)
		end

end

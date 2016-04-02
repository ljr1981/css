note
	description: "[
		Abstract notion of {CSS_DOCS}.
		]"
	design: "[
		See note clause at the end of this class.
		]"

class
	CSS_ANY

feature -- Documentation

	documentation: detachable CSS_DOCS
			-- `documentation' of Current {CSS_ANY}

;note
	design: "[
		The purpose of the CSS_ANY is to be a root class for the entire CSS library.
		Like its ANY counterpart, all CSS library classes must inherit directly or
		indirectly from this class, which is the purpose of a root class.
		
		Additionally, a root class offers the capacity in other libraries to ID classes
		from a particular library in code (e.g. if attached {CSS_ANY} my_css as al_css then ... end)
		]"

end

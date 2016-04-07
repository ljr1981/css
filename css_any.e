note
	description: "[
		Abstract notion of {CSS_DOCS}.
		]"
	design: "[
		See note clause at the end of this class.
		]"

class
	CSS_ANY

note
	root_class: "[
		The purpose of the CSS_ANY is to be a root class for the entire CSS library.
		Like its ANY counterpart, all CSS library classes must inherit directly or
		indirectly from this class, which is the purpose of a root class.
		
		Additionally, a root class offers the capacity in other libraries to ID classes
		from a particular library in code (e.g. if attached {CSS_ANY} my_css as al_css then ... end)
		]"
	specifications: "[
		Selector ::= Element | Id | Class | Pseudo_class

		Where:
		(1) Elements are HTML element tag names (e.g. H2).
		(2) Id's are Elements with a particular ID.
		(3) Class refers to Elements with a class=[Class_name], expressed as .[Class_name] in the Selector.
		(4) Pseudo_class refers to Elements associated with certain properties, such as "hover", expressed
		    as :hover, where it is appended to the selected, such as H2:hover, and is what happens when the
		    user hovers over an H2.
		    
		Declaration_block ::= "{" Declaration [";" Declaration_block] "}"

		Declaration ::= Property ":" Value

		Value ::= Keyword | Manifest_value | Units_value | Color_value

		Color_value ::= Color_keyword | Hex_value | RGB_value | RGBA_value | HSL_value | HSLA_value

		Where:
		(1) Color_keyword might be "red" or "white" or "blue"
		(2) Hex_value might be #FF0000, also abbreviated as #F00
		(3) RGB_value might be rgb(255, 0, 0)
		(4) RGBA_value expresses opacity as well such as rgba(255, 0, 0, 0.8), where 0.8 is 80% opaque
		(5) HSL/HSLA are like RGB/RGBA, but hsl(000, 100%, 50%), hsla(000, 100%, 50%, 80%)

		]"
	EIS: "src=https://en.wikipedia.org/wiki/Cascading_Style_Sheets"
	EIS: "src=https://en.wikipedia.org/wiki/Cascading_Style_Sheets#Variations"

end

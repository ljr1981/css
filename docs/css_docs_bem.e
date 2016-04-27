note
	description: "[
		Abstract notion of {CSS_DOS_BEM}
		]"
	definition: "[
		What is "BEM"?
		==============
		
		Block Element Modifier
		----------------------		
		Block: 		Standalone entity that is meaningful on its own.
					Represents the higher level of an abstraction or component.
					
						(Example: header, container, menu, checkbox, input)
						
		Element: 	Parts of a block and have no standalone meaning but semantically related.
					Represents a descendent (as in "contained in") of .block 
						that helps form .block as a whole.
						
						(Example: menu item, list item, checkbox caption, header title)
						
		Modifer: 	Flags on blocks or elements. Use them to change	appearance or behavior.
					Represents a different state or version of .block.
						
						(Example: disabled, highlighted, checked, fixed, size big, color yellow)
						
		See EIS below.
		]"
	EIS: "src=http://getbem.com/introduction/"
	EIS: "src=http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/"

class
	CSS_DOCS_BEM

note
	design: "[
		First appearances seem to indicate that BEM answers a multitude of questions
		surrounding: What is a more formalized methodology for CSS/HTML class naming?
		
		BEM appears to focus largely on working fluidly with the Cascading part of CSS
		coupled strongly with the Block-Element containership model (regardless of
		HTML containership)(1).
		
		(1) Containership can be about HTML containers (e.g. <menu> vs. <li> or "menu-item").
			It may also be about logical rather then physical (e.g. HTML) classifications.
			For example:
			
				.person {}
				.person__hand {}
				.person--female {}
				.person--female__hand {}
				.person__hand--left {}
			
			The example shows that the structure of a "BEM" is not always "BEM"--that is--
			Block-then-Element-then-Modifier. In the case of .person__hand and then
			.person--female__hand, we find that "female" is a Modifier of person and then
			"hand" an Element of a "female person".
			
			We may also further define organization based on general-to-specific, where we
			would get: .person__hand--female, which is equally valid (I think). We can now
			write: .person__hand--male, .person__hand--child or just .person__hand and
			have an organization that works top-down.
			
			From this we then form up the need for a classification or BEM library, which
			will consist of {BEM_BLOCK}, {BEM_ELEMENT}, and {BEM_MODIFIER}. In this case
			a {BEM_BLOCK} will have a collection of {BEM_ITEM}s, where a {BEM_ITEM} is
			either a {BEM_ELEMENT} or {BEM_MODIFER} and applied to the {BEM_BLOCK} in
			order of declaration (e.g. order in a list).
		]"

end

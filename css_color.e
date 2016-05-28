note
	description: "[
		Representation of an effected {CSS_COLOR}.
		]"
	EIS: "src=http://www.w3schools.com/cssref/css_colors_legal.asp"

class
	CSS_COLOR

inherit
	CSS_COLOR_CONSTANTS

feature -- Access

	hex_color: STRING do Result := hex_hash.out + hex_color_RR.to_hex_string + hex_color_GG.to_hex_string + hex_color_BB.to_hex_string end
	hex_color_RR: INTEGER_16; rgb_red: INTEGER_16 do Result := hex_color_RR end
	hex_color_GG: INTEGER_16; rgb_green: INTEGER_16 do Result := hex_color_GG end
	hex_color_BB: INTEGER_16; rgb_blue: INTEGER_16 do Result := hex_color_BB end
	hex_color_AA: INTEGER_16; rgb_alpha: INTEGER_16 do Result := hex_color_AA end
	hex_hash: CHARACTER = '#'

feature -- Setters

	set_red,
	set_RR (a_value: INTEGER_16)
		require
			valid: a_value >= 0 and a_value <= 255
		do
			hex_color_RR := a_value
		end

	set_green,
	set_GG (a_value: INTEGER_16)
		require
			valid: a_value >= 0 and a_value <= 255
		do
			hex_color_GG := a_value
		end

	set_blue,
	set_BB (a_value: INTEGER_16)
		require
			valid: a_value >= 0 and a_value <= 255
		do
			hex_color_BB := a_value
		end

	set_alpha,
	set_AA (a_value: INTEGER_16)
		require
			valid: a_value >= 0 and a_value <= 255
		do
			hex_color_AA := a_value
		end

invariant
	valid_red: hex_color_RR >= 0 and hex_color_RR <= 255
	valid_green: hex_color_GG >= 0 and hex_color_GG <= 255
	valid_blue: hex_color_BB >= 0 and hex_color_BB <= 255

note
	design_intent: "[
		Your_text_goes_here
		]"

end

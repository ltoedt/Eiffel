note
	description: "Summary description for {PARAGRAPH_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAGRAPH_LEAF
inherit
	NESTED_TEXT_COMPONENT
		redefine
			accept
	end
create
	new
feature --Attribute
	content: STRING
feature --Procedures
	new
		do
			content:= ""

			id:= ""
			ada_id:= FALSE
		end

	add_content(n: STRING)
		require -- Content can't contain "--"
			n.has_substring ("--") = False
		do
			content:= content + n + "%N"
		ensure -- total content can't exceed 10000 characters
			content.count < 10001
		end

	accept(V: VISITOR): STRING
		do
			Result:= V.convert_paragraph(Current)
		end
end

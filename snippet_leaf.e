note
	description: "Summary description for {SNIPPET_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SNIPPET_LEAF
inherit
	TEXT_ELEMENT_COMPONENT
		redefine
			accept
	end
create
	new
feature -- Attributes
	content: STRING
feature -- Procedures
	new
		do
			content:= ""
		end
	add_content(n: STRING)
		do
			content:= content + n
		ensure -- Snippet can't have more than 10000 characters
			content.count < 10001
		end

	accept(V: VISITOR): STRING
		do
			Result:= V.convert_snippet(Current)
		end
end

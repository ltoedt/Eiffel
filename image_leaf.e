note
	description: "Summary description for {IMAGE_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IMAGE_LEAF
inherit
	NESTED_TEXT_COMPONENT
		redefine
			accept
		end
create
	new
feature -- Attribute
	path_string: STRING
feature -- Procedure
	new(n: STRING)
		do
			path_string:= n

			id:= ""
			ada_id:= FALSE
		end
	accept(V: VISITOR): STRING
		do
			Result:= V.convert_image(Current)
		end
end

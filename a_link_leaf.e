note
	description: "Summary description for {A_LINK_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A_LINK_LEAF
inherit
	LINKS
		redefine
			accept
	end
create
	make
feature -- Attributes
	reference_to: NESTED_TEXT_COMPONENT
	linker_text: STRING
feature -- Procedures
	make(i: NESTED_TEXT_COMPONENT; lt: STRING)
		require -- Linker Texts can have a maxiumum of 500 characters
			lt.count < 501
		do
			reference_to:= i
			linker_text:= lt

			reference_to.set_anchor(TRUE)
		end

	accept(V: VISITOR): STRING
		do
			Result:= V.convert_anchor_links(Current)
		end
end

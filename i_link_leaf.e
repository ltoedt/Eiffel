note
	description: "Summary description for {I_LINK_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	I_LINK_LEAF
inherit
	LINKS
		redefine
			accept
	end
create
	make
feature -- Attributes
	reference_to: DOCUMENT
	linker_text: STRING
feature -- Procedures
	make(i: DOCUMENT; lt: STRING)
		require -- Linker Texts can have a maxiumum of 500 characters
			lt.count < 501
		do
			reference_to:= i
			linker_text:= lt
		end

	accept(V: VISITOR): STRING
		do
			Result:= V.convert_internal_links(Current)
		end
end



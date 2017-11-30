note
	description: "Summary description for {E_LINK_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E_LINK_LEAF
inherit
	LINKS
		redefine
			accept
	end
create
	make
feature
	reference_to: STRING
	linker_text: STRING
feature
	make(i: STRING; lt: STRING)
		require -- Linker Texts can have a maxiumum of 500 characters
			lt.count < 501
		do
			reference_to:= i
			linker_text:= lt
		end

	accept(V: VISITOR): STRING
		do
			Result:= V.convert_external_links(Current)
		end
end

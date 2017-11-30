note
	description: "Summary description for {DOCUMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT
inherit
	TEXT_COMPONENT
		redefine
			accept
	end
create
	new
feature -- Attributes
	doc: ARRAYED_LIST [TEXT_ELEMENT_COMPONENT]
	doc_name: STRING
feature -- Procedures
	new(name: STRING)
		require -- Document name can't contain a dot
			name.has_substring (".") = False
		do
			create doc.make(0)
			doc_name:= name
		end

	add_item (tc : TEXT_ELEMENT_COMPONENT)
		require -- Document can have a maximum of 100 items
			doc.count < 100
		do
			doc.extend(tc)
		end

	accept(V: VISITOR): STRING
		do
			Result:= V.convert_document(Current)
		end
end

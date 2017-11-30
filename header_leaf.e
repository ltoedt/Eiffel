note
	description: "Summary description for {HEADER_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_LEAF
inherit
	NESTED_TEXT_COMPONENT
		redefine
			accept
	end
create
	make
feature -- Attributes
	content: STRING
	order: INTEGER

feature -- Procedures
	make(title: STRING; header_order: INTEGER)
		require -- A title can not be longer than 500 characters and the order of a title has to be non-negative
			title.count < 501
			header_order > 0
		do
			content:= title
			order:= header_order

			id:= ""
			ada_id:= FALSE
		end

	show_order: INTEGER
		do
			Result:= order
		end

	set_order(n: INTEGER)
		require -- Order has to be non-negative
			n > 0
		do
			order:= n
		end

	accept(V: VISITOR): STRING
		do
			Result:= V.convert_header(Current)
		end
end

note
	description: "Summary description for {LIST_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_LEAF
inherit
	NESTED_TEXT_COMPONENT
		redefine
			accept
	end
create
	new
feature -- Public Attribute
	content: ARRAYED_LIST [STRING]
feature {None} -- Private Attribute
	is_ord: BOOLEAN

feature -- Procedures
	new
		do
			create content.make (0)
			is_ord:= FALSE

			id:= ""
			ada_id:= FALSE
		end

	is_ordered: BOOLEAN
		do
			Result:= is_ord
		end

	set_order(n: BOOLEAN)
		do
			is_ord:= n
		end

	add_item(n: STRING)
		require -- Item can have a maximum of 500 characters and a list can have a maximum of 100 items
			content.count < 100
			n.count < 501
		do
			content.extend(n)
		end

	accept(V: VISITOR): STRING
		do
			if is_ordered then
				Result:= V.convert_list_ordered(Current)
			else
				Result:= V.convert_list_unordered(Current)
			end
		end
end

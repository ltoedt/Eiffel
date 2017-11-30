note
	description: "Summary description for {NESTED_TEXT_COMPONENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NESTED_TEXT_COMPONENT

inherit
	TEXT_ELEMENT_COMPONENT
feature {None}-- Private Attributes
	id: STRING
	ada_id: BOOLEAN
	
feature {LINKS} --Protected Procedure
	set_anchor(bool: BOOLEAN)
		do
			ada_id:= bool
		end

feature -- Public Procedures
	set_id(n: STRING)
		do
			id:= n
		end
	show_id: STRING
		do
			Result:= id
		end
	is_id: BOOLEAN
		do
			Result:= ada_id
		end

end

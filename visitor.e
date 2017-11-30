note
	description: "Summary description for {VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISITOR
feature
	counter: INTEGER
feature {TEXT_COMPONENT} -- Procedures
	new
		do
			print("")
			counter:= 1
		end
	convert_document(tc: DOCUMENT): STRING
		do
			Result:= ""
		end
	convert_paragraph(tc: PARAGRAPH_LEAF): STRING
		do
			Result:= ""
		end
	convert_list_ordered(tc: LIST_LEAF): STRING
		do
			Result:= ""
		end
	convert_list_unordered(tc: LIST_LEAF): STRING
		do
			Result:= ""
		end
	convert_table(tc: TABLE_LEAF): STRING
		do
			Result:= ""
		end
	convert_image(tc: IMAGE_LEAF): STRING
		do
			Result:= ""
		end
	convert_anchor_links(tc: A_LINK_LEAF): STRING
		do
			Result:= ""
		end
	convert_external_links(tc: E_LINK_LEAF): STRING
		do
			Result:= ""
		end
	convert_internal_links(tc: I_LINK_LEAF): STRING
		do
			Result:= ""
		end
	convert_header(tc: HEADER_LEAF): STRING
		do
			Result:= ""
		end
	convert_snippet(tc: SNIPPET_LEAF): STRING
		do
			Result:= ""
		end

end

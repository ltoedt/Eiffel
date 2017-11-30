note
	description: "Summary description for {TEXT_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_VISITOR
inherit
	VISITOR
	redefine
		convert_document, convert_paragraph, convert_list_ordered, convert_list_unordered, convert_table, convert_image, convert_anchor_links, convert_external_links, convert_header, convert_snippet, convert_internal_links
	end
create
	new
feature {TEXT_COMPONENT}
	convert_document(tc: DOCUMENT): STRING
		local
				string: STRING
				i: INTEGER
				j: TEXT_COMPONENT
		do
			string:= "---- Start Document ---- %N"
			from
				i:= 1
			until
				i > tc.doc.count
			loop
				j:= tc.doc[i]
				string:= string + j.accept (Current) + "%N"
				i:= i + 1
			end
			string:= string + "---- End Document ---- %N"
			Result:= string
		end
	convert_paragraph(tc: PARAGRAPH_LEAF): STRING
		do
			Result:= "%N" + tc.content + "%N"
		end
	convert_list_ordered(tc: LIST_LEAF): STRING
		local
			i: INTEGER
			string: STRING
		do
			string:= ""
			from
				i:= 1
			until
				i > tc.content.count
			loop
				string:= string + i.out + ". " + tc.content[i] + "%N"
				i:= i + 1
			end
			Result:= string
		end
	convert_list_unordered(tc: LIST_LEAF): STRING
		local
			i: INTEGER
			string: STRING
		do
			string:= ""
			from
				i:= 1
			until
				i > tc.content.count
			loop
				string:= string + "o " + tc.content[i] + "%N"
				i:= i + 1
			end
			Result:= string
		end
	convert_table(tc: TABLE_LEAF): STRING
		local
			i: INTEGER
			l: INTEGER
			string: STRING
		do
			string:= ""
			from
				i:= 1
			until
				i > tc.show_row
			loop
				string:= string + "| "
				from
					l:= 1
				until
					l > tc.show_col
				loop
					string:= string + tc.table[(i-1)*tc.show_col+l] + " | "
					l:= l + 1
				end
				string:= string + "%N"
				i:= i + 1
			end
			Result:= string
		end
	convert_image(tc: IMAGE_LEAF): STRING
		do
			Result:= "Image: " + tc.path_string
		end
	convert_anchor_links(tc: A_LINK_LEAF): STRING
		do
			if tc.reference_to.show_id.is_empty then
				tc.reference_to.set_id("a" + counter.out)
				counter:= counter + 1
			end

			Result:= "link to ------> " + tc.reference_to.show_id + " with linker text '" + tc.linker_text + "' %N"
		end
	convert_external_links(tc: E_LINK_LEAF): STRING
		do
			Result:= "link to ------> " + tc.reference_to + " with link text '" + tc.linker_text + "' %N"
		end
	convert_internal_links(tc: I_LINK_LEAF): STRING
		do
			Result:= "link to ------> " + tc.reference_to.doc_name + " with linker text '" + tc.linker_text + "' %N"
		end
	convert_header(tc: HEADER_LEAF): STRING
		do
			Result:= "Title: " + tc.content + "%N"
		end
	convert_snippet(tc: SNIPPET_LEAF): STRING
		do
			Result:= "%N" + tc.content + "%N"
		end
end

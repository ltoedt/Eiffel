note
	description: "Summary description for {MARKDOWN_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MARKDOWN_VISITOR

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
			string:= ""
			from
				i:= 1
			until
				i > tc.doc.count
			loop
				j:= tc.doc[i]
				string:= string + j.accept (Current) + "%N"
				i:= i + 1
			end
			Result:= string
		end
	convert_paragraph(tc: PARAGRAPH_LEAF): STRING
		do
			Result:= ""
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			if tc.is_id then
				Result:= "<a name =%"" + tc.show_id + "%">%N" + tc.content + "</a>"
			else
				Result:= "%N" + tc.content + "%N"
			end

		end
	convert_list_ordered(tc: LIST_LEAF): STRING
		local
			i: INTEGER
			string: STRING
		do
			string:= ""
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			from
				i:= 1
			until
				i > tc.content.count
			loop
				string:= string + i.out + ". " + tc.content[i] + "%N"
				i:= i + 1
			end

			if tc.is_id then
				Result:= "<a name =%"" + tc.show_id + "%">%N" + string + "</a>%N"
			else
				Result:= string
			end
		end
	convert_list_unordered(tc: LIST_LEAF): STRING
		local
			i: INTEGER
			string: STRING
		do
			string:= ""
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			from
				i:= 1
			until
				i > tc.content.count
			loop
				string:= string + "* " + tc.content[i] + "%N"
				i:= i + 1
			end

			if tc.is_id then
				Result:= "<a name =%"" + tc.show_id + "%">%N" + string + "</a>%N"
			else
				Result:= string
			end

		end
	convert_table(tc: TABLE_LEAF): STRING
		local
			i: INTEGER
			l: INTEGER
			string: STRING
		do
			string:= ""
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			from
				i:= 1
			until
				i > tc.show_row + 1
			loop
				from
					l:= 1
				until
					l > tc.show_col
				loop
					if i = 1 then
						string:= string + tc.table[(i-1)*tc.show_col+l] + " | "
						l:= l + 1
					elseif i = 2 then
						string:= string + "-------------" + " | "
						l:= l + 1
					else
						string:= string + tc.table[(i-2)*tc.show_col+l] + " | "
						l:= l + 1
					end

				end
				string:= string + "%N"
				i:= i + 1
			end

			if tc.is_id then
				Result:= "<a name =%"" + tc.show_id + "%">%N" + string + "</a>%N"
			else
				Result:= string
			end
		end
	convert_image(tc: IMAGE_LEAF): STRING
		do
			Result:= ""
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			Result:= "[](" + tc.path_string + ")"
			if tc.is_id then
				Result:= "<a name =%"" + tc.show_id + "%">%N" + Result + "</a>%N"
			end
		end
	convert_anchor_links(tc: A_LINK_LEAF): STRING
		do
			if tc.reference_to.show_id.is_empty then
				tc.reference_to.set_id("a" + counter.out)
				counter:= counter + 1
			end

			Result:= "[" + tc.linker_text + "](#" + tc.reference_to.show_id + ")"
		end
	convert_external_links(tc: E_LINK_LEAF): STRING
		do
			Result:= "[" + tc.linker_text + "]"+ "(" + tc.reference_to + ")"
		end
	convert_internal_links(tc: I_LINK_LEAF): STRING
		do
			Result:= "[" + tc.linker_text + "]"+ "(./" + tc.reference_to.doc_name + ".md)"
		end
	convert_header(tc: HEADER_LEAF): STRING
		require else-- No order higher than 6
			tc.order < 7
		local
			i: INTEGER
		do
			Result:= ""
			from
				i:= 1
			until
				i > tc.order
			loop
				Result:= Result + "#"
				i:= i + 1
			end

			Result:= Result + tc.content + "%N"

			if tc.is_id then
				Result:= "<a name =%"" + tc.show_id + "%">%N" + Result + "</a>"
			end
		end
	convert_snippet(tc: SNIPPET_LEAF): STRING
		do
			Result:= "%N" + tc.content + "%N"
		end
end


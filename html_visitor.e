note
	description: "Summary description for {HTML_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_VISITOR
inherit
	VISITOR
		redefine
			convert_document, convert_paragraph, convert_list_ordered, convert_list_unordered, convert_table, convert_image, convert_anchor_links, convert_external_links, convert_header, convert_snippet, convert_internal_links
	end
create
	new
feature {TEXT_COMPONENT} --Procedures
	convert_document(tc: DOCUMENT): STRING
		local
			string: STRING
			i: INTEGER
		do
			string:= "%N<html>%N<body>%N"

			from
				i:= 1
			until
				i > tc.doc.count
			loop
				string:= string + tc.doc[i].accept (Current) + "%N"
				i:= i + 1
			end

			string:= string + "</body>%N</html>%N"

			Result:= string
		end

	convert_paragraph(tc: PARAGRAPH_LEAF): STRING
		require else
			tc.content.has_substring ("<p>") = False
			tc.content.has_substring ("<\p>") = False
		local
			string: STRING
		do
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			if not tc.is_id then
				string:= "    <p> " + tc.content + " </p>"
			else
				string:= "    <p id=%"" + tc.show_id + "%"> " + tc.content + " </p>"
			end

			Result:= string
		end

	convert_list_ordered(tc: LIST_LEAF): STRING
		local
			string: STRING
			i: INTEGER
		do
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			if not tc.is_id then
				string:= "    <ol>%N"
			else
				string:= "    <ol id=%"" + tc.show_id + "%">%N"
			end

			from
				i:= 1
			until
				i > tc.content.count
			loop
				string:= string + "        " + "<li> " + tc.content[i] + " </li>"+ "%N"
				i:= i + 1
			end

			string:= string + "    </ol>"

			Result:= string
		end

	convert_list_unordered(tc: LIST_LEAF): STRING
		local
			string: STRING
			i: INTEGER
		do
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			if not tc.is_id then
				string:= "    <ul>%N"
			else
				string:= "    <ul id=%"" + tc.show_id + "%">%N"
			end

			from
				i:= 1
			until
				i > tc.content.count
			loop
				string:= string + "        " + "<li> " + tc.content[i] + " </li>"+ "%N"
				i:= i + 1
			end

			string:= string + "    </ul>"

			Result:= string
		end

	convert_table(tc: TABLE_LEAF): STRING
		local
			i: INTEGER
			j: INTEGER
			l: INTEGER
			str: STRING
		do
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			if not tc.is_id then
				str:= "%N    <table>%N    <tr>%N"
			else
				str:= "%N    <table id=%""+ tc.show_id + "%">%N    <tr>%N"
			end

			from
				i:= 1
			until
				i > tc.show_col
			loop
				str:= str + "        <th>"+tc.table[i]+"</th>%N"
				i:= 1 + i
			end
			str:= str + "    </tr>%N"
			from
				i:= 2
			until
				i > tc.show_row
			loop
				str:= str + "    <tr>%N"
				from
					l:= 1
				until
					l > tc.show_col
				loop
					j:= (i-1)*tc.show_col+l
					str:= str + "        <td>"+ tc.table[j] + "</td>%N"
					l:= l + 1
				end
				str:= str + "    </tr>%N"
				i:= i + 1
			end
			str:= str + "    </table>%N"
			Result:= str
		end

	convert_image(tc: IMAGE_LEAF): STRING
		local
			str: STRING
		do
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			if tc.is_id then
				str:= "    <img id=%"" + tc.show_id + "%" src=%"" + tc.path_string + "%">%N"
			else
				str:= "    <img src=%"" + tc.path_string + "%">%N"
			end

			Result:= str
		end

	convert_anchor_links(tc: A_LINK_LEAF): STRING
		do
			if tc.reference_to.show_id.is_empty then
				tc.reference_to.set_id("a" + counter.out)
				counter:= counter + 1
			end

			Result:= "    <a href =%"#" + tc.reference_to.show_id + "%">" + tc.linker_text +"</a>%N"
		end

	convert_external_links(tc: E_LINK_LEAF): STRING
		do
			Result:= "    <a href =%"" + tc.reference_to + "%">" + tc.linker_text +"</a>%N"
		end
	convert_internal_links(tc: I_LINK_LEAF): STRING
		do
			Result:= "    <a href=%"./" + tc.reference_to.doc_name +".html%">" + tc.linker_text + "</a>"
		end
	convert_header(tc: HEADER_LEAF): STRING
		require else
			tc.show_order > 0 and tc.show_order < 7
		local
			string: STRING
		do
			if tc.show_id.is_empty then
				tc.set_id("a" + counter.out)
				counter:= counter + 1
			end

			if not tc.is_id then
				string:= "    <h" + tc.order.out + "> " + tc.content + "</h" + tc.order.out + ">"
			else
				string:= "    <h" + tc.order.out + " id=%"" + tc.show_id + "%"> " + tc.content + "</h" + tc.order.out + ">"
			end

			Result:= string
		end

	convert_snippet(tc: SNIPPET_LEAF): STRING
		do
			Result:= tc.content
		end
end

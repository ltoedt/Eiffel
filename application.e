note
	description: "composite-visitor-html-generator application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature
	text_1: PARAGRAPH_LEAF
	header_1: HEADER_LEAF
	list_1: LIST_LEAF
	list_2: LIST_LEAF
	link_1: A_LINK_LEAF
	link_2: E_LINK_LEAF
	link_3: E_LINK_LEAF
	link_4: A_LINK_LEAF
	link_5: A_LINK_LEAF
	link_6: I_LINK_LEAF
	link_7: A_LINK_LEAF
	img_1: IMAGE_LEAF
	table_1: TABLE_LEAF
	entry1: ARRAYED_LIST [STRING]
	entry2: ARRAYED_LIST [STRING]
	doc: DOCUMENT
	doc2: DOCUMENT
	html_v: HTML_VISITOR
	view_v: TEXT_VISITOR
	md_v: MARKDOWN_VISITOR
	html_doc: STRING
	view_doc: STRING
	md_doc: STRING

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			i: INTEGER
		do
	-- Header
			create header_1.make("This is the title",1)
	-- Paragraph
			create text_1.new
			text_1.add_content("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ")
	-- Unordered List
			create list_1.new
			list_1.add_item ("Normal Text")
			list_1.add_item ("HTML")
			list_1.add_item ("Markdown")

	-- Ordered List
			create list_2.new
			list_2.add_item ("Normal Text")
			list_2.add_item ("HTML")
			list_2.add_item ("Markdown")
			list_2.set_order (TRUE)

	-- Image		
			create img_1.new("./eiffel65.jpg")

	-- Table
			create table_1.new
			create entry1.make (0)
			entry1.extend("Name")
			entry1.extend("Age")
			entry1.extend("Profession")

			create entry2.make (0)
			entry2.extend("Tim")
			entry2.extend("25")
			entry2.extend("Hairdresser")


			table_1.add_row (entry1)

			from
				i:= 1
			until
				i = 10
			loop
				table_1.add_row(entry2)
				i:= i + 1
			end

	-- add links
			create link_5.make(table_1,"Go to table")
			create link_4.make(list_1, "Go to list")
			create link_1.make(text_1, "Click here")
			create link_2.make("https://de.wikipedia.org/wiki/Hypertext_Markup_Language", "Gehe zu Wikipedia")
			create link_3.make("https://www.youtube.com/watch?v=BinWA0EenDY", "Neugierig ;)?")
			create link_7.make(img_1, "Go to picture")

	-- Document
			create doc.new("doc1")

			doc.add_item (header_1)
			doc.add_item (link_5)
			doc.add_item (link_3)
			doc.add_item (text_1)
			doc.add_item (list_1)
			doc.add_item (table_1)
			doc.add_item (link_1)
			doc.add_item (link_2)
			doc.add_item (img_1)
			doc.add_item (link_4)
			doc.add_item (link_7)

	-- Other document	
			create doc2.new("doc2")
			doc2.add_item (list_2)

	-- Internal link
			create link_6.make(doc2, "Click here")
			doc.add_item (link_6)
	-- Conversion
	-- HTML
			create html_v.new
			html_doc:= doc.accept(html_v)
			print(html_doc)

	-- Text (normal)
			create view_v.new
			view_doc:= doc.accept (view_v)
			print(view_doc)

	-- Markdown
			create md_v.new
			md_doc:= doc.accept(md_v)
			print(md_doc)

	end
end

note
	description: "Summary description for {TABLE_LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_LEAF
inherit
	NESTED_TEXT_COMPONENT
		redefine
			accept
	end
create
	new
feature -- Public Attributes
	table: ARRAYED_LIST [STRING]
feature {None} -- Private Attributes
	row: INTEGER
	col: INTEGER

feature {VISITOR} -- Protected Procedures
	show_row: INTEGER
		do
			Result:= row
		end
	show_col: INTEGER
		do
			Result:= col
		end
feature -- Public Procedures
	new
		do
			create table.make (0)
			row:= 0
			col:= 0

			id:= ""
			ada_id:= FALSE
		end

	add_row(r: ARRAYED_LIST [STRING])
		require -- table can contain a maximum of 100 items and thus can consist of one row with 100 entries
			r.count < 101
		local
			j: INTEGER
			tmp: ARRAYED_LIST [STRING]
		do
	-- first row was added
			-- copy of original table in case newly added items exceed 200 character limit
			tmp:= table
			if col = 0 then
				from
					j:= 1
				until
					j > r.count
				loop
					-- make sure item doesn't exceed 200 characters
					if r[j].count < 201 then
						table.extend(r[j])
						j:= j + 1
					-- if item exceeds 200 characters end loop and restore original table
					else
						j:= r.count + 10
						table:= tmp
					end
				end

				-- if loop was left under normal conditions update col and row
				if j = r.count + 1 then
					col := r.count
					row := 1
				end
	-- Input row has to have exactly col entries to fit into the table (if not first row)
			elseif r.count = col then
				from
					j:= 1
				until
					j > r.count
				loop
					-- make sure item doesn't exceed 200 characters
					if r[j].count < 201 then
						table.extend(r[j])
						j:= j + 1
					-- if item exceeds 200 characters end loop and restore original table
					else
						j:= r.count + 10
						table:= tmp
					end
				end

				-- if loop was left under normal conditions update col and row
				if j = r.count + 1 then
					row:= row + 1
				end
	-- If the amount of elements and the number of columns doesn't match, the user has to try again
			else
				print("Your input doesn't match the dimensions of the table! We need " + col.out + "entries")
			end
		ensure -- at most 100 items in table
			row*col < 101
		end

	accept(V: VISITOR): STRING
		do
			Result:= V.convert_table(Current)
		end
end

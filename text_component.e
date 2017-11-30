note
	description: "Summary description for {TEXT_COMPONENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_COMPONENT
feature
	accept(V: VISITOR): STRING
		do
			Result:= ""
		end
end

module Mongoid
 module Document
   def as_json(options={})
     puts 'ASJSON'
     attrs = super(options)
     attrs["id"] = attrs["_id"].to_s
     attrs
   end
 end
end

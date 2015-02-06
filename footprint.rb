class Footprint
	attr_reader :x
	attr_reader :y
	attr_reader :previous

	def initialize(x,y,source = nil)
		@x = x
		@y = y
		@previous = ""
		@previous = to_string() unless source.nil?
	end

	def to_string()
		return "("<<@x.to_s<<","<<@y.to_s<<")"
	end

	def set_previous(prev)
		@previous = prev
	end

end


# test = Footprint.new(1,2)
# puts test.to_string

# test.set_previous("(1,3)")
# puts test.previous

class MazeMaker

	def initialize(row,col)
		@row = row*2+1
		@col = col*2+1
		@maze = Array.new(@row) { Array.new(@col) { 0 } }
	end

	def make_maze()
		set_boarders()
		set_walls()
		return to_string()
	end


	def set_boarders()
		@maze[0].fill(1)
		@maze[-1].fill(1)
		@maze = @maze.transpose
		@maze[0].fill(1)
		@maze[-1].fill(1)
		@maze = @maze.transpose
	end

	# def set_cells()
	# 	(1..@row).step(2).each {|row|
	# 		(1..@col).step(2).each {|el|
	# 			@maze[row][el] = 0
	# 		}
	# 	}		
	# end

	def set_walls(r,c)
	 	(2..@row-2).step(2).each {|row|
			(2..@col-2).step(2).each {|el|
				@maze[row][el] = 1
				@maze[row][el-1] = rand.round
				@maze[row-1][el] = rand.round
			}
		}			
	end

	def to_string
		return @maze.join
	end

end


# test = MazeMaker.new(9,9)
# test.set_boarders
# test.set_walls
# puts test.to_string


class Maze

	def initialize(m,n)
		@row = m
		@col = n
		@maze_str = ""
		@maze = []
	end


	def load(str = nil)
		if str.nil?
			@maze_str = "111111111100010001111010101100010101101110101100000101111011101100000101111111111"
			# (0..@row*@col-1).each do 
			# 	@maze_str << rand.round
			# end
		else
			@maze_str = str
		end

		idx = 0
		map_row = @row*2+1
		map_col = @col*2+1

		(0..map_row).each do 
			tmp = @maze_str.slice(idx,map_col).split("").map{|x| x.to_i}
			@maze.push(tmp)
			idx += map_col
		end

		return @maze
	end

	def display()

		chars = [' ','+','-','|']

		@maze.each_with_index {|row,i|
			cur_row = ""
			if i.even?
				row.each_with_index {|el,j|
					cur_row << chars[(j%2+1)*@maze[i][j]]
				}
				puts cur_row
			else
				row.each_with_index {|el,j|
					cur_row << chars[3*@maze[i][j]]
				}
				puts cur_row
			end
		}

	end

end


myStr = "111111111100010001111010101100010101101110101100000101111011101100000101111111111"


test = Maze.new(4,4)

test.load()

test.display()




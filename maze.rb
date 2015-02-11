require './maze_solver.rb'
require './maze_maker.rb'

class Maze

	def initialize(m,n)
		@row = m
		@col = n
		@maze_str = ""
		@maze = []
	end


	def load(str = nil)

		@maze_str = str.nil? ? "111111111100010001111010101100010101101110101100000101111011101100000101111111111" : str
	
		@maze = []
		idx = 0
		map_row = @row*2+1
		map_col = @col*2+1

		(0..map_row).each do 
			tmp = @maze_str.slice(idx,map_col).split("").map{|x| x.to_i}
			@maze.push(tmp)
			idx += map_col
		end
	end

	def display(trace = nil)

		trace = @maze unless !trace.nil?

		evenchars = [' ','+','-']
		oddchars = [' ','|','o']

		(0..trace.size-1).step(2).each {|r|
			cur_row = ""
			trace[r].each_with_index {|el,c|
				cur_row << evenchars[(c%2+1)*el]
			}
			puts cur_row
			cur_row = ""
			trace[r+1].each_with_index {|el,j|
				cur_row << oddchars[(el)]
			}
			puts cur_row
		}
	end

	def solve(begX,begY,endX,endY)

		temp = Marshal.load(Marshal.dump(@maze))
		maze_solver = MazeSolver.new(temp)
		return maze_solver.solve(begX,begY,endX,endY)
	end

	def trace(begX,begY,endX,endY)

		solution = Marshal.load(Marshal.dump(@maze))
		maze_solver = MazeSolver.new(solution)
		yarn = maze_solver.trace(begY,begX,endY,endX)

		if yarn
			follow_yarn([endY,endX],[begY,begX],solution,yarn)
			display(solution)
		else
			puts "No way out."
		end
	end

	def follow_yarn(cur,endxy,solution,yarn)
		solution[(cur[0])*2+1][(cur[1])*2+1] = 2
		if cur == endxy
			return solution
		end
		follow_yarn(yarn[cur],endxy,solution,yarn)
	end

	def redesign()
		new_maze = MazeMaker.new(@row,@col)
		new_str = new_maze.make_maze()
		load(new_str)
	end

end


myStr = "111111111100010001111010101100010101101110101100000101111011101100000101111111111"

test = Maze.new(4,4)

test.load(myStr)

puts "display initial maze:"
test.display

puts "show trace from (1,0) to (3,3):"
test.trace(1,0,3,3)

puts "show trace from (2,0) to (1,3):"
test.trace(2,0,1,3)

puts "display new maze:"
test.redesign
test.display

puts "show trace from (0,0) to (3,3):"
test.trace(0,0,3,3)

puts "show trace from (2,0) to (1,3):"
test.trace(2,0,1,3)






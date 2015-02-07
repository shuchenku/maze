require './maze_solver.rb'
require './maze_generator.rb'

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
		else
			@maze_str = str
		end

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

		if trace.nil?
			trace = @maze
		end

		evenchars = [' ','+','-']
		oddchars = [' ','|','o']

		trace.each_with_index {|row,i|
			cur_row = ""
			if i.even?
				row.each_with_index {|el,j|
					cur_row << evenchars[(j%2+1)*el]
				}
				puts cur_row
			else
				row.each_with_index {|el,j|
					cur_row << oddchars[(el)]
				}
				puts cur_row
			end
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
		yarn = maze_solver.trace(begX,begY,endX,endY)

		if yarn
			solution[(begX-1)*2+1][(begY-1)*2+1] = 2
			cur = [endX,endY]

			while (cur != [begX,begY])
				solution[(cur[0]-1)*2+1][(cur[1]-1)*2+1] = 2
				cur = yarn[cur]
			end

			display(solution)
		else
			puts "No way out."
		end
	end

	def redesign()
		new_maze = MazeMaker.new(@row,@col)
		new_str = new_maze.make_maze()
		load(new_str)
		display()
	end

end


myStr = "111111111100010001111010101100010101101110101100000101111011101100000101111111111"


test = Maze.new(4,4)

test.load(myStr)

test.display

test.trace(1,1,4,4)

test.trace(2,2,3,3)

test.display

test.redesign

test.trace(1,1,4,4)




require 'Set'

class MazeSolver

	attr_reader :ns_wall
	attr_reader :ew_wall

	def initialize(maze)
		@maze = maze
		@row = (maze.size-1)/2
		@col = (maze[0].size-1)/2
		@ns_wall = []
		@ew_wall = []
		@yarn = Hash.new
		get_walls()
	end

	def solve(begX,begY,endX,endY)
		return search(begX,begY,endX,endY)
	end

	def get_walls()

		(0..@row-1).each {|i|
			ewtmp = []
			nstmp = []
			(0..@col-2).each {|j|
				ewtmp << @maze[i*2+1][j*2+2]
				nstmp << @maze[j*2+2][i*2+1]
			}
			@ew_wall.push(ewtmp)
			@ns_wall.push(nstmp)
		}

	end

	def search(begX,begY,endX,endY)
		
		visited = Set.new [[begX,begY]]
		newly_visited = Set.new visited	
		tmp = Set.new

		while !visited.include?([endX,endY])

			newly_visited.each {|el|
				tmp.merge(find_next(el))
			}

			newly_visited.clear()
			newly_visited.merge(tmp)
			visited.merge(tmp)
			tmp.clear()

			if newly_visited.empty?
				return false
			end
		end

		return true

	end


	def find_next(coordinate,trace = nil)

		x = coordinate[0]
		y = coordinate[1]

		next_cells = Set.new
		# check left
		unless @ew_wall[x-1][y-1] == 1 || y == @col || @yarn.has_key?([x,y+1])
	 		next_cells.add([x,y+1])
	 		@yarn[[x,y+1]] = [x,y]
		end

		# check right
		unless @ew_wall[x-1][y-2] == 1 || y == 1 || @yarn.has_key?([x,y-1])
			next_cells.add([x,y-1])
			@yarn[[x,y-1]] = [x,y]
		end

		# check down
		unless @ns_wall[y-1][x-1] == 1 || x == @row || @yarn.has_key?([x+1,y])
	 		next_cells.add([x+1,y])
	 		@yarn[[x+1,y]] = [x,y]
		end

		# check up
		unless @ns_wall[y-1][x-2] == 1 || x == 1 || @yarn.has_key?([x-1,y])
			next_cells.add([x-1,y])
			@yarn[[x-1,y]] = [x,y]
		end

		return next_cells
	end

	def trace(begX,begY,endX,endY)
		
		if search(begX,begY,endX,endY)
			return @yarn
		else
			return false
		end
		
	end
	
end






require 'Set'

class MazeSolver

	def initialize(maze)
		@maze = maze
		@row = (maze.size-1)/2
		@col = (maze[0].size-1)/2
		@ns_wall = []
		@ew_wall = []
		@yarn = Hash.new
		get_walls()
	end

	def solve(begcol,begrow,endcol,endrow)
		return search(begcol,begrow,endcol,endrow)
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

	def search(begcol,begrow,endcol,endrow)
		
		visited = Set.new [[begcol,begrow]]
		newly_visited = Set.new visited	
		tmp = Set.new

		while !visited.include?([endcol,endrow])

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

		r = coordinate[0]
		d = coordinate[1]

		next_cells = Set.new
		# check left
		unless @ew_wall[r-1][d-1] == 1 || d == @col || @yarn.has_key?([r,d+1])
	 		next_cells.add([r,d+1])
	 		@yarn[[r,d+1]] = [r,d]
		end

		# check right
		unless @ew_wall[r-1][d-2] == 1 || d == 1 || @yarn.has_key?([r,d-1])
			next_cells.add([r,d-1])
			@yarn[[r,d-1]] = [r,d]
		end

		# check down
		unless @ns_wall[d-1][r-1] == 1 || r == @row || @yarn.has_key?([r+1,d])
	 		next_cells.add([r+1,d])
	 		@yarn[[r+1,d]] = [r,d]
		end

		# check up
		unless @ns_wall[d-1][r-2] == 1 || r == 1 || @yarn.has_key?([r-1,d])
			next_cells.add([r-1,d])
			@yarn[[r-1,d]] = [r,d]
		end

		return next_cells
	end

	def trace(begcol,begrow,endcol,endrow)
		
		if search(begcol,begrow,endcol,endrow)
			return @yarn
		else
			return false
		end
		
	end
	
end





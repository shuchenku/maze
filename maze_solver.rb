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
	end

	def solve(begX,begY,endX,endY)
		get_walls()

		mid = search(begX,begY,endX,endY)
		begroute = [[begX,begY]]
		endroute = [[endX,endY]]

		if mid.empty?
			return mid
		end
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

	def search(begX,begY,endX,endY,trace = nil)
		
		begset = Set.new [[begX,begY]]
		endset = Set.new [[endX,endY]]
		begnew = Set.new begset
		endnew = Set.new endset

		while begset.intersection(endset).empty?

			begnew.each {|el|
				begset.merge(find_next(el))
			}

			begnew = begset - begnew

			endnew.each {|el|
				endset.merge(find_next(el))
			}

			endnew = endset - endnew

			if begnew.empty? || endnew.empty?
				return Set.new
			end
		end

		return begset.intersection(endset)
	end


	def find_next(coordinate,trace = nil)

		next_cells = Set.new
		# check left
		unless @ew_wall[coordinate[0]-1][coordinate[1]-1] == 1 || coordinate[1] == @col
	 		next_cells.add([coordinate[0],coordinate[1]+1])
		end

		# check right
		unless @ew_wall[coordinate[0]-1][coordinate[1]-2] == 1 || coordinate[1] == 1
			next_cells.add([coordinate[0],coordinate[1]-1])
		end

		# check down
		unless @ns_wall[coordinate[1]-1][coordinate[0]-1] == 1 || coordinate[0] == @row
	 		next_cells.add([coordinate[0]+1,coordinate[1]])
		end

		# check up
		unless @ns_wall[coordinate[1]-1][coordinate[0]-2] == 1 || coordinate[0] == 1
			next_cells.add([coordinate[0]-1,coordinate[1]])
		end

		return next_cells
	end

	def to_string(x,y)
		return "("<<x.to_s<<","<<y.to_s<<")"
	end


	
end






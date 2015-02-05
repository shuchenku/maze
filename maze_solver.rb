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

	def dijkstra2_lite(begX,begY,endX,endY)
		begset = Set.new [[begX,begY]]
		endset = Set.new [[endX,endY]]
		begnew = Set.new [[begX,begY]]
		endnew = Set.new [[endX,endY]]

		while begset.intersection(endset).empty?

		begtmp = Set.new
		endtmp = Set.new
			begsize = begset.size
			endsize = endset.size

			begnew.each {|el|
			 	unless @ew_wall[el[0]-1][el[1]-1] == 1 || el[1] == @col
			 		begset.add([el[0],el[1]+1])
					begtmp.add([el[0],el[1]+1])
				end

				unless @ew_wall[el[0]-1][el[1]-2] == 1 || el[1] == 1
					begset.add([el[0],el[1]-1])
					begtmp.add([el[0],el[1]-1])
				end

				unless @ns_wall[el[1]-1][el[0]-1] == 1 || el[0] == @row
			 		begset.add([el[0]+1,el[1]])
					begtmp.add([el[0]+1,el[1]])
				end

				unless @ns_wall[el[1]-1][el[0]-2] == 1 || el[0] == 1
					begset.add([el[0]-1,el[1]])
					begtmp.add([el[0]-1,el[1]])
				end
			}

			begnew.clear()
			begnew.merge(begtmp)

			endnew.each {|el|

				unless @ew_wall[el[0]-1][el[1]-1] == 1 || el[1] == @col
			 		endset.add([el[0],el[1]+1])
					endtmp.add([el[0],el[1]+1])
				end

				unless @ew_wall[el[0]-1][el[1]-2] == 1 || el[1] == 1
					endset.add([el[0],el[1]-1])
					endtmp.add([el[0],el[1]-1])
				end

				unless @ns_wall[el[1]-1][el[0]-1] == 1 || el[0] == @row
			 		endset.add([el[0]+1,el[1]])
					endtmp.add([el[0]+1,el[1]])
				end

				unless @ns_wall[el[1]-1][el[0]-2] == 1 || el[0] == 1
					endset.add([el[0]-1,el[1]])
					endtmp.add([el[0]-1,el[1]])
				end
			}
			endnew.clear()
			endnew.merge(endtmp)

			if begset.size == begsize && endset.size == endsize
				return Set.new
			end
		end
		return begset.intersection(endset)
	end
	
end






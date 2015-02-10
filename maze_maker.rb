class MazeMaker

	def initialize(row,col)
		@row = row
		@col = col
		@maze = Array.new(row*2+1) { Array.new(col*2+1) { 0 } }
	end

	def make_maze()
		fill_with_walls()
		prim()
		return to_string()
	end

	def fill_with_walls()
		@maze[0].fill(1)
		@maze[-1].fill(1)
		set_blockade()
	end

	def set_blockade()
	 	(1..@maze.size-1).step(2).each {|row|
			(0..@maze[0].size-1).step(2).each {|el|
				@maze[row][el] = 1
			}
			@maze[row+1].fill(1)
		}			
	end

	# Start with a grid full of walls.
	# Pick a cell, mark it as part of the maze. Add the walls of the cell to the wall list.
	# While there are walls not yet visited:
	# 		Pick a random wall from the list. If the cell on the opposite side isn't in the maze yet:
	# 				Make the wall a passage and mark the cell on the opposite side as part of the maze.
	# 				Add the neighboring walls of the cell to the wall list.
	# 		Remove the wall from the list.

	def prim()
		cell_set = Set.new
		wall_set = Set.new

		init = [0,0]
		cell_set.add(init)

		new_walls = Set.new [wall_above(init),wall_below(init),wall_left(init),wall_right(init)]
		wall_set.merge(new_walls)

		while cell_set.size<@row*@col

			STDOUT.sync = true
			chosen_wall = choose_from_set(wall_set)
			new_cell = peek_over_wall(chosen_wall,cell_set) 

			unless new_cell.nil?
				new_walls = Set.new [wall_above(new_cell),wall_below(new_cell),wall_left(new_cell),wall_right(new_cell)]
				wall_set.merge(new_walls)
				cell_set.add(new_cell)
				wall_set = wall_set.delete(chosen_wall)
				break_wall(chosen_wall)
			end
		end
	
	end

	def choose_from_set(set)
		idx = rand(0..set.size-2)
		el = set.delete(nil).to_a[idx]
		return el
	end

	def peek_over_wall(wall,cell_set)

		if cell_set.include?([wall[0],wall[1]])
			if wall[2] == "v" && wall[1]<@col-1 && !cell_set.include?([wall[0],wall[1]+1])
				return [wall[0],wall[1]+1]
			elsif wall[2] == "h" && wall[0]<@row-1 && !cell_set.include?([wall[0]+1,wall[1]])
				return [wall[0]+1,wall[1]]
			else
				return nil
			end
		else
			return [wall[0],wall[1]]
		end
	end

	def break_wall(wall)
		
		ri = wall[0]*2+1
		ci = wall[1]*2+1

		if (wall[2] == "v" && wall[1]<@col-1) || (wall[2] == "h" && wall[0]>@row-2)
			@maze[ri][ci+1] = 0
		else
			@maze[ri+1][ci] = 0
		end

	end

	def wall_above(cell)
		wall = cell[1]==0? nil:[cell[0],cell[1]-1,"h"]
		return wall
	end

	def wall_below(cell)
		wall = cell[1]==@row-2? nil:[cell[0],cell[1],"h"]
		return wall
	end

	def wall_left(cell)
		wall = cell[0]==0? nil:[cell[0]-1,cell[1],"v"]
		return wall
	end

	def wall_right(cell)
		wall = cell[0]==@col-2? nil:[cell[0],cell[1],"v"]
		return wall
	end

	def to_string
		return @maze.join
	end
	
end


# test = MazeMaker.new(9,9)
# test.set_boarders
# test.set_walls
# puts test.to_string


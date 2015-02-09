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
	# While there are walls in the list:
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

		el = []
		while true
			idx = rand(0..set.size-1)
			el = set.to_a[idx]

			if !el.nil?
				break
			end
		end
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
		
		ri = wall[0]
		ci = wall[1]

		if wall[2] == "v"
			if ci<@col-1
				@maze[ri*2+1][ci*2+2] = 0
			else
				@maze[ri*2+2][ci*2+1] = 0
			end
		elsif wall[2] == "h"
			if ri<@row-1
				@maze[ri*2+2][ci*2+1] = 0
			else
				@maze[ri*2+1][ci*2+2] = 0
			end
		end

	end

	def wall_above(cell)
		wall = cell[1]==0? nil:[cell[0],cell[1]-1,"h"]
		# puts wall_to_string(wall)
		return wall
	end

	def wall_below(cell)
		wall = cell[1]==@row-2? nil:[cell[0],cell[1],"h"]
		# puts wall_to_string(wall)
		return wall
	end

	def wall_left(cell)
		wall = cell[0]==0? nil:[cell[0]-1,cell[1],"v"]
		# puts wall_to_string(wall)
		return wall
	end

	def wall_right(cell)
		wall = cell[0]==@col-2? nil:[cell[0],cell[1],"v"]
		# puts wall_to_string(wall)
		return wall
	end


	# def wall_to_string(wall)
	# 	if wall.nil?
	# 		str = nil
	# 	else
	# 		str = "[" + wall[0].to_s + "," + wall[1].to_s + "," + wall[2] + "]"
	# 	end
	# 	return str
	# end

	# def set_orientation(l,r,u,d)
	# 	# horizontial = 0; vertical = 1
	# 	orient = (r-l)>(d-u)? 1:0
	# 	return orient
	# end

	# def tear_walls(l,r,u,d)
		
	# 	orient = set_orientation(l,r,u,d)

	# 	if orient == 1 && r-l>1
	# 		ci = rand(l+1..r-1)
	# 		ri = rand(u..d)
	# 		@maze[ri*2-1][ci*2] = 0 unless ri == @row
	# 		tear_walls(l,ci,u,d)
	# 		tear_walls(ci+1,r,u,d)
	# 	elsif orient == 0 && d-u>1
	# 		ci = rand(l..r)
	# 		ri = rand(u+1..d-1)
	# 		@maze[ri*2][ci*2-1] = 0 unless ci == @col
	# 		tear_walls(l,r,ri,d)
	# 		tear_walls(l,r,u,ri)
	# 	end

	def to_string
		return @maze.join
	end

end


# test = MazeMaker.new(9,9)
# test.set_boarders
# test.set_walls
# puts test.to_string


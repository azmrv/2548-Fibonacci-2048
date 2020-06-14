extends Node2D


# Signals
signal new_game
signal game_over
signal moving_numbers
signal exit_game
signal save_player_data


# Grid Variables
var x_start
var y_start
var offset


# Touch Variables
var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var last_direction = 0

# Game Hard Level
# количество цифр за ход
# начальное количество цифр на доске
# размер доски 4х4 / 6х6 / 8х8
var hard_level = 3
var iq_level = 0
var new_game_numbers = 3

var game_field_size = 6 

#var numbers_array = 
#[
#preload("res://scenes/2_number.tscn"),
#preload("res://scenes/4_number.tscn")
#]

var game_window_width = 500
var game_window_heigth = 700
var game_window_margin = 3

var game_field_width = 100
var game_field_heigth = 100
var game_field_margin = 3

var summ = 0
var eend = 3

var game_field = [[], []]

var randgen = RandomNumberGenerator.new()

var current_score = 0
var total_score = 0
var best_score = 0




func _ready():
	randomize()
	game_field = make_2d_array()
	setup()


func _process(_delta):		
	touch_input()
	randomize()
	

func setup():
	new_game_field()	


func game_over():
	$Music.stop()
	$DeathSound.play()
	$Background.color = Color(1, 0, 0, 1)
	$ScoreTimer.stop()
	$MobTimer.stop()	
	$HUD.show_game_over()	
	get_tree().call_group("mobs", "queue_free")
	$Background.color = Color(0.098039, 0.823529, 0.501961)
	
	
func new_game():	
	$Music.play()
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")



func new_game_field():	
	for	x in new_game_numbers:
		if possible_match_on_board() == true:
			game_field = possible_numbers(game_field)



func exit_game():
	get_tree().quit()

	
func increase_score(amount):
	current_score += amount
	total_score += current_score
	

func make_2d_array():
	var array = []
	for i in game_field_size:
		array.append([])
		for j in game_field_size:
			array[i].append(null)
	return array


func show_message(text):
	$GUI/GUI_InGamePlay/Message.text = text
	$GUI/GUI_InGamePlay/Message.show()
	$GUI/GUI_InGamePlay/MessageTimer.start()


func game_over():
	#print("КОНЕЦ ИГРЫ", "СУММА =", summ)
	show_message("Game Over, Score = %s" % total_score)
	# emit signal?
	summ = 0
	setup()
				

func possible_numbers(array):	
	var kodn = 1	
	while kodn == 1:
		var nx = randgen.randf()
		var ny = randgen.randf()
		var x = int(nx * game_field_size / 1)
		var y = int(ny * game_field_size / 1)
		print(x, y)
		if array[x][y] == 0:
			kodn = 0
			var num = randgen.randf()
			if num <= 0.45:
				array[x][y] = 1
				summ += 1
			elif num <= 0.73:
				array[x][y] = 2
				summ += 2
			elif num <= 0.9:
				array[x][y] = 3
				summ += 3
			else:
				array[x][y] = 5
				summ += 5	
	return array


func is_possible_match():
	for i in game_field_size:
		for j in game_field_size:
			if game_field[i][j] != null:
				var value = game_field[i][j].value
				if j > 0:
					if game_field[i][j - 1].value == value:
						return true
				if j < game_field_size - 1:
					if game_field[i][j + 1].value == value:
						return true
				if i > 0:
					if game_field[i -1][j].value == value:
						return true
				if i < game_field_size - 1:
					if game_field[i + 1][j].value == value:
						return true
	return false


func blank_space_on_board():
	for i in game_field_size:
		for j in game_field_size:
			if game_field[i][j] == null:
				return true
	return false


func possible_match_on_board():	
	if blank_space_on_board():
		return true	
	if is_possible_match():
		return true
	return false


func fill_board():
	if blank_space_on_board():
		generate_new_number()
	else:
		if is_possible_match():
			return
		else:
			game_over()	


func generate_new_number():
	pass


func grid_to_pixel(grid_position):
	var new_x = grid_position.x * offset + x_start
	var new_y = grid_position.y * -offset + y_start
	return (Vector2(new_x, new_y))


func pixel_to_grid(pixel_position):
	var new_x = round((pixel_position.x - x_start) / offset)
	var new_y = round((pixel_position.y - y_start) / -offset)
	return (Vector2(new_x, new_y))


func touch_input():
	if(Input.is_action_just_pressed("ui_touch")):
		first_touch = (get_global_mouse_position())
	if(Input.is_action_just_released("ui_touch")):
		final_touch = (get_global_mouse_position())
		calculate_direction()
		swipe_angle()


func swipe_angle():
	var difference = final_touch - first_touch
	var angle = rad2deg(atan2(difference.x, difference.y))
	print(angle)


func calculate_direction():	
	var difference = final_touch - first_touch
	if abs(difference.x) > abs(difference.y):
		if difference.x >= 25:
			move_right(game_field)						
		elif difference.x <= -25:
			move_left(game_field)						
	elif abs(difference.x) <= abs(difference.y):
		if difference.y <= -25:
			move_up(game_field)
		elif difference.y >= 25:
			move_down(game_field)
	if abs(difference.x) >= 25 || abs(difference.y) >= 25:
		fill_board()


func draw_field():
	pass



func help_draw():
	for row in range(game_field_size):
		for col in range(game_field_size):
			if game_field[row][col] > 0:
				k = game_field[row][col]
				nf = fibn(k)
				#rd = rd - nf*5
				grn = grn - nf*7
				bl = bl - nf*7
				rrd = 0
			else:
				color = white
			k = game_field[row][col]
			if k == 0:
				kk = " "
			else:
				if k > 1500:
					rrd = 255
				kk = str(k)
			x = width*col + margin*(col + 1)
			y = heigth*row + margin*(row + 1)
			#pygame.draw.rect(screen, color, (x, y, width, heigth))
			#text1 = f1.render( kk, 1, (rrd, rrd, rrd))
			#screen.blit(text1, (x + width//8, y + heigth*2//5))

			
func get_empty(mas):
	n_emp = 0
	for i in range(game_field_size):
		#n_emp = 0
		for j in range(game_field_size):
			if mas[i][j] == 0:
				n_emp += 1

	return n_emp


func fibn(k):
	if k == 1:
		return 0
	if k == 2:
		return 1
	sc = 0
	sa = 1
	sb = 2
	n = 1
	while k > sc:
		n += 1
		sc = sa + sb
		sa = sb
		sb = sc
	return n


func move_right(mas):
	kodx2 = 1
	while kodx2 == 1:
		for x in range(1, game_field_size):
			for y in range(game_field_size):
				if mas[y][game_field_size-x-1] > 0:
					if mas[y][game_field_size-x] == 0:
						kodx2 += 1
						mas[y][game_field_size-x] = mas[y][game_field_size-x-1]
						mas[y][game_field_size-x-1] = 0
					elif mas[y][game_field_size-x] == 1 and mas[y][game_field_size-x-1] == 1:
						kodx2 += 1
						mas[y][game_field_size-x] = 2
						mas[y][game_field_size-x-1] = 0
					elif mas[y][game_field_size-x] < mas[y][game_field_size-x-1] and 2 * mas[y][game_field_size-x] >= mas[y][game_field_size-x-1]:
						kodx2 += 1
						mas[y][game_field_size-x] = mas[y][game_field_size-x] + mas[y][game_field_size-x-1]
						mas[y][game_field_size-x-1] = 0
					elif mas[y][game_field_size-x] > mas[y][game_field_size-x-1] and 2 * mas[y][game_field_size-x-1] >= mas[y][game_field_size-x]:
						kodx2 += 1
						mas[y][game_field_size-x] = mas[y][game_field_size-x] + mas[y][game_field_size-x-1]
						mas[y][game_field_size-x-1] = 0
		if kodx2 > 1:
			kodx2 = 1
		else:
			kodx2 = 0
			fill_board()			
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)



	for i in range(column + 1, game_field_size):
		# If it's the end of the board, and that spot is null:
		if i == game_field_size - 1 && game_field[i][row] == null:
			# Move the number there:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(game_field_size - 1, row)))
			game_field[game_field_size - 1][row] = this_number
			break
		# If this spot is full, then move to one before it:
		if game_field[i][row] != null && game_field[i][row].value != value:
			# Move to one before it:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(i - 1, row)))
			game_field[i - 1][row] = this_number
			break
		if game_field[i][row] != null && game_field[i][row].value == value:
			game_field[column][row] = null
			game_field[i][row].start_timer()
			this_number.move(grid_to_pixel(Vector2(i, row)))
			this_number.start_timer()
			var new_number = this_number.next_number.instance()
			add_child(new_number)
			print(new_number)
			game_field[i][row] = new_number
			new_number.position = grid_to_pixel(Vector2(i, row))
			emit_signal("score_changed", new_number.value)
			break
			

func move_left(mas):

	kodx1 = 1
	while kodx1 == 1:
		for x in range(1, game_field_size):
			for y in range(game_field_size):
				if mas[y][x] > 0:
					if mas[y][x-1] == 0:
						kodx1 += 1
						mas[y][x-1] = mas[y][x]
						mas[y][x] = 0
					elif mas[y][x-1] == 1 and mas[y][x] == 1:
						kodx1 += 1
						mas[y][x-1] = 2
						mas[y][x] = 0
					elif mas[y][x-1] < mas[y][x] and 2 * mas[y][x-1] >= mas[y][x]:
						kodx1 += 1
						mas[y][x-1] = mas[y][x-1] + mas[y][x]
						mas[y][x] = 0
					elif mas[y][x-1] > mas[y][x] and 2 * mas[y][x] >= mas[y][x-1]:
						kodx1 += 1
						mas[y][x-1] = mas[y][x-1] + mas[y][x]
						mas[y][x] = 0

		if kodx1 > 1:
			kodx1 = 1
		else:
			kodx1 = 0
			fill_board()
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)





	# Store this number
	var this_number = game_field[column][row]	
	# Store the value of this number:
	var value = game_field[column][row].value
	# Iterate through the columns looking for the end of the board, or a
	# non-empty space.
	for i in range(column - 1, -1, -1):
		# If it's the end of the board, and that spot is null:
		if i == 0 && game_field[i][row] == null:
			# Move the number there:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(0, row)))
			game_field[0][row] = this_number
			break
		# If this spot is full, then move to one before it:
		if game_field[i][row] != null && game_field[i][row].value != value:
			# Move to one before it:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(i + 1, row)))
			game_field[i + 1][row] = this_number
			break
		if game_field[i][row] != null && game_field[i][row].value == value:
			game_field[column][row] = null
			game_field[i][row].start_timer()
			this_number.move(grid_to_pixel(Vector2(i, row)))
			this_number.start_timer()
			var new_number = this_number.next_number.instance()
			add_child(new_number)
			print(new_number)
			game_field[i][row] = new_number
			new_number.position = grid_to_pixel(Vector2(i, row))
			emit_signal("score_changed", new_number.value)
			break


func move_up(mas):
	kody1 = 1
	while kody1 == 1:
		for y in range(1, game_field_size):
			for x in range(game_field_size):
				if mas[y][x] > 0:
					if mas[y-1][x] == 0:
						kody1 += 1
						mas[y-1][x] = mas[y][x]
						mas[y][x] = 0
					elif mas[y-1][x] == 1 and mas[y][x] == 1:
						kody1 += 1
						mas[y-1][x] = 2
						mas[y][x] = 0
					elif mas[y-1][x] < mas[y][x] and 2 * mas[y-1][x] >= mas[y][x]:
						kody1 += 1
						mas[y-1][x] = mas[y-1][x] + mas[y][x]
						mas[y][x] = 0
					elif mas[y-1][x] > mas[y][x] and 2 * mas[y][x] >= mas[y-1][x]:
						kody1 += 1
						mas[y-1][x] = mas[y-1][x] + mas[y][x]
						mas[y][x] = 0

		if kody1 > 1:
			kody1 = 1
		else:
			kody1 = 0
			fill_board()
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)



	# Store this number
	var this_number = game_field[column][row]
	# Store the value of this number:
	var value = game_field[column][row].value
	# Iterate through the columns looking for the end of the board, or a
	# non-empty space.
	for i in range(row + 1, game_field_size):
		# If it's the end of the board, and that spot is null:
		if i == game_field_size - 1 && game_field[column][i] == null:
			# Move the number there:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(column, game_field_size - 1)))
			game_field[column][game_field_size - 1] = this_number
			break
		# If this spot is full, then move to one before it:
		if game_field[column][i] != null && game_field[column][i].value != value:
			# Move to one before it:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(column, i - 1)))
			game_field[column][i - 1] = this_number
			break
		if game_field[column][i] != null && game_field[column][i].value == value:
			game_field[column][row] = null
			game_field[column][i].start_timer()
			this_number.move(grid_to_pixel(Vector2(column, i)))
			this_number.start_timer()
			var new_number = this_number.next_number.instance()
			add_child(new_number)
			print(new_number)
			game_field[column][i] = new_number
			new_number.position = grid_to_pixel(Vector2(column, i))
			emit_signal("score_changed", new_number.value)
			break


func move_down(mas):
		  
	kody2 = 1
	while kody2 == 1:
		for y in range(1, game_field_size):
			for x in range(game_field_size):
				if mas[game_field_size-y-1][x] > 0:
					if mas[game_field_size-y][x] == 0:
						kody2 += 1
						mas[game_field_size-y][x] = mas[game_field_size-y-1][x]
						mas[game_field_size-y-1][x] = 0
					elif mas[game_field_size-y][x] == 1 and mas[game_field_size-y-1][x] == 1:
						kody2 += 1
						mas[game_field_size-y][x] = 2
						mas[game_field_size-y-1][x] = 0
					elif mas[game_field_size-y][x] < mas[game_field_size-y-1][x] and 2 * mas[game_field_size-y][x] >= mas[game_field_size-y-1][x]:
						kody2 += 1
						mas[game_field_size-y][x] = mas[game_field_size-y][x] + mas[game_field_size-y-1][x]
						mas[game_field_size-y-1][x] = 0
					elif mas[game_field_size-y][x] > mas[game_field_size-y-1][x] and 2 * mas[game_field_size-y-1][x] >= mas[game_field_size-y][x]:
						kody2 += 1
						mas[game_field_size-y][x] = mas[game_field_size-y][x] + mas[game_field_size-y-1][x]
						mas[game_field_size-y-1][x] = 0
		if kody2 > 1:
			kody2 = 1
		else:
			kody2 = 0
			fill_board()
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)


	# Store this number
	var this_number = game_field[column][row]
	# Store the value of the next column Y 
	# Store the value of this number
	var value = game_field[column][row].value
	# Iterate through the columns looking for the end of the board, or a
	# non-empty space.
	for i in range(row - 1, -1, -1):
		# If it's the end of the board, and that spot is null:
		if i == 0 && game_field[column][i] == null:
			# Move the number there:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(column, 0)))
			game_field[column][0] = this_number
			break
		# If this spot is full, then move to one before it:
		if game_field[column][i] != null && game_field[column][i].value != value:
			# Move to one before it:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(column, i + 1)))
			game_field[column][i + 1] = this_number
			break
		if game_field[column][i] != null && game_field[column][i].value == value:
			game_field[column][row] = null
			game_field[column][i].start_timer()
			this_number.move(grid_to_pixel(Vector2(column, i)))
			this_number.start_timer()
			var new_number = this_number.next_number.instance()
			add_child(new_number)
			game_field[column][i] = new_number
			new_number.position = grid_to_pixel(Vector2(column, i))
			emit_signal("score_changed", new_number.value)
			break

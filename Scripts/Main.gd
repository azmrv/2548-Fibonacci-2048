extends Node2D


# Signals
signal score_changed

# Grid Variables
export (int) var x_start
export (int) var y_start
export (int) var offset
export (int) var num_starting_numbers
export (int) var width
export (int) var height

# Touch Variables
var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var last_direction = 0

var hard_level = 3
var iq_level = 0
var new_game_numbers = 3

# number Variables

#var possible_numbers = 
#[
#preload("res://scenes/2_number.tscn"),
#preload("res://scenes/4_number.tscn")
#]

var game_window_width = 500
var game_window_heigth = 700
var game_window_margin = 3

var game_field_size = 6 
var game_field_width = 100
var game_field_heigth = 100
var game_field_margin = 3

#global summ
var summ = 0
var eend = 3

var game_field = [[], []]
var randgen = RandomNumberGenerator.new()


func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array


func _ready():
	randomize()
	game_field = make_2d_array()
	setup()


func new_game():
	# числа на поле, 3 числа в начале
	for	x in new_game_numbers:
		if possible_match_on_board() == true:
			game_field = possible_numbers(game_field)


func setup():
	new_game()	
	
#	while current_numbers < starting_numbers:
#		var current_x = round(randgen.randi_range(0, 6))
#		var current_y = round(randgen.randi_range(0, 6))
#		if(game_field[current_x][current_y] == null):
			#var number_to_make = round(randgen.randi_range(0, 3))
			# генерация допустимых чисел Фиб
			# число выставляем как объект
#			var number = possible_numbers(current_numbers).instance()
#			current_numbers += 1
#			numbers_to_field()
			# добавялем в дерево ноду числа
			# add_child(number)
			# расставялем по координатам на поле
#			number.position = grid_to_pixel(Vector2(current_x, current_y))			
#			game_field[current_x][current_y] = possible_numbers()


func numbers_to_field():
	
	pass			


func possible_numbers(array):
	print("Get Fib Numbers from Space - possible_numbers()")	
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


func grid_to_pixel(grid_position):
	var new_x = grid_position.x * offset + x_start
	var new_y = grid_position.y * -offset + y_start
	return (Vector2(new_x, new_y))


func pixel_to_grid(pixel_position):
	var new_x = round((pixel_position.x - x_start) / offset)
	var new_y = round((pixel_position.y - y_start) / -offset)
	return (Vector2(new_x, new_y))


func _process(_delta):
	# проверка ввода в цикле игры	
	touch_input()
	randomize()


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
	last_direction = 0
	var difference = final_touch - first_touch
	if abs(difference.x) > abs(difference.y):
		if difference.x >= 25:
			for i in range(3, -1, -1):
				for j in height: 
					if game_field[i][j] != null:
						move_right(i,j)
						last_direction = 1
		elif difference.x <= -25:
			for i in range(1, 4, 1):
				for j in height:
					if game_field[i][j] != null:
						move_left(i,j)
						last_direction = 2
	elif abs(difference.x) <= abs(difference.y):
		if difference.y <= -25:
			for i in width:
				for j in range(3, -1, -1):
					if game_field[i][j] != null:
						move_up(i,j)
						last_direction = 3
		elif difference.y >= 25:
			for i in width:
				for j in range(1, 4, 1):
					if game_field[i][j] != null:
						move_down(i,j)
						last_direction = 4
	if abs(difference.x) >= 25 || abs(difference.y) >= 25:
		fill_board()


func move_right(column, row):
	# Store this number
	var this_number = game_field[column][row]
	# Store the value of the next column
	var next_x = column + 1
	# Store the value of this number:
	var value = game_field[column][row].value
	# Iterate through the columns looking for the end of the board, or a
	# non-empty space.
	for i in range(next_x, width):
		# If it's the end of the board, and that spot is null:
		if i == width - 1 && game_field[i][row] == null:
			# Move the number there:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(width - 1, row)))
			game_field[width - 1][row] = this_number
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


func move_left(column, row):
	# Store this number
	var this_number = game_field[column][row]
	# Store the value of the next column
	var next_x = column - 1
	# Store the value of this number:
	var value = game_field[column][row].value
	# Iterate through the columns looking for the end of the board, or a
	# non-empty space.
	for i in range(next_x, -1, -1):
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


func move_up(column, row):
		# Store this number
	var this_number = game_field[column][row]
	# Store the value of the next column
	var next_y = row + 1
	# Store the value of this number:
	var value = game_field[column][row].value
	# Iterate through the columns looking for the end of the board, or a
	# non-empty space.
	for i in range(next_y, width):
		# If it's the end of the board, and that spot is null:
		if i == width - 1 && game_field[column][i] == null:
			# Move the number there:
			game_field[column][row] = null
			this_number.move(grid_to_pixel(Vector2(column, width - 1)))
			game_field[column][width - 1] = this_number
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
	pass


func move_down(column, row):
	# Store this number
	var this_number = game_field[column][row]
	# Store the value of the next column
	var next_y = row - 1
	# Store the value of this number:
	var value = game_field[column][row].value
	# Iterate through the columns looking for the end of the board, or a
	# non-empty space.
	for i in range(next_y, -1, -1):
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


func fill_board():
	# заполняем игровое поле
	if blank_space_on_board():
		generate_new_number()
	else:
		if is_possible_match():
			return
		else:
			print("Game Over")


func generate_new_number():
	# разместить новое число на игровом поле
	if(last_direction == 1):
		var number_made = false
		while !number_made:
			var row = round(rand_range(-.5, 3.4))
			if(game_field[0][row] == null):
				#var number = possible_numbers[0].instance()
				var number = possible_numbers(number_made).instance()
				add_child(number)
				number.position = grid_to_pixel(Vector2(0, row))
				number_made = true
				game_field[0][row] = number
	elif(last_direction == 2):
		var number_made = false
		while !number_made:
			var row = round(rand_range(-.5, 3.4))
			if game_field[3][row] == null:
				#var number = possible_numbers[0].instance()
				var number = possible_numbers(number_made).instance()
				add_child(number)
				number.position = grid_to_pixel(Vector2(3, row))
				number_made = true
				game_field[3][row] = number
	elif(last_direction == 3):
		var number_made = false
		while !number_made:
			var column = round(rand_range(-.5, 3.4))
			if game_field[column][0] == null:
				#var number = possible_numbers[0].instance()
				var number = possible_numbers(number_made).instance()
				add_child(number)
				number.position = grid_to_pixel(Vector2(column, 0))
				number_made = true
				game_field[column][0] = number
	elif(last_direction == 4):
		var number_made = false
		while !number_made:
			var column = round(rand_range(-.5, 3.4))
			if game_field[column][3] == null:
				#var number = possible_numbers[0].instance()
				var number = possible_numbers(number_made).instance()
				add_child(number)
				number.position = grid_to_pixel(Vector2(column, 3))
				number_made = true
				game_field[column][3] = number


func is_possible_match():
	# Проверка в четерех направлениях совпадения чисел
	for i in width:
		for j in height:
			if game_field[i][j] != null:
				var value = game_field[i][j].value
				if j > 0:
					if game_field[i][j - 1].value == value:
						return true
				if j < width - 1:
					if game_field[i][j + 1].value == value:
						return true
				if i > 0:
					if game_field[i -1][j].value == value:
						return true
				if i < width - 1:
					if game_field[i + 1][j].value == value:
						return true
	return false


func blank_space_on_board():
	for i in width:
		for j in height:
			if game_field[i][j] == null:
				return true
	return false


func possible_match_on_board():
	# Есть ли на игровом поле пустое место
	if blank_space_on_board():
		return true
	# Иначе проверить все поле в четырех направлениях на совпадения
	if is_possible_match():
		return true
	return false


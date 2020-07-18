extends Node2D


var screenSize = Vector2(0,0)
var game_window_width_x = 500
var game_window_heigth_y = 800
var game_window_margin = 0

var game_field_width_x = 500
var game_field_margin = 0


var game_field_size = 5


var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var swipe_start = null
var minimum_drag = 100
var swipe = null

onready var admob = $AdMob
#onready var debug_out = null #$CanvasLayer/DebugOut

func _ready() -> void:
	setup()
	Main.new_game()
	admob.load_banner()
	admob.load_interstitial()
	admob.load_rewarded_video()
# warning-ignore:return_value_discarded
	get_tree().connect("screen_resized", self, "_on_resize")


func setup():
	print("MainWindow setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
#	$MainWindow.rect_min_size = screenSize
	game_field_size = Main.game_field_size
	game_window_width_x = screenSize.x
	game_window_heigth_y = screenSize.y
	game_field_width_x = game_window_width_x
	print("set screen size = %s" %  screenSize)



func move_down(mas):
#	print("func move_down(mas)")
	Main.randgen.randomize()
	Main.undo_game_field = mas
	var kodx1 = 1
	while kodx1 == 1:
		var sempty = 0
		for colx in range(game_field_size):
			
			for rowy in range(game_field_size-1):
				
				if mas[rowy][colx] != null:
					if mas[rowy+1][colx] == null:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy+1][colx] == 1:
						if mas[rowy][colx] == 1 or mas[rowy][colx] == 2:
							kodx1 += 1
							mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
							mas[rowy][colx] = null
					elif mas[rowy+1][colx] > mas[rowy][colx] and mas[rowy+1][colx] <= 2 * mas[rowy][colx]:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy+1][colx] < mas[rowy][colx] and mas[rowy][colx] <= 2 * mas[rowy+1][colx]:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
						mas[rowy][colx] = null
				else:
					sempty += 1					
		if kodx1 > 1:
			kodx1 = 1
		else:
			kodx1 = 0
			if sempty == 0:
				# после окончания игры прододжает выполнять fill_field_with_numbers()
				Main.update_score()
				Main.game_over()
				return
			elif sempty <= 4:
				Main.koldop = 1
			else:
				Main.koldop = 2
			Main.fill_field_with_numbers()
	if Main.gui_node != null && Main.new_game != 0:
		Main.reasign_numbers_on_gamefield()
	Main.update_score()

func move_up(mas):
#	print("func move_up(mas)")
	Main.randgen.randomize()
	Main.undo_game_field = mas
	var kodx2 = 1
	while kodx2 == 1:
		var sempty = 0
		for colx in range(Main.game_field_size):
			
			for rowy in range(1, Main.game_field_size):
				
				if mas[game_field_size-rowy][colx] != null:
					if  mas[game_field_size-rowy-1][colx] == null:
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] == 1:
						if  mas[game_field_size-rowy][colx] == 1 or  mas[game_field_size-rowy][colx] == 2:
							kodx2+=1
							mas[game_field_size-rowy-1][colx] = mas[game_field_size-rowy-1][colx]+ mas[game_field_size-rowy][colx]
							mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] > mas[game_field_size-rowy][colx]  and  mas[game_field_size-rowy-1][colx] <= 2 * mas[game_field_size-rowy][colx] :
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy-1][colx]+ mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] <  mas[game_field_size-rowy][colx] and  mas[game_field_size-rowy][colx] <= 2 *  mas[game_field_size-rowy-1][colx]:
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy-1][colx] +  mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
				else:
					sempty += 1

		if kodx2 > 1:
			kodx2 = 1
		else:
			kodx2 = 0
			if sempty == 0:
				Main.update_score()
				Main.game_over()
				return
			elif sempty <= 4:
				Main.koldop = 1
			else:
				Main.koldop = 2
			Main.fill_field_with_numbers()
	if Main.gui_node != null && Main.new_game != 0:
		Main.reasign_numbers_on_gamefield()
	Main.update_score()
	
func move_right(mas):
#	print("func move_right(mas)")
	Main.randgen.randomize()
	Main.undo_game_field = mas
	var kody1 = 1
	while kody1 == 1:
		var sempty = 0
		for rowy in range(game_field_size):
			
			for colx in range(game_field_size-1):
				
				if mas[rowy][colx] != null:
					if mas[rowy][colx+1] == null:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy][colx+1] == 1:
						if mas[rowy][colx] == 1 or mas[rowy][colx] == 2:
							kody1+=1
							mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
							mas[rowy][colx] = null
					elif mas[rowy][colx+1] > mas[rowy][colx] and mas[rowy][colx+1] <= 2 * mas[rowy][colx]:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy][colx+1] < mas[rowy][colx] and mas[rowy][colx] <= 2 * mas[rowy][colx+1]:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
						mas[rowy][colx] = null	
				else:
					sempty += 1					
		if kody1 > 1:
			kody1 = 1
		else:
			kody1 = 0
			if sempty == 0:
				Main.update_score()
				Main.game_over()
				return
			elif sempty <= 4:
				Main.koldop = 1
			else:
				Main.koldop = 2
			Main.fill_field_with_numbers()
	if Main.gui_node != null && Main.new_game != 0:
		Main.reasign_numbers_on_gamefield()
	Main.update_score()

func move_left(mas):
#	print("func move_left(mas)")
	Main.randgen.randomize()
	Main.undo_game_field = mas
	var kody2 = 1
	while kody2 == 1:
		var sempty = 0
		for rowy in range(game_field_size):
			
			for colx in range(1, game_field_size):
				
				if mas[rowy][game_field_size-colx] != null:
					if mas[rowy][game_field_size-colx-1]== null:
						kody2+=1
						mas[rowy][game_field_size-colx-1] =  mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] = null
					elif mas[rowy][game_field_size-colx-1]  == 1:
						if  mas[rowy][game_field_size-colx] == 1 or  mas[rowy][game_field_size-colx] == 2:
							kody2+=1
							mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
							mas[rowy][game_field_size-colx] = null
					elif  mas[rowy][game_field_size-colx-1] >  mas[rowy][game_field_size-colx] and  mas[rowy][game_field_size-colx-1] <= 2 * mas[rowy][game_field_size-colx]  :
						kody2+=1
						mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] =  null
						
					elif  mas[rowy][game_field_size-colx-1] < mas[rowy][game_field_size-colx] and  mas[rowy][game_field_size-colx] <= 2 * mas[rowy][game_field_size-colx-1] :
						kody2+=1
						mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] =  null
				else:
					sempty += 1
											
		if kody2 > 1:
			kody2 = 1
		else:
			kody2 = 0
			if sempty == 0:
				Main.update_score()
				Main.game_over()
				return
			elif sempty <= 4:
				Main.koldop = 1
			else:
				Main.koldop = 2
			Main.fill_field_with_numbers()
	if Main.gui_node != null && Main.new_game != 0:
		Main.reasign_numbers_on_gamefield()
	Main.update_score()

func _input(event):
	if (Main.new_game != 0) && (Main.clickInput == true):
		#print("_input(event)", event)
		if(Input.is_action_just_pressed("ui_touch")):
			print("_input(event) - (Input.is_action_just_PREssed(ui_touch))")
			first_touch = (get_global_mouse_position())
		if(Input.is_action_just_released("ui_touch")):
			print("_input(event) - (Input.is_action_just_REleased(ui_touch))")
			final_touch = (get_global_mouse_position())
			calculate_direction()
	elif (Main.new_game != 0) && (Main.clickInput == false):
		if event is InputEventScreenTouch:
			if event.pressed:
			  swipe_start = event.get_position()
			else:
			  _calculate_swipe(event.get_position())

#func _unhandled_input(event):
#	if (Main.new_game != 0) && (Main.clickInput == false):
#		if event is InputEventScreenTouch:
#			if event.pressed:
#			  swipe_start = event.get_position()
#			else:
#			  _calculate_swipe(event.get_position())

func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			move_right(Main.game_field)
		if swipe.x < 0:
			move_left(Main.game_field)
	if abs(swipe.y) > minimum_drag:
		if swipe.y > 0:
			move_down(Main.game_field)
		if swipe.y < 0:
			move_up(Main.game_field)

func calculate_direction():
	var k_scr = (game_window_heigth_y - game_window_width_x)/2
#	print("calculate_direction()")
#	print("y =", final_touch.y, " x =", final_touch.x)	
	if final_touch.x > final_touch.y-k_scr:		
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			move_up(Main.game_field)
		else:
			move_right(Main.game_field)
	else:
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			move_left(Main.game_field)
		else:
			move_down(Main.game_field) 




#ADMOB


# buttons callbacks
func banner_toggled(button_pressed):
	print("MainWindow banner_toggled(button_pressed)")
#	if button_pressed: admob.show_banner()
#	else: admob.hide_banner()

func interstitial_show():
	print("MainWindow interstitial_show()")
	print("Interstitial loaded before shown = " + str(admob.is_interstitial_loaded()) +"\n")
#	debug_out.text = debug_out.text + "Interstitial loaded before shown = " + str(admob.is_interstitial_loaded()) +"\n"
	admob.show_interstitial()
	print("Interstitial loaded after shown = " + str(admob.is_interstitial_loaded()) +"\n")
#	debug_out.text = debug_out.text + "Interstitial loaded after shown = " + str(admob.is_interstitial_loaded()) +"\n"


func rewardedvideo_show():
	print("MainWindow rewardedvideo_show()")
#	debug_out.text = debug_out.text + "Rewarded loaded before shown = " + str(admob.is_rewarded_video_loaded()) +"\n"
	admob.show_rewarded_video()
#	debug_out.text = debug_out.text + "Rewarded loaded after shown = " + str(admob.is_rewarded_video_loaded()) +"\n"


# AdMob callbacks
func _on_resize():
	print("MainWindow _on_resize()")
#	debug_out.text = debug_out.text + "Banner resized\n"
	admob.banner_resize()

func _on_AdMob_banner_failed_to_load(error_code):
	print("MainWindow _on_AdMob_banner_failed_to_load(error_code) %s" % str(error_code))
#	debug_out.text = debug_out.text + "Banner failed to load: Error code " + str(error_code) + "\n"
	Main.new_game()
	
func _on_AdMob_banner_loaded():
	print("MainWindow _on_AdMob_banner_loaded()")
#	$"BtnBanner".disabled = false
#	debug_out.text = debug_out.text + "Banner loaded\n"
#	debug_out.text = debug_out.text + "Banner size = " + str(admob.get_banner_dimension()) +  "\n"


func _on_AdMob_interstitial_loaded():
	print("MainWindow _on_AdMob_interstitial_loaded()")
#	$"BtnInterstitial".disabled = false
#	debug_out.text = debug_out.text + "Interstitial loaded\n"


func _on_AdMob_interstitial_closed():
	print("MainWindow _on_AdMob_interstitial_closed()")
#	debug_out.text = debug_out.text + "Interstitial closed\n"
#	$"BtnInterstitial".disabled = true
	Main.new_game()

func _on_AdMob_interstitial_failed_to_load(error_code):
	print("MainWindow _on_AdMob_interstitial_failed_to_load(error_code) %s" % str(error_code))
#	debug_out.text = debug_out.text + "Interstitial failed to load: Error code " + str(error_code) + "\n"
	interstitial_show()
	Main.new_game()
	
func _on_AdMob_network_error():
	print("MainWindow _on_AdMob_network_error()")
#	debug_out.text = debug_out.text + "Network error\n"
	interstitial_show()
	Main.new_game()
	
func _on_AdMob_rewarded(currency, amount):
	print("MainWindow _on_AdMob_rewarded()")
#	debug_out.text = debug_out.text + "Rewarded watched, currency: " + str(currency) + " amount:"+ str(amount)+ "\n"


func _on_AdMob_rewarded_video_closed():
	print("MainWindow _on_AdMob_rewarded_video_closed()")
#	debug_out.text = debug_out.text + "Rewarded video closed\n"
#	$"BtnRewardedVideo".disabled = true
	admob.load_rewarded_video()
	Main.new_game()

func _on_AdMob_rewarded_video_failed_to_load(error_code):
	print("MainWindow _on_AdMob_rewarded_video_failed_to_load()")
#	debug_out.text = debug_out.text + "Rewarded video failed to load: Error code " + str(error_code) + "\n"

	
func _on_AdMob_rewarded_video_left_application():
	print("MainWindow _on_AdMob_rewarded_video_left_application()")
#	debug_out.text = debug_out.text + "Rewarded video left application\n"


func _on_AdMob_rewarded_video_loaded():
	print("MainWindow _on_AdMob_rewarded_video_loaded()")
#	$"BtnRewardedVideo".disabled = false
#	debug_out.text = debug_out.text + "Rewarded video loaded\n"


func _on_AdMob_rewarded_video_opened():
	print("MainWindow _on_AdMob_rewarded_video_opened()")
#	debug_out.text = debug_out.text + "Rewarded video opened\n"

	
func _on_AdMob_rewarded_video_started():
	print("MainWindow _on_AdMob_rewarded_video_started()")
#	debug_out.text = debug_out.text + "Rewarded video started\n"
	

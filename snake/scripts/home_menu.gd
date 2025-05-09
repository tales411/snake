extends CanvasLayer

var option: int = 1

func _ready() -> void:
	$player.position.x = 485
	$player.position.y = 470

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		if option > 1:
			option -= 1
		
	elif Input.is_action_just_pressed("ui_down"):
		if option < 4:
			option += 1
	
	if option == 1:
		$player.position.y = 470
	elif option == 2:
		$player.position.y = 515
	elif  option == 3:
		$player.position.y = 560
	elif  option == 4:
		$player.position.y = 605
	
	if Input.is_action_just_pressed("ui_accept"):
		if option == 1:
			_on_play_pressed()
		elif option == 2:
			_on_game_mode_button_pressed()
		elif option == 3:
			_on_settings_pressed()
		elif option == 4:
			_on_quit_game_pressed()



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_game_mode_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_mode.tscn")

extends Node2D


var option: int = 1


func _ready() -> void:
	option = 1
	$player.position.x = 485
	$player.position.y = 360


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		if option > 1:
			option -= 1
		
	elif Input.is_action_just_pressed("ui_down"):
		if option < 2:
			option += 1
	
	if option == 1:
		$player.position.y = 360
	elif option == 2:
		$player.position.y = 410
	elif  option == 3:
		$player.position.y = 460
	
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_pressed()
	
	if Input.is_action_just_pressed("ui_accept"):
		if option == 1:
			_on_reset_pressed()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")


func _on_reset_pressed() -> void:
	print("record resetado")
	var path = "user://save.cfg"
	var config = ConfigFile.new()
	Global.record = 0
	config.set_value("scores", "high_scores", Global.record)
	config.save(path)
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
	
	
	
	

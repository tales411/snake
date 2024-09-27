extends  Node2D


var fruit_scene = preload("res://scenes/fruit.tscn")
var wall_scene = preload("res://scenes/wall.tscn")
var points = 0

var high_score = 0
var config = ConfigFile.new()

func _ready():
	points = 0 # zera a pontuação no começo
	Global.grid_size = 32 # Tamanho do grid 
	Global.direction = Vector2.RIGHT # direção inicial (começa indo para a direita)
	Global.snake_body = [] # lista do corpo da cobra
	Global.initial_length = 5 # tamanho inicial da cobra
	_load_record()
	_position_fruits()
	
	# cria o corpo inicial da cobra
	for i in range(Global.initial_length):
		var segment = Sprite2D.new()
		segment.texture = preload("res://tiles/barGreen_horizontalMid.png")
		segment.scale.x = 1.6
		segment.scale.y = 1.6
		segment.position = $player.position - Global.direction * Global.grid_size * (i + 1)
		add_child(segment)
		Global.snake_body.append(segment)
		
func  _process(delta):
	# colisao com os segmentos
	for i in range(Global.snake_body.size() - 1, 0, -1):
		if Global.snake_body[i].position == $player.position:
			get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
	
	if Global.fruit_entered == true:
		_grow()
		_spawn_fruit()
		_score()
		if Global.game_mode == 2:
			_wall_mode()
		Global.fruit_entered = false


func _position_fruits():
	$fruits/fruit1.position.x = 464
	$fruits/fruit1.position.y = 337
	$fruits/fruit2.position.x = 529
	$fruits/fruit2.position.y = 400
	$fruits/fruit3.position.x = 464
	$fruits/fruit3.position.y = 465
	$fruits/fruit4.position.x = 592
	$fruits/fruit4.position.y = 337
	$fruits/fruit5.position.x = 592
	$fruits/fruit5.position.y = 465
	$fruits/fruit6.position.x = 496
	$fruits/fruit6.position.y = 369
	$fruits/fruit7.position.x = 560
	$fruits/fruit7.position.y = 369
	$fruits/fruit8.position.x = 496
	$fruits/fruit8.position.y = 434
	$fruits/fruit9.position.x = 560
	$fruits/fruit9.position.y = 434
	if Global.fruit_number == 3:
		$fruits/fruit4.queue_free()
		$fruits/fruit5.queue_free()
		$fruits/fruit6.queue_free()
		$fruits/fruit7.queue_free()
		$fruits/fruit8.queue_free()
		$fruits/fruit9.queue_free()
	elif  Global.fruit_number == 5:
		$fruits/fruit6.queue_free()
		$fruits/fruit7.queue_free()
		$fruits/fruit8.queue_free()
		$fruits/fruit9.queue_free()


func _on_timer_timeout() -> void:
	for i in range(Global.snake_body.size() - 1, 0, -1): # nao entendi o pq do - 1, 0, -1
		Global.snake_body[i].position = Global.snake_body[i - 1].position
	Global.snake_body[0].position = $player.position
	
func _grow():
	var new_segment = Sprite2D.new()
	new_segment.texture = preload("res://tiles/barGreen_horizontalMid.png")
	new_segment.scale.x = 1.6
	new_segment.scale.y = 1.6
	new_segment.position = Global.snake_body[Global.snake_body.size() - 1].position
	add_child(new_segment)
	Global.snake_body.append(new_segment)
	
				
				
func _check_position(new_position):
	for i in range(Global.snake_body.size() - 1, -1, -1):
		# Verifica se a nova posição coincide com a posição do corpo da cobra
		if Global.snake_body[i].position == new_position:
			print("Posição inválida. A posição está colidindo com o corpo da cobra.")
			return false  # Retorna false se a posição colidir
	for existing_fruit in $fruits.get_children():
		if existing_fruit.position == new_position:
			print("Posição inválida: em cima de outra fruta")
			return false
	for existing_wall in $wall.get_children():
		if existing_wall.position == new_position:
			print("Posição invalida. fruta colidindo com wall")
			return false
	return true  # Retorna true se não houver colisão
				
				
func _spawn_fruit():
	var valid_position = false
	var fruit = fruit_scene.instantiate()
	var new_position
	
	while valid_position == false:
		# Gera uma nova posição aleatória na linha fixa
		var random_x = (randi() % int(22) * 32) - 16 + (32 * 2)# -16 para alinhar no centro
		var random_y = (randi() % int(19) * 32) - 16 + (32 * 5)
		new_position = Vector2(random_x, random_y)
		
		# Verifica se a posição gerada é válida
		valid_position = _check_position(new_position)
				
	# Quando uma posição válida for encontrada, posiciona a fruta
	fruit.position = new_position
	$fruits.add_child(fruit)



func _score():
	points += 1
	$score/points.text = str(points)
	if points > Global.record:
		Global.record = points
		
		_save_record()
		


func _save_record():
	$score/record.text = str(Global.record)
	
	config.set_value("scores", "high_scores", Global.record)
	var path = "user://save.cfg"
	config.save(path)
	print("novo recorde:", Global.record)
	
func _load_record():
	var path = "user://save.cfg"
	config.load(path)
	Global.record = config.get_value("scores", "high_scores", Global.record)
	$score/record.text = str(Global.record)


func _wall_mode():
	var valid_position = false
	var wall = wall_scene.instantiate()
	var new_position
	while valid_position == false:
		var random_x = (randi() % int(22) * 32) - 16 + (32 * 2)
		var random_y = (randi() % int(19) * 32) - 16 + (32 * 5)
		new_position = Vector2(random_x, random_y)
		valid_position = _check_wall_position(new_position)
		
	wall.position = new_position
	$wall.add_child(wall)
	
func _check_wall_position(new_position):
	for i in range(Global.snake_body.size() - 1, -1, -1):
		# Verifica se a nova posição coincide com a posição do corpo da cobra
		if Global.snake_body[i].position == new_position:
			print("Posição inválida. Wall colidindo com o corpo da cobra.")
			return false  # Retorna false se a posição colidir
	for existing_wall in $wall.get_children():
		if existing_wall.position == new_position:
			print("Posição invalida. wall colidindo com outra wall")
			return false
	for existing_fruit in $fruits.get_children():
		if existing_fruit.position == new_position:
			print("posição invalida. wall colidindo com fruta")
			return false
	if $player.position.distance_to(new_position) < 100:
		print("posição invalida. proximo demais ao player")
		return false
		
	return true
	

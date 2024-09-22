extends  Node2D


var fruit_scene = preload("res://scenes/fruit.tscn")


func _ready():
	Global.grid_size = 32 # Tamanho do grid 
	Global.direction = Vector2.RIGHT # direção inicial (começa indo para a direita)
	Global.snake_body = [] # lista do corpo da cobra
	Global.initial_length = 5 # tamanho inicial da cobra
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
		Global.fruit_entered = false

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
	# Verificar o tamanho do corpo da cobra
	print("Tamanho do corpo da cobra: ", Global.snake_body.size())
	
	# Itera sobre o corpo da cobra de trás para frente
	for i in range(Global.snake_body.size() - 1, -1, -1):
		# Imprime as posições da cobra e a nova posição
		print("Comparando posição da cobra: ", Global.snake_body[i].position, " com nova posição: ", new_position)
		
		# Verifica se a nova posição coincide com a posição do corpo da cobra
		if Global.snake_body[i].position == new_position:
			print("Posição inválida. A posição está colidindo com o corpo da cobra.")
			return false  # Retorna false se a posição colidir
	
	# Se não houver colisão, retorna true
	return true  # Retorna true se não houver colisão
				
				
func _spawn_fruit():
	var valid_position = false
	var fruit = fruit_scene.instantiate()
	var new_position
	
	while valid_position == false:
		# Gera uma nova posição aleatória na linha fixa
		var random_x = randi() % int(22) * 32
		var fixed_y = 6 * 32  # Define a linha fixa no eixo Y
		
		new_position = Vector2(random_x, fixed_y)
		
		# Verifica se a posição gerada é válida
		valid_position = _check_position(new_position)
				
	# Quando uma posição válida for encontrada, posiciona a fruta
	fruit.position = new_position
	$fruits.add_child(fruit)





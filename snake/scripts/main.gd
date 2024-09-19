extends  Node2D


func _ready():
	Global.grid_size = 32 # Tamanho do grid 
	Global.direction = Vector2.RIGHT # direção inicial (começa indo para a direita)
	Global.snake_body = [] # lista do corpo da cobra
	Global.initial_length = 2 # tamanho inicial da cobra
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
			get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_timer_timeout() -> void:
	for i in range(Global.snake_body.size() - 1, 0, -1): # nao entendi o pq do - 1, 0, -1
		Global.snake_body[i].position = Global.snake_body[i - 1].position
	Global.snake_body[0].position = $player.position
	
func _grow():
	print("aaa")
	var new_segment = Sprite2D.new()
	new_segment.texture = preload("res://tiles/barGreen_horizontalMid.png")
	new_segment.scale.x = 1.6
	new_segment.scale.y = 1.6
	new_segment.position = Global.snake_body[Global.snake_body.size() - 1].position
	add_child(new_segment)
	Global.snake_body.append(new_segment)
	
	

func _on_fruit_body_entered(body: Node2D) -> void:
	if body.name == "player":
		_grow()
		

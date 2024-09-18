extends  Node2D


func _ready():
	# cria o corpo inicial da cobra
	for i in range(Global.initial_length):
		var segment = Sprite2D.new()
		segment.texture = preload("res://tiles/barGreen_horizontalMid.png")
		segment.scale.x = 1.6
		segment.scale.y = 1.6
		segment.position = $player.position - Global.direction * Global.grid_size * (i + 1)
		add_child(segment)
		Global.snake_body.append(segment)
		


func _on_timer_timeout() -> void:
	for i in range(Global.snake_body.size() - 1, 0, -1): # nao entendi o pq do - 1, 0, -1
		Global.snake_body[i].position = Global.snake_body[i - 1].position
	Global.snake_body[0].position = $player.position
	

extends Area2D


@onready var sprite := $Sprite2D
var isInsideEnemy = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack") and !sprite.visible:
		sprite.visible = true
		if(isInsideEnemy != null):
			_on_body_entered(isInsideEnemy)
		for i in 20:
			if sprite.visible:
				position.y += -11
				position.x += -17
				
				await get_tree().create_timer(0.01).timeout
		for i in 20:
			if sprite.visible:
				position.y -= -8.5
				position.x -= -22
				await get_tree().create_timer(0.01).timeout
		if sprite.visible:
			position.x = 100
			position.y = -300 
		for i in 20:
			if sprite.visible:
				position.y += 11
				position.x += 8.5
				await get_tree().create_timer(0.007).timeout
		if sprite.visible:
			position.y = 50
			position.x = -300
		for i in 20:
			if sprite.visible:
				position.y -= -8.5
				position.x -= 11
				await get_tree().create_timer(0.007).timeout
		position.x = 20
		position.y = 7
		sprite.visible = false


func _on_body_entered(body):
	if(!sprite.visible):
		isInsideEnemy = body
		return
	body.loseHealth()
	position.x = 20
	position.y = 7
	sprite.visible = false


func _on_body_exited(body):
	isInsideEnemy = null

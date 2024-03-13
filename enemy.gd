extends CharacterBody2D


@export var health : int
@export var boss : AnimationPlayer
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rndX = rng.randi_range(0, 1200)
	var rndY = rng.randi_range(0, 675)
	position.x = rndX
	position.y = rndY
func loseHealth():
	if boss.current_animation == "between attacks":
		return
	health -= 1
	if health <= 0:
		boss.end_attack()
		health = 5
		_ready()

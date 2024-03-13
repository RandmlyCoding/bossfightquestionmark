extends AnimationPlayer
@export var bossbar : Sprite2D
var attacks = ["laser", "bounce", "beams of doom", "size enlarging"]
var current_attack = 0
var scene = preload("res://end_screen.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	randomize()
	attacks.shuffle()
	current_animation = "between attacks"
	print(current_animation)
	bossbar.texture.gradient.offsets[0] = 1
	if current_animation == "between attacks":
		print("hit")

func attack_start():
	current_animation = attacks[current_attack%4]
	current_attack+=1

func end_attack():
	current_animation = "between attacks"

func _on_boss_lose_health():
	if not current_animation == "between attacks":
		print(current_animation)
		return
	if(bossbar.texture.gradient.offsets[0] > 0):
		bossbar.texture.gradient.offsets[0] -= 0.1
	elif(bossbar.texture.gradient.offsets[1] > 0):
		bossbar.texture.gradient.offsets[1] -= 0.1
	if(bossbar.texture.gradient.offsets[1] <= 0 && bossbar.texture.gradient.offsets[0] <= 0):
		var instance = scene.instantiate()
		get_parent().add_child(instance)
		queue_free()

func boss_gain_health():
	if(bossbar.texture.gradient.offsets[1] == 1 and bossbar.texture.gradient.offsets[0] < 1):
		bossbar.texture.gradient.offsets[0] += 0.1
	elif(bossbar.texture.gradient.offsets[0] <= 0):
		bossbar.texture.gradient.offsets[1] += 0.1

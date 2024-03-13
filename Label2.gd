extends Label

@onready var player = get_parent().get_parent().get_node("player")
# Called when the node enters the scene tree for the first time.
func _ready():
	print(player.hits)
	text = "Your deaths are: " + str(player.hits) + "                        "

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

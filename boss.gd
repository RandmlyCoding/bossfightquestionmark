extends StaticBody2D
signal lose_health
var hitCount = 0
func loseHealth():
	lose_health.emit()
	hitCount += 1
	if hitCount == 5:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var rndX = rng.randi_range(-500, 500)
		var rndY = rng.randi_range(-300, 300)
		position.x = rndX
		position.y = rndY
		hitCount = 0

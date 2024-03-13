extends CharacterBody2D

const GRAVITY = 2000
const SPEED = 400.0
const JUMP_VELOCITY = -650.0
const DOUBLE_JUMP_VELOCITY = -600.0

var hasJumped
var jumpTimeout = 0.1
var jumpTimer = 0
var groundedTimeout = 0.1
var groundedTimer = 0
var isGrounded = false
var hasDoubleJump = false
var immunityFrames = true
var hits = 0

@export var boss : AnimationPlayer

func _ready():
	await get_tree().create_timer(2).timeout
	immunityFrames = false
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	# Handle jump.
	if is_on_floor():
		isGrounded = true
		hasDoubleJump = true
		groundedTimer = groundedTimeout
	if Input.is_action_just_pressed("jump"):
		hasJumped = true
		jumpTimer = jumpTimeout
	if hasJumped and isGrounded:
		velocity.y = JUMP_VELOCITY
		hasJumped = false
	if hasJumped and !isGrounded and hasDoubleJump:
		velocity.y = DOUBLE_JUMP_VELOCITY
		hasJumped = false
		hasDoubleJump = false
	if hasJumped:
		jumpTimer -= delta
	if jumpTimer <= 0:
		hasJumped = false
	if isGrounded and not is_on_floor():
		groundedTimer -= delta
	if groundedTimer <= 0:
		isGrounded = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		scale.y = direction
		rotation = 0.5*PI*(direction-1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func on_player_entered(body):
	if immunityFrames:
		return
	immunityFrames = true
	print(modulate)
	modulate = Color(255, 255, 255, 69)
	print("got hit")
	hits+= 1 
	boss.boss_gain_health()
	await get_tree().create_timer(1).timeout
	immunityFrames = false
	modulate = Color(1, 1, 1, 1)

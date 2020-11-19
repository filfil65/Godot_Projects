extends Area2D

signal hit

# Using export allows us to set it int he Inspector
export var speed: float = 400  # How fast the player will move (pixels/sec).
var screen_size: Vector2  # Size of the game window.
var player_size_scaled: Vector2



func _ready():
	hide()
	screen_size = get_viewport_rect().size
	# Get player size
	var user_frame = $AnimatedSprite.frames.get_frame("walk", 0)
	player_size_scaled = user_frame.get_size() * $AnimatedSprite.scale


func _process(delta: float):
	var velocity = _check_for_input()
	_move(velocity, delta)
	_play_animation(velocity)


func _check_for_input() -> Vector2:
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	return velocity


func _move(velocity: Vector2, delta: float):
	position += velocity * delta
	position.x = clamp(position.x, 0 + player_size_scaled.x / 2, screen_size.x - player_size_scaled.x / 2)
	position.y = clamp(position.y, 0 + player_size_scaled.y / 2, screen_size.y - player_size_scaled.y / 2)
	
	
func _play_animation(velocity: Vector2):
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = velocity.y > 0  # flip when walking diagonally
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func start(pos: Vector2):
	""" Reset the player player when starting a new game """
	position = pos
	show()
	$CollisionShape2D.disabled = false

## Signals ##
func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	# Disable collisions to prevent 'hit' signal from being re-emmited
	$CollisionShape2D.set_deferred("disabled", true)

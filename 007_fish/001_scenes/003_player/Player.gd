extends KinematicBody2D

signal game_over
signal display_skeletons
signal add_score(score_points)

# Using export allows us to set it in the Inspector
var screen_size: Vector2  # Size of the game window.
var player_size_scaled: Vector2
var motion = Vector2()  # The player's movement vector.
var fish_ate_counter: int = 0

const UP = Vector2(0, 0)
const ACCELERATION = 10
const X_DECELERATION_MULTIPLIER = 0.97
const Y_DECELERATION_MULTIPLIER = 0.95
const MAX_SPEED = 105 # slightly faster than mobs


func _ready():
	screen_size = get_viewport_rect().size
	player_size_scaled = $Sprite.texture.get_size() * scale


func _physics_process(delta: float):
	_check_for_input()


func _check_for_input():
	var vertical_key_pressed: bool = false
	var horizontal_key_pressed: bool = false

	if Input.is_action_pressed("ui_right"):
		horizontal_key_pressed = true
		motion.x += ACCELERATION
		$Sprite.flip_h = true
		$MouthArea/CollisionPolygon2D.scale.x = -abs($MouthArea/CollisionPolygon2D.scale.x)
		$WallCollision.scale.x = -abs($WallCollision.scale.x)
	if Input.is_action_pressed("ui_left"):
		horizontal_key_pressed = true
		motion.x -= ACCELERATION
		$Sprite.flip_h = false
		$MouthArea/CollisionPolygon2D.scale.x = abs($MouthArea/CollisionPolygon2D.scale.x)
		$WallCollision.scale.x = abs($WallCollision.scale.x)
	if Input.is_action_pressed("ui_down"):
		vertical_key_pressed = true
		motion.y += ACCELERATION
	if Input.is_action_pressed("ui_up"):
		vertical_key_pressed = true
		motion.y -= ACCELERATION

	# Slow down due to inertia
	if horizontal_key_pressed == false:
		motion.x = motion.x * X_DECELERATION_MULTIPLIER
	if vertical_key_pressed == false:
		motion.y = motion.y * Y_DECELERATION_MULTIPLIER

	# Limit motion to min and max
	motion.x = max(min(motion.x, MAX_SPEED), -MAX_SPEED)
	motion.y = max(min(motion.y, MAX_SPEED), -MAX_SPEED)

	motion = move_and_slide(motion, UP)


func _on_MouthArea_body_entered(body: Node):
	print("body entered mouth area")
	print(body)
	if body.is_in_group("mobs"):
		print("player size: " + str(player_size_scaled))
		print("mob size: " + str(body.size))
		# y-dimension used for size
		if body.size.y > player_size_scaled.y:
			hide()
			emit_signal("game_over")
		else:
			body.queue_free()
			emit_signal("add_score", body.score_points)
			fish_ate_counter += 1
			_grow()

func _grow():
	# Increase player size and display fish bones
	scale += Vector2(0.0012, 0.0012)
	player_size_scaled = $Sprite.texture.get_size() * scale
	if fish_ate_counter % 10 == 0:
		emit_signal("display_skeletons")


func restart(pos: Vector2):
	""" Reset the player player when starting a new game """
	scale = Vector2(0.05, 0.05)
	player_size_scaled = $Sprite.texture.get_size() * scale
	position = pos
	show()

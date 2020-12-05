extends RigidBody2D

export var size: Vector2 = Vector2(0, 0)
export var scale_multiplier: float = 0  # Decimal 0.05 - 1.0
export var score_points: int = 0  # Int 1 - 100

func _ready():
	scale(scale_multiplier)
	$AnimatedSprite.play()
	score_points = scale_multiplier * 100
	size = $AnimatedSprite.frames.get_frame("swim", 0).get_size() * scale_multiplier
	size = size - Vector2(15, 15) # Adjustment because sizes are not quite correct.
	print("printing my scale: " + str(scale_multiplier))
	print("printing my size: " + str(size))
	print("printing my score: " + str(score_points))


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

func set_facing_right():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.position.x = -$AnimatedSprite.position.x
	$CollisionPolygon2D.scale.x = -$CollisionPolygon2D.scale.x
	$CollisionPolygon2D.position.x = -$CollisionPolygon2D.position.x
	$VisibilityNotifier2D.position.x = -$VisibilityNotifier2D.position.x


func scale(multiplier: float):
	$AnimatedSprite.scale = $AnimatedSprite.scale * multiplier
	$CollisionPolygon2D.scale = $CollisionPolygon2D.scale * multiplier

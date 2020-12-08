extends Node

const MOB_LIMIT: int = 30

var player
var bad_fish: Resource = preload("res://001_scenes/004_bad_fish/BadFish.tscn")

var game_score: int = 0

func _ready():
	randomize()


func _on_UI_start_game():
	$MobTimer.start()


func end_game():
	game_score = 0
	$MobTimer.stop()
	get_tree().call_group("mobs", "queue_free")
	$UI.show_ui()
	$Player.restart($PlayerStartPosition.position)


func _on_MobTimer_timeout():
	"""Create a new mob if not too many on screen"""
	var no_of_mobs = get_tree().get_nodes_in_group("mobs").size()
	if no_of_mobs < MOB_LIMIT:
		var mob = bad_fish.instance()
		
		# Choose left or right size:
		var edge: Path2D = [$LeftEdge, $RightEdge][randi() % 2]
		var spawn_location = edge.get_node("MobSpawnLocation")
		spawn_location.offset = randi()
		mob.position = spawn_location.position
		
		# Flip the fish direction
		if edge.name == "LeftEdge":
			mob.set_facing_right()

		# Set the mob's direction perpendicular to the path direction.
		var direction = spawn_location.rotation + PI / 2
		
		# Scale the mob
		mob.scale_multiplier = ((randi() % 90) + 5) / 100.0  # 1 to 90%

		# Set the velocity (speed & direction).
		mob.linear_velocity = Vector2(rand_range(20, 100), 0)
		mob.linear_velocity = mob.linear_velocity.rotated(direction)

		add_child(mob)


func _on_Player_add_score(score_points):
	game_score += score_points
	$UI.update_score(game_score)

extends Node

export (PackedScene) var Mob
var score: int


func _ready():
	randomize() # This will randominse the seed on your rand functions


func new_game():
	# Signal from HUD
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($PlayerStartPosition.position)
	$Music.play()
	$StartTimer.start()


func game_over():
	# _on_Player_hit()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")


func _on_MobTimer_timeout():
	# Create a Mob instance
	var mob = Mob.instance()
	
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Add some randomness to the direction.
	direction += rand_range(-PI / 3, PI / 3)
	mob.rotation = direction
	
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	# Add mob to the scene
	add_child(mob)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_HUD_close_game():
	get_tree().quit()

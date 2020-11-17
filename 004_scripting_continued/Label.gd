extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies") # adds this node to the group

# This way, if the player is discovered sneaking into a secret base, 
# all enemies can be notified about its alarm sounding by using SceneTree.call_group():

func _on_discovered(): # This is a purely illustrative function.
	get_tree().call_group("enemies", "player_was_discovered")

# The above code calls the function player_was_discovered on every member of the group enemies.

# It is also possible to get the full list of enemies nodes by calling SceneTree.get_nodes_in_group():

# var enemies = get_tree().get_nodes_in_group("enemies")

# The SceneTree class provides many useful methods, like interacting with scenes, 
# their node hierarchy and groups of nodes. It allows you to easily switch scenes 
# or reload them, to quit the game or pause and unpause it. It even comes with 
# interesting signals. So check it out if you have some time!

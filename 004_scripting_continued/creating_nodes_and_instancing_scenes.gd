extends Node

var sprite
var sprite_texture = load("res://icon.png")
# var s_texture = preload("res://icon.png") # happens at parsing of the script.

# Load scene from hard drive:
#var scene = load("res://myscene.tscn") # Will load when the script is instanced.
var scene = preload("res://process_function.tscn") # Will load when parsing the script.
# The above is not a node yet, it is a special resource called 'PackedScene'. 
# It leeds to be instantiate. 
var new_node = scene.instance()  # Gives a tree of nodes
# This allows instancing of many nodes from one loaded scene.

func _ready():
	sprite = Sprite.new()
	sprite.texture = sprite_texture
	sprite.set_position(Vector2(100,100))
	add_child(sprite)
	yield(get_tree().create_timer(3.0), "timeout")
	# s.free()  # This is unsafe becuase the node might be currently in use, instead use:
	sprite.queue_free() # Safest way - deletes when node is idle.

	yield(get_tree().create_timer(2.0), "timeout")

	# add an instance of a scene here:
	add_child(new_node)

	# This is a class and a static function that I wrote myself and have 
	# registered it in the Editor, making it visible in other places. 
	ScriptName.double_it(2)
	# You would need to instatiate this class like so: 
	var my_class = ScriptName.new()
	my_class.queue_free()

extends Label


# Such overridable functions, which are described as follows, can be applied to nodes:

func _enter_tree():
	# When the node enters the Scene Tree, it becomes active
	# and  this function is called. Children nodes have not entered
	# the active scene yet. In general, it's better to use _ready()
	# for most cases.
	pass

func _ready():
	# This function is called after _enter_tree, but it ensures
	# that all children nodes have also entered the Scene Tree,
	# and became active.
	pass

func _exit_tree():
	# When the node exits the Scene Tree, this function is called.
	# Children nodes have all exited the Scene Tree at this point
	# and all became inactive.
	pass

func _process(delta):
	# This function is called every frame.
	pass

func _physics_process(delta):
	# This is called every physics frame.
	pass

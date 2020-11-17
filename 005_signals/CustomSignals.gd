extends Node2D

# Declare your signal
signal my_custom_signal
# It will now appear in the Node tab and can be connected as normal
# they can always be connected by code too

# Alternatively, your signal can declare arguments:
signal my_signal(value, other_value)


# Emit your signal when you want it
func _ready():
	emit_signal("my_custom_signal")
	emit_signal("my_signal", 10, "hello")

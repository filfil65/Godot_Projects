extends Node

# Declare the class name here, the icon is optional
class_name ScriptName, "res://icon.png"

func _ready():
	pass

static func double_it(number: int) -> int:
	return number * 2

# This script has now been registered with the editor and the functions/classes
# will appear int he hits. So in another script, you can now type in 'ScriptName' 
# and it will be found.

extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	#							 ^ one of the default signals in Button? 
	# Alternatively if Button is a child of Lable, then: 
	# get_node("Lable\Button").connect("pressed" ,self, "_on_Button_pressed")
	#			 ^ nodes are referenced by name, not type

func _on_Button_pressed():
	get_node("Label").text = "HELLO!!"


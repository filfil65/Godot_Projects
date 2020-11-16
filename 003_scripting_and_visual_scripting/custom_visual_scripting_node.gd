tool
extends VisualScriptCustomNode

# The name of the custom node as it appears in the search.
func _get_caption():
	return "Get Input Direction 2D"

func _get_category():
	return "Input"

# The text displayed after the input port / sequence arrow.
func _get_text():
	return "Bob"

func _get_input_value_port_count():
	return 0

# The types of the inputs per index starting from 0.
func _get_input_value_port_type(idx):
	return TYPE_OBJECT

func _get_output_value_port_count():
	return 1

# The types of outputs per index starting from 0.
func _get_output_value_port_type(idx):
	return TYPE_VECTOR2

# The text displayed before each output node per index.
func _get_output_value_port_name(idx):
	return "Direction"

func _has_input_sequence_port():
	return true

# The number of output sequence ports to use
# (has to be at least one if you have an input sequence port).
func _get_output_sequence_port_count():
	return 1

# The most important part of a custom node is the _step function. The logic of the node is defined there.
func _step(inputs, outputs, start_mode, working_mem):
	# start_mode can be checked to see if it is the first time _step is called.
	# This is useful if you only want to do an operation once.

	# working_memory is persistent between _step calls.

	# The inputs array contains the value of the input ports.

	var x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	# The outputs parameter is an array where the indices represent the output port ids. 
	# It can be modified to set the values of the output ports.
	outputs[0] = Vector2(x, y)

	# If you want to throw an error, for example if the input types are incorrect, 
	# you can return the error message as a string. When everything goes right, 
	# return the id of the sequence port which should be called next. 
	# If your custom node doesn't have any, just return 0.
	return 0


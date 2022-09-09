extends VBoxContainer

onready var input_field = $NewInput
onready var pool = $Pool/VBoxContainer

export var new_element : PackedScene

var element_array = []

func _create_new_element(title:String) -> void:
	var temp_element = new_element.instance()
	pool.add_child(temp_element)
	element_array.append(temp_element)
	temp_element.set_title(title)
	

func _on_NewElement_pressed():
	_create_new_element(input_field.get_text())
	print("call")

extends VBoxContainer

onready var input_field = $NewInput
onready var pool = $Pool/VBoxContainer

export var new_element : PackedScene

func _create_new_element(title:String) -> void:
	var temp_element = new_element.instance()
	pool.add_child(temp_element)
	temp_element.set_title(title)
	temp_element.connect("destroy", self, "_on_element_delete", [temp_element])
	
func _on_NewElement_pressed():
	_create_new_element(input_field.get_text())

func _on_element_delete(element) -> void:
	element.queue_free()

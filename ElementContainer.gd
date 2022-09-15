extends VBoxContainer

onready var input_field = $NewInput
onready var pool = $Pool/VBoxContainer

export var new_element : PackedScene

signal forced(node)

func _create_new_element(title:String) -> void:
	var temp_element = new_element.instance()
	pool.add_child(temp_element)
	temp_element.set_title(title)
	temp_element.connect("destroy", self, "_on_element_delete", [temp_element])
	temp_element.connect("forced", self, "_on_element_forced", [temp_element])
	
func _on_NewElement_pressed():
	_create_new_element(input_field.get_text())
	input_field.text = ""

func _on_NewInput_text_entered(new_text):
	_create_new_element(input_field.get_text())
	input_field.text = ""

func _on_element_delete(element) -> void:
	if element.daily_node != null:
		element.daily_node.queue_free()
	element.queue_free()

func _on_element_forced(element) -> void:
	emit_signal("forced", element)

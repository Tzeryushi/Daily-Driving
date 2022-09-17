class_name ElementContainer
extends VBoxContainer

onready var input_field = $NewInput
onready var pool = $Pool/VBoxContainer

export var new_element : PackedScene

signal forced(node)

func clear_elements() -> void:
	for i in pool.get_children():
		_on_element_delete(i)

func add_element(new_title:String, new_priority:float, is_forced:bool, has_daily:bool) -> Element:
	var temp_element = new_element.instance()
	pool.add_child(temp_element)
	temp_element.set_title(new_title)
	temp_element.connect("destroy", self, "_on_element_delete", [temp_element])
	temp_element.connect("forced", self, "_on_element_forced", [temp_element])
	temp_element.set_force(is_forced)
	temp_element.set_used(has_daily)
	temp_element.set_priority(new_priority)
	return temp_element

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

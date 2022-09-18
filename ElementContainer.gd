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
	if matching_title(new_title): return null
	var temp_element = new_element.instance()
	pool.add_child(temp_element)
	temp_element.set_title(new_title)
	temp_element.connect("destroy", self, "_on_element_delete", [temp_element])
	temp_element.connect("forced", self, "_on_element_forced", [temp_element])
	temp_element.set_force(is_forced)
	temp_element.set_used(has_daily)
	temp_element.set_priority(new_priority)
	reorder()
	return temp_element

func _create_new_element(title:String) -> void:
	if matching_title(title): return
	var temp_element = new_element.instance()
	pool.add_child(temp_element)
	temp_element.set_title(title)
	temp_element.connect("destroy", self, "_on_element_delete", [temp_element])
	temp_element.connect("forced", self, "_on_element_forced", [temp_element])
	reorder()

func matching_title(new_title:String) -> bool:
	for i in pool.get_children():
		if new_title == i.get_title(): return true
	return false

func reorder() -> void:
	var normal_array = []
	var name_array = []
	for i in pool.get_children():
		if !i.get_force():
			normal_array.append(i)
			name_array.append(i.get_title())
	name_array.sort()
	for i in range(name_array.size()-1, -1, -1):
		for j in normal_array:
			if name_array[i] == j.get_title():
				pool.move_child(j, 0)
	var force_array = []
	name_array = []
	for i in pool.get_children():
		if i.get_force():
			force_array.append(i)
			name_array.append(i.get_title())
	name_array.sort()
	for i in range(name_array.size()-1, -1, -1):
		for j in force_array:
			if name_array[i] == j.get_title():
				pool.move_child(j, 0)

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
	reorder()
	emit_signal("forced", element)

func _input(event) -> void:
	if event.is_action_pressed("reorder"):
		reorder()

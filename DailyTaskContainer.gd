extends VBoxContainer

onready var pool := $DailyTasks/VBoxContainer
onready var task_number_label := $HBoxContainer/NumberLabel
onready var task_number_slider := $HBoxContainer/TaskNumber

export(NodePath) var element_container
export(NodePath) var popped_container

export var daily_element : PackedScene

var number_of_tasks

signal day_set(number)
signal switch
signal clear_out

func _ready() -> void:
	element_container = get_node(element_container)
	popped_container = get_node(popped_container)
	#TODO: get this from save file
#get list of nodes within the pool, select amount based on priority

func set_task_number(number:int) -> void:
	number_of_tasks = number
	task_number_label.text = String(number_of_tasks)
	task_number_slider.value = number_of_tasks

func clear_elements() -> void:
	for i in pool.get_children():
		_on_daily_delete(i)

func add_element(origin:Element, is_popped:bool) -> void:
	var new_element = _create_new_element(origin.get_title(), origin)
	origin.link_daily_node(new_element)
	new_element.set_force(origin.get_force())
	if is_popped:
		new_element.pop()
	
func _create_new_element(title:String, origin:Node) -> Node:
	var temp_element = daily_element.instance()
	pool.add_child(temp_element)
	temp_element.initialize(title, origin)
	temp_element.connect("destroy", self, "_on_daily_delete", [temp_element])
	temp_element.connect("pop", self, "_on_daily_pop", [temp_element])
	return temp_element

func _on_NewDay_pressed():
	var force_count = 0
	clear_elements()
	emit_signal("clear_out")
	if element_container.get_child_count() == 0:
		return
	for i in element_container.get_children():
		if i.get_force():
			force_count += 1
			if !i.get_used():
				i.link_daily_node(_create_new_element(i.get_title(), i))
				i.set_used(true)
				i.daily_node.set_force(true)
	for i in range(0, number_of_tasks):
		var chosen = element_container.get_child(select_index())
		if !chosen.get_used():
			force_count += 1
			chosen.link_daily_node(_create_new_element(chosen.get_title(), chosen))
			chosen.set_used(true)
	emit_signal("day_set", force_count)

func select_index() -> int:
	var weight_array = []
	var full_weight = 0.0
	#add exclusions to avoid duplicates
	for i in element_container.get_children():
		if i.get_used() or i.get_force():
			weight_array.append(0.0)
		else:
			weight_array.append(i.priority)
	var prefix_array = []
	prefix_array.append(weight_array[0])
	for index in range(1,weight_array.size()):
		prefix_array.append(prefix_array[index-1]+weight_array[index])
	randomize()
	var random = rand_range(0.0, prefix_array.back())
	var choose_index = 0
	for i in range(0, prefix_array.size()):
		if (prefix_array[i]>random):
			choose_index = i
			break
	return choose_index

func _on_daily_delete(element) -> void:
	var node_x = element.origin_node
	node_x.daily_node = null
	node_x.set_used(false)
	element.queue_free()

func _on_daily_pop(element) -> void:
	#instance element in poppedtasks, delete from here
	if element.get_popped():
		pool.remove_child(element)
		popped_container.add_child(element)
	else:
		popped_container.remove_child(element)
		pool.add_child(element)
		if element.get_force():
			pool.move_child(element, 0)
	emit_signal("switch")

func _on_TaskNumber_value_changed(value):
	number_of_tasks = value
	task_number_label.text = String(value)

func _on_ElementContainer_forced(node):
#	if node.get_force():
#		if node.get_used():
#			node.set_used(false)
#		else:
#			node.link_daily_node(_create_new_element(node.get_title(), node))
#	else:
#		_on_daily_delete(node.daily_node)
	pass

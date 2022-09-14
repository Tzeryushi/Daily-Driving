extends VBoxContainer

onready var pool = $DailyTasks/VBoxContainer

export(NodePath) var element_container

export var daily_element : PackedScene

func _ready() -> void:
	element_container = get_node(element_container)
#get list of nodes within the pool, select amount based on priority

func _create_new_element(title:String, origin:Node) -> Node:
	var temp_element = daily_element.instance()
	pool.add_child(temp_element)
	temp_element.initialize(title, origin)
	temp_element.connect("destroy", self, "_on_daily_delete", [temp_element])
	return temp_element

func _on_NewDay_pressed():
	var chosen = element_container.get_child(select_index())
	chosen.link_daily_node(_create_new_element(chosen.get_title(), chosen))
	chosen.used = true

func select_index() -> int:
	var weight_array = []
	var full_weight = 0.0
	#add exclusions to avoid duplicates
	for i in element_container.get_children():
		if i.used == true:
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
	element.queue_free()

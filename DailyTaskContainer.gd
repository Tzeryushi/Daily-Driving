extends VBoxContainer

export(NodePath) var element_container

func _ready() -> void:
	element_container = get_node(element_container)
#get list of nodes within the pool, select amount based on priority
func _on_NewDay_pressed():
	select_index()

func select_index() -> void:
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
	full_weight = prefix_array.back()

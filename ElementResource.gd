class_name SaveElement
extends Resource

var elements := {}

func add_element(node:Element) -> void:
	if node.daily_node != null:
		elements[node.element_title.text] = {"priority":node.priority, "force":node.force,
		"daily":(node.daily_node!=null), "popped":(node.daily_node.popped)}
	else:
		elements[node.element_title.text] = {"priority":node.priority, "force":node.force,
		"daily":(node.daily_node!=null), "popped":false}

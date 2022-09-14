extends VBoxContainer

onready var element_title = $Title

var origin_node = null

signal destroy

func initialize(title:String, origin:Node) -> void:
	set_title(title)
	link_origin_node(origin)

func set_title(title:String) -> void:
	element_title.text = title

func link_origin_node(node) -> void:
	origin_node = node

func destroy() -> void:
	emit_signal("destroy")

func _on_Pop_pressed():
	pass # Replace with function body.

func _on_Kill_pressed():
	destroy()

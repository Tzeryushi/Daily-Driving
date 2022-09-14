extends VBoxContainer

onready var element_title = $Title
onready var priority_text = $HBoxContainer/Priority

var daily_node = null

var priority : float = 1.0
var force : bool = false
var used : bool = false

signal destroy

func _ready() -> void:
	priority_text.text = String(priority)
	return 

func get_title() -> String:
	return element_title.text

func set_title(title:String) -> void:
	element_title.text = title

func destroy() -> void:
	emit_signal("destroy")

func link_daily_node(node) -> void:
	daily_node = node

func _on_Delete_pressed():
	destroy() # Replace with function body.

func _on_PriorityInput_value_changed(value):
	priority = float(value)
	priority_text.text = String(value)

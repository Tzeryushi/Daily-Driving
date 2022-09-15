extends Control

onready var element_title = $ElementBox/Title
onready var priority_text = $ElementBox/HBoxContainer/Priority
onready var bg = $Background

export var default_color : Color = Color(1,1,1,1)
export var force_color : Color = Color(1,1,1,1)
export var used_color : Color = Color(1,1,1,1)

var daily_node = null

var priority : float = 1.0
var force : bool = false
var used : bool = false

signal destroy
signal forced

func _ready() -> void:
	priority_text.text = String(priority)
	return 

func get_title() -> String:
	return element_title.text

func set_title(title:String) -> void:
	element_title.text = title

func get_force() -> bool:
	return force

func set_force(f:bool) -> void:
	if f:
		bg.color = force_color
	else:
		bg.color = default_color
	force = f

func get_used() -> bool:
	return used

func set_used(use:bool) -> void:
	if !force:
		if use:
			bg.color = used_color
		else:
			bg.color = default_color
	used = use

func destroy() -> void:
	emit_signal("destroy")

func link_daily_node(node) -> void:
	daily_node = node

func _on_Delete_pressed():
	destroy() # Replace with function body.

func _on_PriorityInput_value_changed(value):
	priority = float(value)
	priority_text.text = String(value)

func _on_Force_pressed():
	set_force(!force)

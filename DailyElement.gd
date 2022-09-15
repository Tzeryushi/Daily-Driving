extends Control

onready var element_title = $DailyElementBox/Title
onready var pop_button = $DailyElementBox/HBoxContainer/Pop
onready var bg = $Background

export var default_color : Color = Color(1,1,1,1)
export var force_color : Color = Color(1,1,1,1)
export var done_color : Color = Color(1,1,1,1)

var origin_node = null

var force : bool = false
var popped : bool

signal destroy
signal pop

func _ready() -> void:
	popped = false
	#bg = default_color

func initialize(title:String, origin:Node, forced:bool=false) -> void:
	set_title(title)
	link_origin_node(origin)
	set_force(forced)

func set_title(title:String) -> void:
	element_title.text = title

func link_origin_node(node) -> void:
	origin_node = node

func get_force() -> bool:
	return force

func set_force(f:bool) -> void:
	if f:
		bg.color = force_color
	else:
		bg.color = default_color
	force = f

func get_popped() -> bool:
	return popped

func pop() -> void:
	if !popped:
		pop_button.text = "Unpop"
		bg.color = done_color
	else:
		pop_button.text = "Pop"
		if force: bg.color = force_color
		else: bg.color = default_color
	popped = !popped
	emit_signal("pop")

func destroy() -> void:
	emit_signal("destroy")

func _on_Pop_pressed():
	pop()

func _on_Kill_pressed():
	destroy()

extends VBoxContainer

onready var element_title = $Title

var priority : float = 1.0
var force : bool = false
var used : bool = false

signal destroy

func set_title(title:String) -> void:
	element_title.text = title

func destroy() -> void:
	emit_signal("destroy")

func _on_Delete_pressed():
	destroy() # Replace with function body.
	
func _on_PriorityInput_text_entered(new_text):
	priority = float(new_text)


func _on_PriorityInput_text_changed(new_text):
	priority = float(new_text)

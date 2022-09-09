extends VBoxContainer

onready var element_title = $Title

signal destroy

func set_title(title:String) -> void:
	element_title.text = title

func destroy() -> void:
	emit_signal("destroy")


func _on_Delete_pressed():
	destroy() # Replace with function body.

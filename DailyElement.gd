extends VBoxContainer

onready var element_title = $Title

func set_title(title:String) -> void:
	element_title.text = title

func _on_Pop_pressed():
	pass # Replace with function body.

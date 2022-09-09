extends VBoxContainer

onready var element_title = $Title

func set_title(title:String) -> void:
	element_title.text = title

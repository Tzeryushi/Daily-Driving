extends Control

const SAVE_PATH := "res://save.json"

onready var element_container = $HBoxContainer/ElementContainer
onready var calendar_container = $HBoxContainer/Calendar

var element_list: Resource = SaveElement.new()
var calendar_list: Resource = SaveCalendar.new()

var _file := File.new()

func populate() -> void:
	for i in element_container.pool.get_children():
		element_list.add_element(i)
	for i in calendar_container.pool.get_children():
		calendar_list.add_day(i.percent_fill)
	
func save_state() -> void:
	var error := _file.open(SAVE_PATH, File.WRITE)
	if error != OK:
		printerr("Could not open %s. Error code %s" % [SAVE_PATH, error])
		return
	
	populate()
	var data := {
		"elements": element_list.elements,
		"calendar": calendar_list.days_list
	}
	
	var json_string = JSON.print(data)
	_file.store_string(json_string)
	_file.close()


func _on_Save_pressed():
	save_state()

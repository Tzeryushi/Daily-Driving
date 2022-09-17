extends Control

const SAVE_PATH := "res://save.json"

onready var element_container = $HBoxContainer/ElementContainer
onready var daily_container = $HBoxContainer/DailyTaskContainer
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
	
func load_state() -> void:
	var error := _file.open(SAVE_PATH, File.READ)
	if error != OK:
		printerr("Could not open %s. Error code %s" % [SAVE_PATH, error])
		return
	
	var content := _file.get_as_text()
	_file.close()
	
	var data: Dictionary = JSON.parse(content).result
	var element_keys = data.elements.keys()
	var count = 0
	for i in range(0, element_keys.size()):
		var temp_element = element_container.add_element(element_keys[i], data.elements[element_keys[i]]["priority"], data.elements[element_keys[i]]["force"], data.elements[element_keys[i]]["daily"])
		if data.elements[element_keys[i]]["daily"]:
			daily_container.add_element(temp_element, data.elements[element_keys[i]]["popped"])
	for i in data.calendar:
		calendar_container.add_day(i)

func _on_Save_pressed():
	load_state()

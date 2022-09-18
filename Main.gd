extends Control

const SAVE_PATH := "user://save.json"

onready var element_container := $HBoxContainer/ElementContainer
onready var daily_container := $HBoxContainer/DailyTaskContainer
onready var popped_container := $HBoxContainer/PoppedTaskContainer
onready var calendar_container := $HBoxContainer/Calendar

var element_list: Resource = SaveElement.new()
var calendar_list: Resource = SaveCalendar.new()

var _file := File.new()

func _ready() -> void:
	load_state()

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
		"calendar": calendar_list.days_list,
		"tasks": daily_container.number_of_tasks
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
	var parse_data = JSON.parse(content)
	if parse_data.error != OK:
		printerr("Gross data in %s. Error code %s" % [SAVE_PATH, error])
		return
	var data : Dictionary = parse_data.result
	var element_keys = data.elements.keys()
	var daily_count = 0
	for i in range(0, element_keys.size()):
		var temp_element = element_container.add_element(element_keys[i], data.elements[element_keys[i]]["priority"], data.elements[element_keys[i]]["force"], data.elements[element_keys[i]]["daily"])
		if data.elements[element_keys[i]]["daily"] and temp_element != null:
			daily_count += 1
			daily_container.add_element(temp_element, data.elements[element_keys[i]]["popped"])
	for i in data.calendar:
		calendar_container.add_day(i)
	popped_container.set_max_count(daily_count)
	popped_container.update_count()
	if data.has("tasks"):
		if data.tasks != null:
			daily_container.set_task_number(data.tasks)
		else:
			daily_container.set_task_number(5)
	else:
		daily_container.set_task_number(5)

func _notification(what: int) -> void:
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST || what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		save_state()

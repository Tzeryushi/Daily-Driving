extends VBoxContainer

onready var count_label = $Count
onready var pool = $PoppedTasks/VBoxContainer

var count : int = 0
var max_count : int = 0

signal end_day(percentage)

func clear_elements() -> void:
	for i in pool.get_children():
		_on_daily_delete(i)

func update_count() -> void:
	count_label.text = "Complete: " + String(count) + "/" + String(max_count)

func _on_DailyTaskContainer_switch():
	count = pool.get_child_count()
	update_count()

func set_max_count(number) -> void:
	max_count = number

func _on_DailyTaskContainer_day_set(number):
	count = 0
	max_count = number
	update_count()

func _on_EndDay_pressed():
	emit_signal("end_day", float(pool.get_child_count())/float(max_count))

func _on_daily_delete(element) -> void:
	var node_x = element.origin_node
	node_x.daily_node = null
	node_x.set_used(false)
	element.queue_free()

func _on_DailyTaskContainer_clear_out():
	clear_elements()

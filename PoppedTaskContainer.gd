extends VBoxContainer

onready var count_label = $Count
onready var pool = $PoppedTasks/VBoxContainer

var max_count : int = 0

signal end_day(percentage)

func update_count() -> void:
	count_label.text = "Complete: " + String(pool.get_child_count()) + "/" + String(max_count)

func _on_DailyTaskContainer_switch():
	update_count()

func _on_DailyTaskContainer_day_set(number):
	max_count = number
	update_count()

func _on_EndDay_pressed():
	emit_signal("end_day", float(pool.get_child_count())/float(max_count))

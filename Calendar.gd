class_name CalendarContainer
extends ScrollContainer

onready var pool = $CompleteContainer

export var done_day : PackedScene

export var waste_color := Color(1,1,1,1)
export var complete_color := Color(1,1,1,1)
export var half_color:= Color(1,1,1,1)

func add_day(percent:float=0.0) -> void:
	var new_day = done_day.instance()
	pool.add_child(new_day)
	new_day.percent_fill = percent
	new_day.color = waste_color.linear_interpolate(complete_color, percent)
#	if percent <= 0.0:
#		new_day.color = waste_color
#	elif percent > 0.0 and percent < 1.0:
#		new_day.color = half_color
#	else:
#		new_day.color = complete_color

func readout() -> String:
	var output = ""
	for i in pool.get_children():
		output += output
	return output

func _on_PoppedTaskContainer_end_day(percentage):
	add_day(percentage)

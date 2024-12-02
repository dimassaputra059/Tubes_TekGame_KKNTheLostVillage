class_name DateTime extends Resource

@export_range(0, 59) var seconds: int = 0
@export_range(0, 59) var minutes: int = 0
@export_range(0, 23) var hours: int = 0

var delta_time: float = 0

signal time_expired

func decrease_by_sec(delta_seconds: float) -> void:
	delta_time += delta_seconds
	if delta_time < 1: return

	var delta_int_secs: int = delta_time
	delta_time -= delta_int_secs

	# Convert total seconds to current time breakdown
	var total_seconds: int = ((hours * 3600) + (minutes * 60) + seconds) - delta_int_secs
	if total_seconds < 0:
		total_seconds = 0 # Prevent going below zero

	hours = total_seconds / 3600
	minutes = (total_seconds % 3600) / 60
	seconds = total_seconds % 60
	
	if hours == 0 and minutes == 0 and seconds == 0:
		emit_signal("time_expired")  # Emit sinyal waktu habis

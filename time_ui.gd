extends Control

@onready var hours_label: Label = $ClockControl/hours
@onready var minutes_label: Label = $ClockControl/minutes
@onready var seconds_label: Label = $ClockControl/seconds

func _on_time_system_updated(date_time: DateTime) -> void:
	hours_label.text = str(date_time.hours)
	minutes_label.text = str(date_time.minutes)
	seconds_label.text = str(date_time.seconds)

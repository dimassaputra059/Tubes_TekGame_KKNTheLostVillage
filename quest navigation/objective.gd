extends CanvasLayer

@onready var label = $TextBoxContainer/MarginContainer/HBoxContainer/Label
var objective = 0

func _ready() -> void:
	add_text("Keluar dari hutan")
	Dialogic.signal_event.connect(DialogicSignal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if objective == 1:
		add_text("Masuk lebih dalam kehutan")
	elif objective == 2:
		add_text("Bertanya ke penduduk")
	elif objective == 3:
		add_text("Mencari Jamur di dekat pohon besar")
	elif objective == 4:
		add_text("Kembali ke Nenek")
	elif objective == 5:
		add_text("Bertanya ke anak kecil")
	elif objective == 6:
		add_text("Mencari Datok Hassan")
	elif objective == 7:
		add_text("Pergi ke Timur")
	elif objective == 8:
		add_text("Mencari jalan keluar")

func add_text(next_text):
	label.text = next_text
	
func DialogicSignal(arg: String):
	if arg == "masuk_ke_hutan":
		objective = 1
	elif arg == "masuk_ke_desa":
		objective = 2
	elif arg == "start_quest":
		objective = 3
	elif arg == "item_collected":
		objective = 4
	elif arg == "quest_end":
		objective = 5
	elif arg == "kakek_di_danau":
		objective = 6
	elif arg == "npc2_dialogEnd":
		objective = 7
	elif arg == "keluar_dari_mapLvl2":
		objective = 8

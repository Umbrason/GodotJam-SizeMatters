extends HSlider

@export var busname: String = "Master"
@onready var _bus = AudioServer.get_bus_index(busname)

func _ready():
    value = db_to_linear(AudioServer.get_bus_volume_db(_bus)) * 100.
    self.value_changed.connect(onUpdated)

func free():
    self.value_changed.disconnect(onUpdated)

func visibility_changed():
    value = db_to_linear(AudioServer.get_bus_volume_db(_bus)) * 100.

func onUpdated(val):
    var db = linear_to_db(val / 100.)
    AudioServer.set_bus_volume_db(_bus, db)

extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rand: int
enum {twinking, waiting}
var state = waiting
export var maxlight = 1
export var lightRate = 0.05
export var twinkModulo = 20
var main_lamp
var energy
# Called when the node enters the scene tree for the first time.
func _ready():
	main_lamp = get_node("Light")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var random = rand_range(0,3000)
	energy = main_lamp.get_energy()
	if(random < twinkModulo && state == waiting):
		energy = 0
		state = twinking
		
	if(state == twinking):
		_twink()

func _twink():
	if(energy < maxlight):
		energy += lightRate
		main_lamp.set_energy(energy)
	else:
		state = waiting


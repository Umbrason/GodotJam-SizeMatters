extends Area2D

class_name WeightCounter

signal weight_changed(old, new)
var current_weight: int = 0

func _ready():
	self.body_entered.connect(onBodyEnter)
	self.body_exited.connect(onBodyExit)
	pass

func free():
	self.body_entered.disconnect(onBodyEnter)
	self.body_exited.disconnect(onBodyExit)
	pass

func onBodyEnter(body):
	var weight = body.get_node_or_null("./Weight") as Weight
	if (weight == null): return
	var old_weight = current_weight
	current_weight += weight.weight
	weight.weight_changed.connect(onMemberWeightChanged)
	if(current_weight != old_weight):
		weight_changed.emit(old_weight, current_weight)

func onMemberWeightChanged(old, new):
	var old_weight = current_weight
	current_weight -= old
	current_weight += new
	if(current_weight != old_weight):
		weight_changed.emit(old_weight, current_weight)

func onBodyExit(body):
	var weight = body.get_node_or_null("./Weight") as Weight
	if (weight == null): return
	var old_weight = current_weight
	current_weight -= weight.weight
	weight.weight_changed.disconnect(onMemberWeightChanged)
	if(current_weight != old_weight):
		weight_changed.emit(old_weight, current_weight)
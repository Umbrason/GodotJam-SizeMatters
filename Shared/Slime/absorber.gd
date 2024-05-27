extends Node2D

class_name Absorber

@onready var weight = $"../Weight" as Weight

func tryAbsorb(body):
	if(body == null): return
	var absorbable = body.get_node_or_null("./Absorbable") as Absorbable
	if(absorbable == null): return
	
	if weight.weight <= absorbable.weight.weight: return
	var weightGain = absorbable.absorb()
	print(weightGain)
	weight.weight += weightGain

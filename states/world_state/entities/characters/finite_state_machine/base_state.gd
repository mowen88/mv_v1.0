
# Description: Base class blueprint for all individual states

extends Node
class_name State

var fsm: FiniteStateMachine
var actor: CharacterBody2D

func enter():
	pass

func exit():
	pass

func update(_delta):
	pass
	
func physics_update(_delta):
	pass

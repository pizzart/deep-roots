extends Node2D

export var value = 300;

func _on_Area2D_body_entered(body):
	body.minerals += value;

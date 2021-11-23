extends Node2D

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += Vector2(-2, 0)

func destroy():
	queue_free()

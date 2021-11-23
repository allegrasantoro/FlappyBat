extends Node2D
const wallsName = ["Wall0","Wall1","Wall2","Wall3","Wall4", "Wall5", "Wall6"]
var wallScenes = []
var rng = RandomNumberGenerator.new()
var last_spawned_obstacle = null
var score = 0

func _ready():
	loadWalls()
	$CanvasLayer/BestScoreNumber.text = String(Global.best_score)

func spawn_obstacle():
	rng.randomize()
	var random_index = floor(rng.randf_range(0, 7))
	var obstacle_instance = wallScenes[random_index].instance()
	$ObstaclesContainer.add_child(obstacle_instance)
	last_spawned_obstacle = obstacle_instance
	
func loadWalls():
	for wall in wallsName:
		var scene = "res://Scenes/Obstacles/" + wall + ".tscn"
		wallScenes.append(load(scene))

func _on_spawn_Timer_timeout():
	spawn_obstacle()

func _on_Area2D_area_entered(area):
	if area.is_in_group("passPoint"):
		score = score + 1
		changeScore()

func _on_ExitArea_body_entered(body):
	body.destroy()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Obstacles"):
		get_tree().reload_current_scene()

func changeScore():
	$CanvasLayer/CurrentScoreNumber.text = String(score)
	if (score > Global.best_score):
			Global.best_score = score
			$CanvasLayer/BestScoreNumber.text = String(Global.best_score)


func _on_LevelBoundaries_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()

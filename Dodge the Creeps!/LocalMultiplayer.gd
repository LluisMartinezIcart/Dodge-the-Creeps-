extends Node
export(PackedScene) var mob_scene
var score_player_1 = 0
var score_player_2 = 0
var player_1_alive = true
var player_2_alive = true


func _ready():
	randomize()
	

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUB.show_game_over()
	$Music.stop() 
	$DeathSound.play() 
	
func new_game():
	score_player_1 = 0
	score_player_2 = 0
	player_1_alive = true
	player_2_alive = true
	$HUB.update_scores(score_player_1, score_player_2)
	$Player.start($StartPosition.position)
	$Player2.start($StartPosition2.position)
	$StartTimer.start()
	$HUB.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()


func _on_MobTimer_timeout():
	# Crea una nova instància de l'escena Mob.
	var mob = mob_scene.instance()
	
	# Trieu una ubicació aleatòria a Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	# Estableix la direcció de la multitud perpendicular a la direcció del camí.
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Estableix la posició de la multitud a una ubicació aleatòria.
	mob.position = mob_spawn_location.position
	
	# Afegeix una mica d'aleatorietat a la direcció.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Tria la velocitat de la multitud.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Va fer que la multitud s'afegís a l'escena principal.
	add_child(mob)


func _on_ScoreTimer_timeout():
	if player_1_alive:
		score_player_1 += 1

	if player_2_alive:
		score_player_2 += 1

	$HUB.update_scores(score_player_1, score_player_2)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_Player2_hit():
	player_2_alive = false
	check_game_over()


func _on_Player_hit():
	player_1_alive = false
	check_game_over()

func check_game_over():
	if not player_1_alive and not player_2_alive:
		game_over()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Menu.tscn")

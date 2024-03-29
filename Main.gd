extends Node2D

const BALL = preload("Ball.tscn")
var current_ball

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if Input.is_action_just_pressed("toggle_fullscreen"):
    get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED

func _ready():
  spawn_ball($StartPoint)
  
func spawn_ball(point):
  current_ball = BALL.instantiate()
  $".".add_child(current_ball)
  current_ball.position = point.position
  
func despawn_ball():
  current_ball.queue_free()
  
func reset(point):
  despawn_ball()
  spawn_ball(point)
  $Player.reset_touched()
  $Enemy.reset_touched()
  $BallReset.play()

func point_to_enemy():
  $EnemyPoints.inc()
  reset($StartPointEnemy)
  
func point_to_player():
  $PlayerPoints.inc()
  reset($StartPoint)

func reset_enemy_touched():
  $Enemy.reset_touched()

func reset_player_touched():
  $Player.reset_touched()

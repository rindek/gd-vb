extends Node2D

const BALL = preload("Ball.tscn")
var current_ball

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  if Input.is_action_just_pressed("toggle_fullscreen"):
    OS.set_window_fullscreen(!OS.window_fullscreen)

func _ready():
  spawn_ball()
  
func spawn_ball():
  current_ball = BALL.instance()
  $".".add_child(current_ball)
  current_ball.position = $StartPoint.position
  
func despawn_ball():
  current_ball.queue_free()
  
func reset():
  despawn_ball()
  spawn_ball()
#
#    var newball = BALL.instance()
#    get_tree().get_root().add_child(newball)
#    newball.position = get_tree().get_root().get_node("World/StartPoint").position

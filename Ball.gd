extends RigidBody2D

const DEFAULT_GRAVITY = 3


func set_gravity():
  gravity_scale = DEFAULT_GRAVITY


func _on_RigidBody2D_body_entered(body):
  $HitSound.play()
  if body.is_in_group("player") or body.is_in_group("enemy"):
    body.get_parent().ball_touched(self)
  elif body.is_in_group("player_floor"):
    get_node("/root/World").point_to_enemy()
  elif body.is_in_group("enemy_floor"):
    get_node("/root/World").point_to_player()

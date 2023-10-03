extends Label


var points = 0

func _ready():
  set_point()

func set_point():
  self.text = var_to_str(points)

func inc():
  points += 1
  set_point()

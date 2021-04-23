extends Label


var points = 0

func _ready():
  set_point()

func set_point():
  self.text = String(points)

func inc():
  points += 1
  set_point()

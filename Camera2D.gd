extends Camera2D

@export var speed: float = 60.0

func _process(delta):
    var center_x = get_screen_center().x
    
    if center_x > 950 or center_x < 0:
        speed *= -1
    
    position.x += speed * delta

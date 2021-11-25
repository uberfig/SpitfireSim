extends Spatial

var camrot_h = 0
var camrot_v = 0
var cam_v_max = 75
var cam_v_min = -55
var h_sensitivity = 0.1
var v_sensitivity = -0.1
var h_acceleration = 10
var v_acceleration = 10
var invert_y = 1 #set this to -1 to invert y

func _ready():
	#add a colision exception so the camera doesn't collide with it's parent
#	$h/v/Camera.add_exception(get_parent())
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	invert_y = -1


func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x * h_sensitivity
		camrot_v += event.relative.y * v_sensitivity * invert_y
	
	
	if event.is_action_pressed("ui_cancel"): 
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	
	camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
	
#		#MOUSE CAMERA
	$h.rotation_degrees.y = lerp($h.rotation_degrees.y, camrot_h, delta * h_acceleration)
	
	$h/v.rotation_degrees.x = lerp($h/v.rotation_degrees.x, camrot_v, delta * v_acceleration)
	



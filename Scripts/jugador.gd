extends KinematicBody2D

export var rapidez = 150
const maxrapidez= 180

var velocidad = Vector2()

const gravedad = 15
var altura_salto = 255
var fuerza_empuje = 50
const up = Vector2(0, -1)

onready var sprite = $Sprite/dinosaurio
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	velocidad.y += gravedad
	var friccion = false
	
	if Input.is_action_pressed("ui_right"):
		velocidad.x = rapidez
		sprite.flip_h = false
		animationPlayer.play("Walk")
		velocidad.x = min(velocidad.x + rapidez, +maxrapidez)
		
	elif Input.is_action_pressed("ui_left"):
		velocidad.x = -rapidez
		sprite.flip_h = true
		animationPlayer.play("Walk")
		velocidad.x = max(velocidad.x - rapidez, -maxrapidez)
		
	else:
		animationPlayer.play("Idle")
		friccion = true
		
	if is_on_floor():
		if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_up") :
			velocidad.y = -altura_salto
		velocidad.x = lerp(velocidad.x,0,0.5)
	else:
		velocidad.x =lerp(velocidad.x,0,0.1)
	
	velocidad = move_and_slide(velocidad,up)
	
	
	#Codigo de la roca que se mueve
	for i in get_slide_count():
		var colision = get_slide_collision(i)
		if colision.get_collider() is RigidBody2D:
			colision.get_collider().apply_central_impulse(-colision.normal * fuerza_empuje)

func add_Coin():

	var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true, false);
	canvasLayer.handleCoinCollected()



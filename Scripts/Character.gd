extends CharacterBody2D

var speed : float = 50.0
var acceleration : float = 0.2  # Fator de suavização
var z = 5
var move_direction = Vector2.ZERO

#Swing -------------
var timePassed = 0.0
var swingingSpeed = 5

# Referência direta ao AnimatedSprite2D (ajuste o nome conforme sua cena)
@onready var drawSelf = getDraw()

# No script do player (opcional):
func _ready() -> void:
	drawSelf.z_index = z
	
func _process(delta: float) -> void:
	if move_direction.length() > 0.1:  # Threshold para considerar movimento
		swing(delta)
		drawSelfDir()
	else:
		stop()
		
func drawSelfDir():
	if abs(move_direction.x) > abs(move_direction.y):
		runRight()
		drawSelf.flip_h = move_direction.x < 0  # Flip apenas no X
	else:
		if move_direction.y < 0:
			runUp()  # Animação para cima
		else: 
			runDown()

func runRight():
	pass
	
func runUp():
	pass
	
func runDown():
	pass

func _physics_process(delta):
	move_direction = defDirection()
	velocity = velocity.lerp(move_direction * speed, acceleration)
	move_and_slide()
	# Controle de drawSelfmação melhorado

func defDirection () -> Vector2:
	return Vector2.ZERO
	
func getDraw () -> AnimatedSprite2D:
	return $drawSelf

func stop():
	pass
	
func swing (delta : float):
	timePassed += delta * swingingSpeed  # Velocidade do balanço
	var angle := sin(timePassed) * 8.0  # Oscila entre -10 e +10 graus
	drawSelf.rotation_degrees = angle

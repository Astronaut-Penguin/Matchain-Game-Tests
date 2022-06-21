extends Area2D

export var speed = 400
var screen_size # size of the game window
signal contact
onready var body = get_parent().get_node("NPC1")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.play()
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	# If the velocity its a value, then walk |& flip
	if velocity.x != 0:
		$AnimatedSprite.animation = "Walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		#The idle animation will be displayed when no movement its detected
		$AnimatedSprite.animation = "Idle"
	
	# Clamp the player position to the screen
	position += velocity * delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	if(overlaps_body(body)):
		if Input.is_action_pressed("interact"):
			emit_signal("contact")

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


extends KinematicBody2D



export var id = 0
#0 = rock
#1 = paper
#2 = scissors



export var speed = 1
var dir = Vector2(0,0)


var rng = RandomNumberGenerator.new()
export var rand = 0.05


func _ready():
	#generate random number
	rng.randomize()
	
	self.set_position(Vector2(rng.randf_range(64.0, 960.0), rng.randf_range(64.0, 540.0)))
	
	
	var pointing = rng.randf_range(-90.0, 90.0)
	id = int(rng.randf_range(0.0, 3.0))
	dir = Vector2(sin(pointing), cos(pointing))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rng.randomize()
	
	var changex = rng.randf_range(-rand, rand)
	dir.x+=changex
	var changey = rng.randf_range(-rand, rand)
	dir.y+=changey
	_updateSprite()
	
	var collision = move_and_collide(dir*speed)
	if collision:
		var n = collision.normal
		
		if not (collision.collider.name) == "TileMap":
			
			if (collision.collider.id - id == 1) or (collision.collider.id - id == -2):
				id = collision.collider.id
				dir = collision.collider.dir
			#if (collision.collider.id - id == -1) or (collision.collider.id - id == 2):
				#collision.collider.id = id
				#collision.collider.dir = dir
		dir = dir.bounce(n)
			
		
	else:
		pass

func _updateSprite():
	
	if id == 0:
		$Rock.visible = true
		$Paper.visible = false
		$Scissors.visible = false
	if id == 1:
		$Rock.visible = false
		$Paper.visible = true
		$Scissors.visible = false
	if id == 2:
		$Rock.visible = false
		$Paper.visible = false
		$Scissors.visible = true
	


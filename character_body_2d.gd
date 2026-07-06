extends CharacterBody2D

var enemy_script = preload("res://enemy.gd")
var enemy_texture = preload("res://Doraemon_character.png.webp")

@export var SPEED : float = 300.0

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	# ให้ตัวละครหลักอยู่เลเยอร์หน้าสุด จะได้ไม่โดนศัตรูเดินบังมิด
	self.z_index = 1

func _physics_process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		animated_sprite.play("walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		animated_sprite.play("idle")

	move_and_slide()

# ฟังก์ชันรีสตาร์ทเกมเมื่อตาย (ตัวละครหลักเป็นคนเก็บฟังก์ชันนี้ไว้)
func die():
	get_tree().reload_current_scene()

# ฟังก์ชันเสกศัตรู
func _on_timer_timeout() -> void:
	var new_enemy = CharacterBody2D.new()
	new_enemy.set_script(enemy_script)
	
	var sprite = Sprite2D.new()
	sprite.texture = enemy_texture
	new_enemy.add_child(sprite)
	
	# สร้างระบบ Area2D ตรวจจับชนตายแบบทะลุฟิสิกส์
	var hit_zone = Area2D.new()
	var collision_shape = CollisionShape2D.new()
	var circle = CircleShape2D.new()
	circle.radius = 40 
	collision_shape.shape = circle
	
	hit_zone.add_child(collision_shape)
	new_enemy.add_child(hit_zone)
	
	# ถ้าสิ่งที่มาแตะโดนตัวศัตรู มีฟังก์ชันชื่อ die (ซึ่งก็คือตัวหลัก) ให้สั่งตายทันที
	hit_zone.body_entered.connect(func(body):
		if body.has_method("die"):
			body.die()
	)
	
	# ตั้งพิกัดขอบขวานอกจอ
	var screen_width = 1152
	var screen_height = 648
	var spawn_x = screen_width + 80
	var random_y = randf_range(50, screen_height - 50)
	new_enemy.position = Vector2(spawn_x, random_y)
	
	# สุ่มขนาดต่างกันนิดๆ 
	var random_scale = randf_range(0.8, 1.2) 
	new_enemy.scale = Vector2(random_scale, random_scale)
	
	get_parent().add_child(new_enemy)

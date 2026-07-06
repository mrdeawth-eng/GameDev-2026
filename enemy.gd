extends CharacterBody2D

@export var SPEED = 150.0 # ความเร็วตอนเดินมาทางซ้าย

func _ready():
	# ฝั่งศัตรูไม่ต้องสั่งเล่นแอนิเมชันอะไรทั้งนั้น ปล่อยว่างไว้แบบนี้เกมจะไม่พัง
	pass 

func _physics_process(delta):
	# เดินไปทางซ้ายอย่างเดียว (ค่า X เป็นติดลบ)
	velocity.x = -SPEED
	velocity.y = 0
	
	move_and_slide()

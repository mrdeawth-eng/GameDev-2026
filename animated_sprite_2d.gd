extends CharacterBody2D

@export var SPEED = 300.0

func _physics_process(delta):
	# 1. ดึงค่าทิศทางจากการกดปุ่ม (จะคืนค่าเป็น Vector2 ที่มีค่าระหว่าง -1 ถึง 1)
	# ใส่ชื่อ Action ให้ตรงกับใน Input Map (ตัวพิมพ์เล็ก-ใหญ่มีผล)
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	# 2. ถ้ามีการกดปุ่ม ให้คำนวณความเร็วตามทิศทาง
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		# ถ้าไม่ได้กดปุ่ม ให้ค่อยๆ หยุดเดิน (หรือจะตั้งเป็น velocity = Vector2.ZERO เลยก็ได้)
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	# 3. สั่งให้ตัวละครเคลื่อนที่และคำนวณการชน
	move_and_slide()

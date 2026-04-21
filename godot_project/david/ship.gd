extends CharacterBody2D
class_name Ship


@export var has_pathfinder: bool = true
@export var goal_is_right: bool = false
@export var goal_is_left: bool = false
@export var not_visible_on_radar: bool = false
@export var should_not_cross_boats: bool = false
@export var cross_radius = 50

@export var is_green_boat = false

@export var goals: Array[Node2D]
@export var goal_wait_time := 4.0
@export var maxSpeed: float = 10.0
@export var acceleration: float = 900.0
@export var arriveDistance: float = 4.0
@export var waypointAdvance: float = 80.0
@export var rotationSmooth: float = 8.0
@export var lookAheadDistance: float = 20.0
@export var maxRotationSpeed: float = 100.0
@export var collisionLookAhead: float = 40.0
@export var collisionYieldTime: float = 0.5

@onready var label = $Label

var goal = null
@onready var id = name
var goal_index := 0
var path = []
var pathIndex := 0
var desiredDir := Vector2.RIGHT
var facing := Vector2.RIGHT
var started := false
var is_waiting := false
var is_yielding := false
var crashed = false

# Order system
var order_goal = null
var has_order := false

var success = false

var current_timer_id = 0
func wait_time(time: float):
	var new_id = current_timer_id + 1
	current_timer_id = new_id
	await get_tree().create_timer(time).timeout
	return current_timer_id == new_id # no new timer
		

func check_crossed_boat() -> bool:
	var ships = get_parent().get_children()
	for other in ships:
		if other == self or not other is Ship:
			continue
		if other.global_position.distance_to(global_position) < cross_radius:
			return true
	return false

func _parent_scale() -> Vector2:
	if get_parent():
		return get_parent().global_scale.abs()
	return Vector2.ONE

func send_order(direction: Vector2):
	# Cancel any current wait so we respond immediately
	is_waiting = false
	is_yielding = false
	
	if direction == Vector2.ZERO:
		is_waiting = true
		if not await wait_time(10):
			return
		is_waiting = false
		return
	order_goal = global_position + direction * 150
	has_order = true
	request_path()
	

func clear_order():
	order_goal = null
	has_order = false

func reset_goal():
	clear_order()
	if goal:
		request_path()
	else:
		update_goal()

func get_goal_position() -> Vector2:
	if has_order:
		if order_goal is Node2D:
			return order_goal.global_position
		return order_goal
	if goal is Node2D:
		return goal.global_position
	return goal

func wait_at_goal():
	if is_waiting:
		return
	is_waiting = true
	await wait_time(goal_wait_time)
	is_waiting = false
	
	if has_order:
		reset_goal()
	else:
		update_goal()

func yield_to_ship():
	if is_yielding:
		return
	is_yielding = true
	if not await wait_time(collisionYieldTime):
		return
	is_yielding = false

func get_collision_radius() -> float:
	return $CollisionShape2D.shape.radius

func check_incoming_collision() -> bool:
	if id == null:
		return false
	var ships = get_parent().get_children()
	for other in ships:
		if other == self or not other is Ship:
			continue
		if other.id == null or (other.id < id and other.has_pathfinder):
			continue
		var to_other = other.global_position - global_position
		var dist = to_other.length()
		var combined_radius = get_collision_radius() + other.get_collision_radius()
		var trigger_dist = combined_radius + collisionLookAhead
		if dist > trigger_dist:
			continue
		var dot = facing.dot(to_other.normalized())
		if dot < 0.3:
			continue
		var closing = (velocity - other.velocity).dot(to_other.normalized())
		if closing > 0:
			return true
	return false

func set_path(p):
	path = p
	pathIndex = 0
	Global.pathfinder.draw_path(id, path)

func update_goal():
	if goal_index < len(goals):
		goal = goals[goal_index]
		goal_index += 1
	else:
		goal = null
		started = false
		set_success()
	if goal:
		request_path()

func advance_waypoint():
	if pathIndex < path.size():
		if path[pathIndex].distance_to(global_position) < waypointAdvance:
			pathIndex += 1

func get_lookahead_target() -> Vector2:
	if path.is_empty():
		return global_position
	var remaining := lookAheadDistance
	var lastPoint := global_position
	for i in range(pathIndex, path.size()):
		var nextPoint: Vector2 = path[i]
		var segLen := lastPoint.distance_to(nextPoint)
		if segLen >= remaining:
			return lastPoint + (nextPoint - lastPoint).normalized() * remaining
		remaining -= segLen
		lastPoint = nextPoint
	return path.back()

func request_path():
	if get_goal_position() == null:
		return
	if has_order:
		var intermediate_path = []
		for i in range(1, 5):
			var weight = i / 4.0
			var point = global_position.lerp(order_goal, weight)
			intermediate_path.append(point)
		
		set_path(intermediate_path)
	elif has_pathfinder:
		set_path(Global.pathfinder.compute_path(self , get_goal_position()))
	else:
		var intermediate_path = []
		for i in range(1, 5):
			var weight = i / 4.0
			var point = global_position.lerp(get_goal_position(), weight)
			intermediate_path.append(point)
			set_path(intermediate_path)

func _ready():
	desiredDir = Vector2.RIGHT
	facing = Vector2.RIGHT
	label.text = self.name
	$CollisionShape2D.disabled = true
	add_to_group("ships")

func start():
	started = true
	modulate = Color("0093d1")
	update_goal()
	$CollisionShape2D.disabled = false

func verify_position():
	if not has_pathfinder:
		if (goal_is_right and global_position.x > 370) or (goal_is_left and global_position.x < 370):
			has_pathfinder = true
			reset_goal()
			return
			
	var should_crash = Global.pathfinder.is_position_obstacle(global_position)
	if should_crash:
		crash()

func crash():
	crashed = true
	started = false
	path = []
	modulate = Color("e30000")
	print("crash")
	Global.night.show_retry()

func _physics_process(delta):
	if not started or is_waiting or success:
		return
		
	verify_position()
	
	if should_not_cross_boats and check_crossed_boat():
		crash()
		return
		
	if has_order and has_pathfinder:
		var look_pos = global_position + facing * collisionLookAhead
		if Global.pathfinder.is_position_obstacle(look_pos) or check_incoming_collision():
			clear_order()
			if goal:
				request_path()
			else:
				update_goal()

	advance_waypoint()
	if path.is_empty():
		wait_at_goal()
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
		move_and_slide()
		return

	var target := get_lookahead_target()
	var toTarget := target - global_position
	if toTarget.length() < arriveDistance:
		wait_at_goal()
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
		move_and_slide()
		return

	if check_incoming_collision():
		yield_to_ship()

	var ps := _parent_scale()
	var speed := velocity.length() * ps.x
	var target_speed := 0.0 if is_yielding else maxSpeed
	speed = move_toward(speed, target_speed, acceleration * delta)

	if not is_yielding:
		var targetAngle := toTarget.angle()
		var currentAngle := facing.angle()
		var angleDiff := wrapf(targetAngle - currentAngle, -PI, PI)
		var clampedDiff = clamp(angleDiff, -maxRotationSpeed * delta, maxRotationSpeed * delta)
		facing = Vector2(cos(currentAngle + clampedDiff), sin(currentAngle + clampedDiff))

	velocity = facing * speed / ps.x

	var coll := move_and_slide()
	if coll:
		crash()

	$Circle.rotation = facing.angle()
	request_path()

	if not crashed and position.length() > 320:
		if goal_is_right and global_position.x > 500:
			set_success()
		elif goal_is_left and global_position.x < 240:
			set_success()
		else:
			reset_goal()
		
func set_success():
	if crashed:
		success = false
		return
	success = true
	$CollisionShape2D.disabled = true
	modulate = Color("328e00ff")
	

func accelerate():
	if maxSpeed < 80:
		maxSpeed += 20
	
func decelerate():
	if maxSpeed > 20:
		maxSpeed -= 20

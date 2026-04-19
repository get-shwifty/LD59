extends CharacterBody2D
@export var goal: Node2D
@export var maxSpeed: float = 120.0
@export var acceleration: float = 900.0
@export var arriveDistance: float = 40.0
@export var waypointAdvance: float = 80.0
@export var rotationSmooth: float = 8.0
@export var lookAheadDistance: float = 200.0
@export var maxRotationSpeed: float = 4.0
var path = []
var pathIndex := 0
var desiredDir := Vector2.RIGHT
var follow_path = true
var follow_signal = false

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			follow_signal = true
			set_path([global_position + (Vector2.DOWN) * 300])
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			follow_signal = true
			set_path([global_position + (Vector2.UP) * 300])

func set_path(p):
	path = p
	pathIndex = 0
	print("set path")

func current_target() -> Vector2:
	if pathIndex >= path.size():
		return global_position
	return path[pathIndex]

func advance_waypoint():
	if pathIndex < path.size():
		var toWaypoint = path[pathIndex] - global_position
		if toWaypoint.length() < waypointAdvance:
			pathIndex += 1

func get_lookahead_target() -> Vector2:
	if path.is_empty():
		return global_position
	var remaining = lookAheadDistance
	var lastPoint = global_position
	for i in range(pathIndex, path.size()):
		var nextPoint = path[i]
		var segmentLength = lastPoint.distance_to(nextPoint)
		if segmentLength >= remaining:
			var dir = (nextPoint - lastPoint).normalized()
			return lastPoint + dir * remaining
		remaining -= segmentLength
		lastPoint = nextPoint
	return path.back()

func _ready():
	desiredDir = Vector2.RIGHT
	set_path(Pathfinder.map.find_path_global(global_position, goal.global_position))

func _physics_process(delta):
	advance_waypoint()

	if path.is_empty():
		if follow_signal:
			follow_signal = false
			set_path(Pathfinder.map.find_path_global(global_position, goal.global_position))
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
		move_and_slide()
		return

	var target = get_lookahead_target()
	var toTarget = target - global_position

	if toTarget.length() < arriveDistance and pathIndex >= path.size() - 1:
		if follow_signal:
			follow_signal = false
			set_path(Pathfinder.map.find_path_global(global_position, goal.global_position))
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
		move_and_slide()
		return

	var targetAngle = toTarget.angle()
	var currentAngle = desiredDir.angle()
	var angleDiff = wrapf(targetAngle - currentAngle, -PI, PI)
	var maxDelta = maxRotationSpeed * delta
	var clampedDiff = clamp(angleDiff, -maxDelta, maxDelta)
	var newAngle = currentAngle + clampedDiff
	desiredDir = Vector2(cos(newAngle), sin(newAngle))
	rotation = newAngle

	var speed = velocity.length()
	speed = move_toward(speed, maxSpeed, acceleration * delta)
	velocity = desiredDir * speed
	move_and_slide()

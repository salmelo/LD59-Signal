extends Node

const hex_size := 50.0
const horiz_spacing := 3/2.0 * hex_size
const vert_spacing := sqrt(3) * hex_size

const up :=  Vector2i(0,-1)
const up_left := Vector2i(-1,0)
const up_right := Vector2i(+1, -1)
const down_left := Vector2i(-1,+1)
const down_right := Vector2i(+1, 0)
const down := Vector2i(0, +1)

const q_basis := Vector2(3/2.0, sqrt(3) / 2.0)
const r_basis := Vector2(0, sqrt(3))

func to_world_space(hex : Vector2i) -> Vector2:
	return (q_basis * hex.x + r_basis * hex.y) * hex_size

func offset_to_hex(col : int, row : int) -> Vector2i:
	var parity = col & 1
	var q = col
	@warning_ignore("integer_division")
	var r = row - (col - parity) / 2
	return Vector2i(q,r)

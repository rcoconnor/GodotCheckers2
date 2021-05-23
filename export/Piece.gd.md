<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Piece.gd

**Extends:** [Node2D](../Node2D)

## Description

## Constants Descriptions

### BoardFunctions

```gdscript
const BoardFunctions: GDScript = preload("res://src/BitboardFunctions.gd")
```

const Bitboard = prelead("res://src/Bitboard.gd")

### SPRITE\_SIZE

```gdscript
const SPRITE_SIZE: int = 32
```

## Property Descriptions

### mouse\_is\_over\_collider

```gdscript
var mouse_is_over_collider
```

### is\_target

```gdscript
var is_target
```

### old\_pos

```gdscript
var old_pos
```

### bitboardFunctions

```gdscript
var bitboardFunctions
```

### rank

```gdscript
var rank
```

### file

```gdscript
var file
```

### piece\_index

```gdscript
var piece_index
```

the index of the square within the PIECE_TABLE dictionary

### speed

```gdscript
export var speed = 500
```

## Method Descriptions

### set\_file

```gdscript
func set_file(new_file)
```

### set\_rank

```gdscript
func set_rank(new_rank)
```

### set\_new\_global\_pos

```gdscript
func set_new_global_pos(new_pos)
```

### compute\_is\_valid\_move

```gdscript
func compute_is_valid_move(_new_rank, _new_file, _own_side_bitboard, _enemy_bitboard)
```

returns whether or not a given move is legal from the current position
new_rank: the rank of where we are moving
new_file: the file of where we are moving
own_side_bitboard: the map of all allied pieces
enemy_bitboard: the map of all enemies

### get\_valid\_moves

```gdscript
func get_valid_moves(_dark_pieces_bitboard, _light_pieces_bitboard)
```

virtual method to be implemented by subclass

### compute\_piece\_valid\_moves

```gdscript
func compute_piece_valid_moves(_new_rank, _new_file, _own_side_bitboard)
```

### get\_rank

```gdscript
func get_rank()
```

### get\_file

```gdscript
func get_file()
```

## Signals

- signal piece_selected(piece): 

<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# PieceManager.gd

**Extends:** [Node2D](../Node2D)

## Description

## Constants Descriptions

### Bitboard

```gdscript
const Bitboard: Bitboard = preload("res://src/Bitboard.gd")
```

### BoardFunctions

```gdscript
const BoardFunctions: GDScript = preload("res://src/BitboardFunctions.gd")
```

### SPRITE\_SIZE

```gdscript
const SPRITE_SIZE: int = 32
```

important constants

## Property Descriptions

### board\_functions

```gdscript
var board_functions
```

### LightPiece

```gdscript
export var LightPiece = "[Object:null]"
```

### DarkPiece

```gdscript
export var DarkPiece = "[Object:null]"
```

### dark\_piece\_state

```gdscript
var dark_piece_state
```

### light\_piece\_state

```gdscript
var light_piece_state
```

### pieces\_array

```gdscript
var pieces_array
```

Member variables

## Method Descriptions

### move\_pieces

```gdscript
func move_pieces(from_rank, from_file, to_rank, to_file, is_white_piece)
```

### clear\_board

```gdscript
func clear_board()
```

clears the board

### refresh\_board

```gdscript
func refresh_board()
```

### instance\_pieces

```gdscript
func instance_pieces(node_to_instance, state)
```

### set\_dark\_piece\_state

```gdscript
func set_dark_piece_state(new_state)
```

### get\_dark\_piece\_state

```gdscript
func get_dark_piece_state()
```

### set\_light\_piece\_state

```gdscript
func set_light_piece_state(new_state)
```

### get\_light\_piece\_state

```gdscript
func get_light_piece_state()
```

## Signals

- signal refreshed_screen(): 

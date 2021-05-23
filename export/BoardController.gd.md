<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# BoardController.gd

**Extends:** [Node2D](../Node2D)

## Description

## Constants Descriptions

### BoardFunctions

```gdscript
const BoardFunctions: GDScript = preload("res://src/BitboardFunctions.gd")
```

const Bitboard = preload("res://src/Bitboard.gd")

### ClickableSprite

```gdscript
const ClickableSprite: ClickableSprite = preload("res://src/ClickableSprite.gd")
```

### DarkPiece

```gdscript
const DarkPiece: GDScript = preload("res://src/DarkPiece.gd")
```

### LightPiece

```gdscript
const LightPiece: GDScript = preload("res://src/LightPiece.gd")
```

### Lookup

```gdscript
const Lookup: GDScript = preload("res://src/LookupTables.gd")
```

### Piece

```gdscript
const Piece: GDScript = preload("res://src/Piece.gd")
```

## Property Descriptions

### HighLightSquare

```gdscript
export var HighLightSquare = "[Object:null]"
```

### target\_piece

```gdscript
var target_piece
```

### has\_target

```gdscript
var has_target
```

### original\_pos

```gdscript
var original_pos
```

### should\_move

```gdscript
var should_move
```

### board\_functions

```gdscript
var board_functions
```

### index

```gdscript
var index
```

## Method Descriptions

### select\_piece\_received

```gdscript
func select_piece_received(node)
```

called when a piece has been selected
node: the node of the piece which has been selected

### selected\_signal\_received

```gdscript
func selected_signal_received(square_rank, square_file)
```

called when a square has been clicked, if there is a target piece and the
selected square is a valid move, this method will update the board
accordingly
square_rank: the rank of the square which has been selected
square_file: the file of the square which has been selected

### highlight\_valid\_moves

```gdscript
func highlight_valid_moves()
```

### clear\_valid\_moves

```gdscript
func clear_valid_moves()
```


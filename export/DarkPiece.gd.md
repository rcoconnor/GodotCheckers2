<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# DarkPiece.gd

## Method Descriptions

### compute\_is\_valid\_move

```gdscript
func compute_is_valid_move(new_rank, new_file, dark_pieces_bitboard, light_pieces_bitboard)
```

### get\_valid\_moves

```gdscript
func get_valid_moves(dark_pieces_bitboard, light_pieces_bitboard)
```

Public Inherited method, returns all valid moves

### compute\_dark\_piece\_valid\_moves

```gdscript
func compute_dark_piece_valid_moves(own_side_bitboard, enemy_bitboard)
```

uses a series of logical operations in order to find the valid moves
returns: a bitboard containing the valid moves

### handle\_jumping

```gdscript
func handle_jumping(pos_bitboard, enemy_bitboard)
```

# @method handle_jumping - calculates the valid jumps for a given position,
# returns a bitboard representing valid jumps the player can make
# @param pos_bitboard: Bitboard - the bitboard representing the position of the
# jumping piece
# @param enemy_bitboard: Bitboard - the bitboard representing the position of
# the enemy piece
# @returns a bitboard representing the valid jumps the player can do
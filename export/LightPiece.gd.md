<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# LightPiece.gd

## Method Descriptions

### compute\_is\_valid\_move

```gdscript
func compute_is_valid_move(new_rank, new_file, dark_pieces_bitboard, light_pieces_bitboard)
```

returns whether or not a given move is legal from the current position
new_rank: the rank of where we are moving
new_file: the file of where we are moving
own_side_bitboard: the map of all allied pieces
enemy_bitboard: the map of all enemies

### get\_valid\_moves

```gdscript
func get_valid_moves(dark_pieces_bitboard, light_pieces_bitboard)
```

### compute\_light\_piece\_valid\_moves

```gdscript
func compute_light_piece_valid_moves(own_side_bitboard, enemy_bitboard)
```

### handle\_jumping

```gdscript
func handle_jumping(pos_bitboard, own_side_bitboard, enemy_bitboard)
```


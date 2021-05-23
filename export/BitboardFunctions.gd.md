<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# BitboardFunctions.gd

**Extends:** [Reference](../Reference)

## Description

## Enumerations

### RANK

```gdscript
const RANK: Dictionary = {"RANK_1":0,"RANK_2":1,"RANK_3":2,"RANK_4":3,"RANK_5":4,"RANK_6":5,"RANK_7":6,"RANK_8":7}
```

### FILE

```gdscript
const FILE: Dictionary = {"FILE_A":0,"FILE_B":1,"FILE_C":2,"FILE_D":3,"FILE_E":4,"FILE_F":5,"FILE_G":6,"FILE_H":7}
```

## Constants Descriptions

### Bitboard

```gdscript
const Bitboard: Bitboard = preload("res://src/Bitboard.gd")
```

### CLEAR\_SIGN\_BIT

```gdscript
const CLEAR_SIGN_BIT: int = 9223372036854775807
```

## Property Descriptions

### CLEAR\_RANK

```gdscript
var CLEAR_RANK
```

### MASK\_RANK

```gdscript
var MASK_RANK
```

### CLEAR\_FILE

```gdscript
var CLEAR_FILE
```

### MASK\_FILE

```gdscript
var MASK_FILE
```

### PIECE\_TABLE

```gdscript
var PIECE_TABLE
```

## Method Descriptions

### create\_mask\_rank

```gdscript
func create_mask_rank()
```

### create\_clear\_file

```gdscript
func create_clear_file()
```

### create\_mask\_file

```gdscript
func create_mask_file()
```

### create\_clear\_rank

```gdscript
func create_clear_rank()
```

### create\_piece\_table

```gdscript
func create_piece_table()
```

### multiple\_shift\_right <small>(static)</small>

```gdscript
func multiple_shift_right(board, num_times)
```

returns a copy of board shifted num_times times

### multiple\_shift\_left <small>(static)</small>

```gdscript
func multiple_shift_left(board, num_times)
```

### LOGICAL\_OR <small>(static)</small>

```gdscript
func LOGICAL_OR(first_bitboard, second_bitboard)
```

### LOGICAL\_AND <small>(static)</small>

```gdscript
func LOGICAL_AND(first_bitboard, second_bitboard)
```

### LOGICAL\_NOT <small>(static)</small>

```gdscript
func LOGICAL_NOT(bitboard)
```

### copy\_bitboard <small>(static)</small>

```gdscript
func copy_bitboard(board_to_copy)
```


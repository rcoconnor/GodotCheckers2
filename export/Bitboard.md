<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Bitboard

**Extends:** [Reference](../Reference)

## Description

## Constants Descriptions

### CLEAR\_SIGN\_BIT

```gdscript
const CLEAR_SIGN_BIT: int = 9223372036854775807
```

clears the sign bit of a 64-bit integer

### MS\_HALF\_BYTE\_CLEAR

```gdscript
const MS_HALF_BYTE_CLEAR: int = 72057594037927935
```

Clears the most significant four bits

### MS\_HALF\_BYTE\_MASK

```gdscript
const MS_HALF_BYTE_MASK: int = -1152921504606846976
```

we shift it over by one in order to ignore errors created by godot
equal to 0xF000000000000000

### STATE\_MSB\_CLEAR

```gdscript
const STATE_MSB_CLEAR: int = 4611686018427387903
```

### STATE\_MSB\_MASK

```gdscript
const STATE_MSB_MASK: int = 4611686018427387904
```

Masks all bit except for the MSB which we are using

## Property Descriptions

### msb

```gdscript
var msb
```

### board\_state

```gdscript
var board_state
```

## Method Descriptions

### shift\_right

```gdscript
func shift_right()
```

### shift\_left

```gdscript
func shift_left()
```

### set\_state

```gdscript
func set_state(new_msb, new_state)
```

sets the state
  new_msb: boolean representing the msb
  new_state: 63 bit number representing the baord state

### convert\_bits\_to\_string

```gdscript
func convert_bits_to_string(half_byte)
```

### to\_string

```gdscript
func to_string()
```

### convert\_num\_to\_hex\_string

```gdscript
func convert_num_to_hex_string(num)
```

### get\_lsb

```gdscript
func get_lsb()
```

### get\_msb

```gdscript
func get_msb()
```

### get\_board\_state

```gdscript
func get_board_state()
```


class_name Bitboard

extends Reference

# Bitboard class 
# This class emeultes the behaviour of an unsigned 64-bit integer in order to 
# represent the board state.  This class will always clear the sign bit of board_state, and instead represent it as a board state 

# clears the sign bit of a 64-bit integer
const CLEAR_SIGN_BIT = 0x7FFFFFFFFFFFFFFF

# 

# Masks all bit except for the MSB which we are using 
const STATE_MSB_MASK  = 0x4000000000000000
const STATE_MSB_CLEAR = 0x3fffffffffffffff

# Clears the most significant four bits 
const MS_HALF_BYTE_CLEAR = 0x0FFFFFFFFFFFFFF

# we shift it over by one in order to ignore errors created by godot
const MS_HALF_BYTE_MASK  = ( 0x7800000000000000 ) << 1 # equal to 0xF000000000000000


var msb = false
var board_state = 0x0000000000000000

func _ready(): 
    board_state = 0x0000000000000

func _update(_delta): 
    pass


func shift_right():
    board_state = ( board_state >> 1 ) & CLEAR_SIGN_BIT
    if (msb): 
        # set the state MSB (i.e. the 63rd bit)
        board_state = board_state | STATE_MSB_MASK
        msb = false
    else: # we should clear the 63rd bit 
        board_state = board_state & STATE_MSB_CLEAR

func shift_left():
    # Find the MSB of state_msb
    var state_msb = board_state & STATE_MSB_MASK
    # check if the bit will overflow 
    if ( ( state_msb >> 62 ) == 1 ): 
        # if we will overflow
        msb = true
    board_state = ( board_state << 1 ) & CLEAR_SIGN_BIT

# sets the state
#   new_msb: boolean representing the msb
#   new_state: 63 bit number representing the baord state
func set_state(new_msb, new_state):
    msb = new_msb
    board_state = ( new_state & CLEAR_SIGN_BIT ) # ensure that the sign bit is not set

func convert_bits_to_string(half_byte): 
    if(half_byte == 0):  return "0"
    if(half_byte == 1):  return "1"
    if(half_byte == 2):  return "2"
    if(half_byte == 3):  return "3"
    if(half_byte == 4):  return "4"
    if(half_byte == 5):  return "5"
    if(half_byte == 6):  return "6"
    if(half_byte == 7):  return "7"
    if(half_byte == 8):  return "8"
    if(half_byte == 9):  return "9"
    if(half_byte == 10): return "a"
    if(half_byte == 11): return "b"
    if(half_byte == 12): return "c"
    if(half_byte == 13): return "d"
    if(half_byte == 14): return "e"
    if(half_byte == 15): return "f"

func to_string(): 
    var string_to_return = ""
    # get the most significant byte (remember, we are not using the 64th bit!)
    var first_byte = (board_state & MS_HALF_BYTE_MASK & CLEAR_SIGN_BIT) >> 60
    if (msb): first_byte += 8
    string_to_return += convert_bits_to_string(first_byte)

    string_to_return += "%015x" % ( board_state & 0x0FFFFFFFFFFFFFFF )
    return string_to_return


func convert_num_to_hex_string(num):
    var string_to_return = "%016x" % num
    return string_to_return 


func get_lsb(): 
    return board_state & 1

func get_msb(): 
    return msb

func get_board_state(): 
    return board_state


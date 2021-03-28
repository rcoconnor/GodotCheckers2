extends Reference



var CLEAR_SIGN_BIT = 0x7FFFFFFFFFFFFFFF
var STATE_MSB_MASK = 0x4000000000000000

var MS_HALF_BYTE_CLEAR = 0x0FFFFFFFFFFFFFF
var MS_HALF_BYTE_MASK  = 0xF000000000000000


var msb = false
var board_state = 0x0000000000000000

func _ready(): 
	board_state = 0x0000000000000

func _update(_delta): 
	pass

func shift_left():
    #print("shift left called")

    # Find the MSB of state_msb
    var state_msb = board_state & STATE_MSB_MASK
    #print("msb mask   : %016x" % STATE_MSB_MASK)
    #print("board state: %016x" % board_state)
    #print("state_msb  : %016x" % state_msb)
    # check if the bit will overflow 
    if ( ( state_msb >> 62 ) == 1 ): 
        # if we will overflow
        msb = true
    board_state = ( board_state << 1 ) & CLEAR_SIGN_BIT
    #print("int cast: ", int(msb))
    #print("initshift  : ", "%015x" % board_state)
    #print("final shift: ", to_string())

# sets the state 
func set_state(new_msb, new_state):
    msb = new_msb
    board_state = new_state

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
    # get the most significant byte 
    var first_byte = (board_state & MS_HALF_BYTE_MASK & CLEAR_SIGN_BIT) >> 60
    #print(" original: %016x" % board_state)
    if (msb): first_byte += 8
    string_to_return += convert_bits_to_string(first_byte)

    string_to_return += "%015x" % ( board_state & 0x0FFFFFFFFFFFFFFF )
    return string_to_return

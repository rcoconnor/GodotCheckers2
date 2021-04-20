extends Reference

const Bitboard = preload("res://src/Bitboard.gd")

# Bitboard Functions Class
# This class implements static helper functions for the Bitboard class

enum RANK { RANK_1 = 0, RANK_2 = 1,RANK_3 = 2, RANK_4 = 3, RANK_5 = 4, RANK_6 = 5, RANK_7 = 6, RANK_8 = 7}
enum FILE { FILE_A, FILE_B, FILE_C, FILE_D, FILE_E, FILE_F, FILE_G, FILE_H }



var CLEAR_RANK = {}
var MASK_RANK = {}
var CLEAR_FILE = {}
var MASK_FILE = {}
var PIECE_TABLE = {}

func create_mask_rank(): 
    MASK_RANK[ RANK.RANK_1 ] = Bitboard.new()
    MASK_RANK[ RANK.RANK_1 ].set_state(false, 0x00000000000000FF)
    MASK_RANK[ RANK.RANK_2 ] = Bitboard.new()
    MASK_RANK[ RANK.RANK_2 ].set_state(false, 0x000000000000ff00)
    MASK_RANK[ RANK.RANK_3 ] = Bitboard.new()
    MASK_RANK[ RANK.RANK_3 ].set_state(false, 0x0000000000ff0000)
    MASK_RANK[ RANK.RANK_4 ] = Bitboard.new()
    MASK_RANK[ RANK.RANK_4 ].set_state(false, 0x00000000ff000000)
    MASK_RANK[ RANK.RANK_5 ] = Bitboard.new()
    MASK_RANK[ RANK.RANK_5 ].set_state(false, 0x000000ff00000000)
    MASK_RANK[ RANK.RANK_6 ] = Bitboard.new()
    MASK_RANK[ RANK.RANK_6 ].set_state(false, 0x0000ff0000000000)
    MASK_RANK[ RANK.RANK_7 ] = Bitboard.new()
    MASK_RANK[ RANK.RANK_7 ].set_state(false, 0x00ff000000000000)
    MASK_RANK[ RANK.RANK_8 ] = Bitboard.new()
    MASK_RANK[ RANK.RANK_8 ].set_state(true,  0x7f00000000000000)


func create_clear_file():
    CLEAR_FILE[ FILE.FILE_A ] = Bitboard.new()
    CLEAR_FILE[ FILE.FILE_A ].set_state(true,  0x7EFEFEFEFEFEFEFE)
    CLEAR_FILE[ FILE.FILE_B ] = Bitboard.new()
    CLEAR_FILE[ FILE.FILE_B ].set_state(true,  0x7DFDFDFDFDFDFDFD)
    CLEAR_FILE[ FILE.FILE_C ] = Bitboard.new()
    CLEAR_FILE[ FILE.FILE_C ].set_state(true,  0x7BFBFBFBFBFBFBFB)
    CLEAR_FILE[ FILE.FILE_D ] = Bitboard.new()
    CLEAR_FILE[ FILE.FILE_D ].set_state(true,  0x77F7F7F7F7F7F7F7)
    CLEAR_FILE[ FILE.FILE_E ] = Bitboard.new()
    CLEAR_FILE[ FILE.FILE_E ].set_state(true,  0x6FEFEFEFEFEFEFEF)
    CLEAR_FILE[ FILE.FILE_F ] = Bitboard.new()
    CLEAR_FILE[ FILE.FILE_F ].set_state(true,  0x5FDFDFDFDFDFDFDF)
    CLEAR_FILE[ FILE.FILE_G ] = Bitboard.new()
    CLEAR_FILE[ FILE.FILE_G ].set_state(true,  0x3FBFBFBFBFBFBFBF)
    CLEAR_FILE[ FILE.FILE_H ] = Bitboard.new()
    CLEAR_FILE[ FILE.FILE_H ].set_state(false, 0x7F7F7F7F7F7F7F7F)


func create_mask_file():
    MASK_FILE[ FILE.FILE_A ] = Bitboard.new()
    MASK_FILE[ FILE.FILE_A ].set_state(false, 0x0101010101010101)
    MASK_FILE[ FILE.FILE_B ] = Bitboard.new()
    MASK_FILE[ FILE.FILE_B ].set_state(false, 0x0202020202020202)
    MASK_FILE[ FILE.FILE_C ] = Bitboard.new()
    MASK_FILE[ FILE.FILE_C ].set_state(false, 0x0404040404040404)
    MASK_FILE[ FILE.FILE_D ] = Bitboard.new()
    MASK_FILE[ FILE.FILE_D ].set_state(false, 0x0808080808080808)
    MASK_FILE[ FILE.FILE_E ] = Bitboard.new()
    MASK_FILE[ FILE.FILE_E ].set_state(false, 0x1010101010101010)
    MASK_FILE[ FILE.FILE_F ] = Bitboard.new()
    MASK_FILE[ FILE.FILE_F ].set_state(false, 0x2020202020202020)
    MASK_FILE[ FILE.FILE_G ] = Bitboard.new()
    MASK_FILE[ FILE.FILE_G ].set_state(false, 0x4040404040404040)
    MASK_FILE[ FILE.FILE_H ] = Bitboard.new()
    MASK_FILE[ FILE.FILE_H ].set_state(true,  0x0080808080808080)


func create_clear_rank(): 
    var first = Bitboard.new()
    first.set_state(true, 0x7FFFFFFFFFFFFF00)
    CLEAR_RANK[RANK.RANK_1] = first
                                                       
    CLEAR_RANK[RANK.RANK_2] = Bitboard.new()
    CLEAR_RANK[RANK.RANK_2].set_state(true,  0x7FFFFFFFFFFF00FF)
   
    CLEAR_RANK[RANK.RANK_3] = Bitboard.new()
    CLEAR_RANK[RANK.RANK_3].set_state(true,  0x7FFFFFFFFF00FFFF)

    CLEAR_RANK[RANK.RANK_4] = Bitboard.new()
    CLEAR_RANK[RANK.RANK_4].set_state(true,  0x7FFFFFFF00FFFFFF)

    CLEAR_RANK[RANK.RANK_5] = Bitboard.new()
    CLEAR_RANK[RANK.RANK_5].set_state(true,  0x7FFFFF00FFFFFFFF)
   
    CLEAR_RANK[RANK.RANK_6] = Bitboard.new()
    CLEAR_RANK[RANK.RANK_6].set_state(true,  0x7FFF00FFFFFFFFFF)
    
    CLEAR_RANK[RANK.RANK_7] = Bitboard.new()
    CLEAR_RANK[RANK.RANK_7].set_state(true,  0x7F00FFFFFFFFFFFF)
    
    CLEAR_RANK[RANK.RANK_8] = Bitboard.new()
    CLEAR_RANK[RANK.RANK_8].set_state(false, 0x00FFFFFFFFFFFFFF)


func create_piece_table(): 
    var start_board = Bitboard.new()
    start_board.set_state(false, 1)
    for i in range(64): 
        var cur_board = multiple_shift_left(start_board, i)
        PIECE_TABLE[i] = cur_board


# returns a copy of board shifted num_times times 
static func multiple_shift_right(board, num_times): 
    var board_to_return = Bitboard.new()
    board_to_return.set_state(board.get_msb(), board.get_board_state())
    for _i in range(num_times): 
        board_to_return.shift_right()
    return board_to_return

static func multiple_shift_left(board, num_times): 
    var board_to_return = Bitboard.new()
    board_to_return.set_state(board.get_msb(), board.get_board_state())
    if num_times != 0: 
        for _i in range(num_times): 
            board_to_return.shift_left()
    return board_to_return



func _init(): 
    create_clear_rank()
    create_mask_rank()
    create_clear_file()
    create_mask_file()
    create_piece_table()

static func LOGICAL_OR(first_bitboard, second_bitboard): 
    var new_msb = first_bitboard.get_msb() || second_bitboard.get_msb()
    var new_state = first_bitboard.get_board_state() | second_bitboard.get_board_state()
    var new_board = Bitboard.new()
    new_board.set_state(new_msb, new_state)
    return new_board

static func LOGICAL_AND(first_bitboard, second_bitboard): 
    var new_msb = first_bitboard.get_msb() && second_bitboard.get_msb()
    var new_state = first_bitboard.get_board_state() & second_bitboard.get_board_state()
    var new_board = Bitboard.new()
    new_board.set_state(new_msb, new_state)
    return new_board



const CLEAR_SIGN_BIT = 0x7FFFFFFFFFFFFFFF

static func LOGICAL_NOT(bitboard): 
    var new_msb = ( !bitboard.get_msb() )
    var new_state = (( ~bitboard.get_board_state() ) & CLEAR_SIGN_BIT)
    #print("new state: %016x" % ( new_state  ))
    var new_board = Bitboard.new()
    new_board.set_state(new_msb, new_state)
    #print("    new board: ", new_board.to_string())
    return new_board

static func copy_bitboard(board_to_copy): 
    var board_to_return = Bitboard.new()
    var new_msb = board_to_copy.get_msb()
    var new_state = board_to_copy.get_board_state()
    board_to_return.set_state(new_msb, new_state)
    return board_to_return



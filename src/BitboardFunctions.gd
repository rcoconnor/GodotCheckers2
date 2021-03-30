extends Reference

const Bitboard = preload("res://src/Bitboard.gd")

# Bitboard Functions Class
# This class implements static helper functions for the Bitboard class

enum RANK { RANK_1, RANK_2, RANK_3, RANK_4, RANK_5, RANK_6, RANK_7, RANK_8 }
enum FILE { FILE_1, FILE_2, FILE_3, FILE_4, FILE_5, FILE_6, FILE_7, FILE_8 }

const CLEAR_RANK = {
    RANK.RANK_1: Bitboard.new().set_state(true,  0x7FFFFFFFFFFFFF00)
    RANK.RANK_2: Bitboard.new().set_state(true,  0x7FFFFFFFFFFF00FF)
    RANK.RANK_3: Bitboard.new().set_state(true,  0x7FFFFFFFFF00FFFF)
    RANK.RANK_4: Bitboard.new().set_state(true,  0x7FFFFFFF00FFFFFF)
    RANK.RANK_5: Bitboard.new().set_state(true,  0x7FFFFF00FFFFFFFF)
    RANK.RANK_6: Bitboard.new().set_state(true,  0x7FFF00FFFFFFFFFF)
    RANK.RANK_7: Bitboard.new().set_state(true,  0x7F00FFFFFFFFFFFF)
    RANK.RANK_8: Bitboard.new().set_state(false, 0x00FFFFFFFFFFFFFF)
} 

const MASK_RANK = {
    RANK.RANK_1: Bitboard.new().set_state(false, 0x00000000000000FF)
    RANK.RANK_2: Bitboard.new().set_state(false, 0x000000000000ff00)
    RANK.RANK_3: Bitboard.new().set_state(false, 0x0000000000ff0000)
    RANK.RANK_4: Bitboard.new().set_state(false, 0x00000000ff000000)
    RANK.RANK_5: Bitboard.new().set_state(false, 0x000000ff00000000)
    RANK.RANK_6: Bitboard.new().set_state(false, 0x0000ff0000000000)
    RANK.RANK_7: Bitboard.new().set_state(false, 0x00ff000000000000)
    RANK.RANK_8: Bitboard.new().set_state(true,  0x7f00000000000000)
}

const CLEAR_FILE = {
    FILE.FILE_1: Bitboard.new().set_state(true,  0x7EFEFEFEFEFEFEFE)
    FILE.FILE_2: Bitboard.new().set_state(true,  0x7DFDFDFDFDFDFDFD)
    FILE.FILE_3: Bitboard.new().set_state(true,  0x7BFBFBFBFBFBFBFB)
    FILE.FILE_4: Bitboard.new().set_state(true,  0x77F7F7F7F7F7F7F7)
    FILE.FILE_5: Bitboard.new().set_state(true,  0x6FEFEFEFEFEFEFEF)
    FILE.FILE_6: Bitboard.new().set_state(true,  0x5FDFDFDFDFDFDFDF)
    FILE.FILE_7: Bitboard.new().set_state(true,  0x3FBFBFBFBFBFBFBF)
    FILE.FILE_8: Bitboard.new().set_state(false, 0x7F7F7F7F7F7F7F7F)
}



const MASK_FILE = {
    FILE.FILE_1: Bitboard.new().set_state(false, 0x0101010101010101)
    FILE.FILE_2: Bitboard.new().set_state(false, 0x0202020202020202)
    FILE.FILE_3: Bitboard.new().set_state(false, 0x0404040404040404)
    FILE.FILE_4: Bitboard.new().set_state(false, 0x8080808080808080)
    FILE.FILE_5: Bitboard.new().set_state(false, 0x1010101010101010)
    FILE.FILE_6: Bitboard.new().set_state(false, 0x2020202020202020)
    FILE.FILE_7: Bitboard.new().set_state(false, 0x4040404040404040)
    FILE.FILE_8: Bitboard.new().set_state(true,  0x0080808080808080)
}


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


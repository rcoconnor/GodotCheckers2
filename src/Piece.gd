extends Node2D

#const Bitboard = prelead("res://src/Bitboard.gd")
const BoardFunctions = preload("res://src/BitboardFunctions.gd")

signal piece_selected(piece) 

const SPRITE_SIZE = 32

var mouse_is_over_collider = false
var is_target = false
var old_pos = Vector2()

var bitboardFunctions

var rank
var file
var piece_index # the index of the square within the PIECE_TABLE dictionary



# Called when the node enters the scene tree for the first time.
func _ready():
    rank = 0
    file = 0
    piece_index = 0
    bitboardFunctions = BoardFunctions.new()
    #print("pice_table: ", bitboardFunctions.PIECE_TABLE[27].to_string())

export(int) var speed = 500


func _process(_delta): 
    pass 



func set_file(new_file): 
    file = new_file
    var new_x = file * SPRITE_SIZE
    set_position(Vector2(new_x, position.y))
    piece_index = (8 * rank) + file


func set_rank(new_rank): 
    rank = new_rank
    var new_y = (7 - rank ) * SPRITE_SIZE
    piece_index = (8 * rank) + file
    set_position(Vector2(position.x, new_y))

func set_new_global_pos(new_pos):
    set_global_position(new_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
    pass
    #if (is_target):
        #var vec = get_viewport().get_mouse_position() #- self.position
        #vec = vec.normalized() * delta * speed
        #set_global_position(vec) 

# returns whether or not a given move is legal from the current position 
# new_rank: the rank of where we are moving 
# new_file: the file of where we are moving 
# own_side_bitboard: the map of all allied pieces 
# enemy_bitboard: the map of all enemies
func compute_is_valid_move(new_rank, new_file, own_side_bitboard, enemy_bitboard):
    # get the bitboard representation of the board the player would like to make
    print('EEEEEOORRRRRROOOOOORRRRRR THIS IS AN OVERLOADED FUNCTION THIS SHOULDNT BE CALLING')
    print("_enemy: ", enemy_bitboard)
    var new_index: int = (8 * new_rank) + new_file
    var shifted_piece_table = bitboardFunctions.PIECE_TABLE[new_index]
    #print("shifted: ", shifted_piece_table.to_string())
    
    # Get the valid moves from the targets current position 
    var valid_moves = compute_piece_valid_moves(new_rank, new_file, own_side_bitboard)
    #print('valid  : ', valid_moves.to_string())

    # Determine if the move is a valid move 
    var is_valid = BoardFunctions.multiple_shift_right(BoardFunctions.LOGICAL_AND(shifted_piece_table, valid_moves), new_index)
    #print("isvalid: ", is_valid.to_string())
    if is_valid.get_board_state() == 1 && is_valid.get_msb() == false: 
        return true 
    else: 
        return false

# virtual method to be implemented by subclass
func get_valid_moves(_dark_pieces_bitboard, _light_pieces_bitboard): 
    pass

func compute_piece_valid_moves(_new_rank, _new_file, own_side_bitboard): 
    print("COMPUTE_PIECE_VALID_MOVES SHOULD NOT BE CALLED")
    var piece_loc_bitboard = Bitboard.new()
    var new_msb = bitboardFunctions.PIECE_TABLE[piece_index].get_msb()
    var new_state = bitboardFunctions.PIECE_TABLE[piece_index].get_board_state()
    piece_loc_bitboard.set_state(new_msb, new_state)
#   print("piece_loc_bitboard: ", piece_loc_bitboard.to_string())
#   print("rank: ", rank)
#   print("file: ", file)
#   print("new_rank: ", new_rank)
#   print("new_file: ", new_file)
#   print("ownside: ", own_side_bitboard.to_string())
#   print("piece_index: ", piece_index)
    
    var piece_clip_file_h = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[7])
    var piece_clip_file_a = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[0])
    #print("clip h: ", piece_clip_file_h.to_string()) 
    var left_spot = BoardFunctions.multiple_shift_left(piece_clip_file_a, 7)
    #print("left  : ", left_spot.to_string()) 
    var right_spot = BoardFunctions.multiple_shift_left(piece_clip_file_h, 9)
    #print("right : ", right_spot.to_string())
    var possible_moves = BoardFunctions.LOGICAL_OR(left_spot, right_spot)
    #print("possib: ", possible_moves.to_string())
    var inverted_board = BoardFunctions.LOGICAL_NOT(own_side_bitboard)
    #print('inverted: ', inverted_board.to_string())
    var valid_moves = BoardFunctions.LOGICAL_AND(possible_moves, inverted_board)
    #print("valids: ", valid_moves.to_string())
    return valid_moves

func get_rank(): 
    return rank
    #return (position.x / SPRITE_SIZE)

func get_file():
    return file
#return (7 - (position.y / SPRITE_SIZE))

func _input(event): 
    if event.is_action_pressed("Left Click"):
        if mouse_is_over_collider:
            old_pos = position
            emit_signal("piece_selected", self)

func _on_mouse_entered(): 
    mouse_is_over_collider = true

func _on_mouse_exit(): 
    mouse_is_over_collider = false

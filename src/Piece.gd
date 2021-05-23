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
    var temp_val = (8 * rank)
    piece_index = temp_val + file

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
func compute_is_valid_move(_new_rank, _new_file, _own_side_bitboard, _enemy_bitboard):
    pass 


# virtual method to be implemented by subclass
func get_valid_moves(_dark_pieces_bitboard, _light_pieces_bitboard): 
    pass

func compute_piece_valid_moves(_new_rank, _new_file, _own_side_bitboard): 
    #print("COMPUTE_PIECE_VALID_MOVES SHOULD NOT BE CALLED")
    pass

# virtual method to be implemented by subclass
func get_left_move_piece_board(): 
    pass

# virtual method to be implemented by subclass
func get_right_move_piece_board(): 
    pass

func get_rank(): 
    return rank
    #return (position.x / SPRITE_SIZE)

func get_file():
    return file
#return (7 - (position.y / SPRITE_SIZE))

func get_is_white(): 
    # virtual function to be implemented by subclass
    pass 

func _input(event): 
    if event.is_action_pressed("Left Click"):
        if mouse_is_over_collider:
            old_pos = position
            emit_signal("piece_selected", self)

func _on_mouse_entered(): 
    mouse_is_over_collider = true

func _on_mouse_exit(): 
    mouse_is_over_collider = false

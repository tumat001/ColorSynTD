extends Node

signal before_round_starts(current_stageround)
signal round_started(current_stageround) # incomming/current round
signal after_round_started(current_stageround)  #no frames skipped, just last step

signal before_round_ends_game_start_aware(current_stageround, is_game_start)
signal round_ended_game_start_aware(current_stageround, is_game_start)
signal before_round_ends(current_stageround) # new incomming round
signal round_ended(current_stageround) # new incomming round

signal round_ended__for_aesth_purposes(arg_is_win, arg_steak_amount, arg_is_max_reached, arg_is_streak_broken, arg_is_streak_broken_magnitude_max)

##

var is_round_started


##



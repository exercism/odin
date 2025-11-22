package bowling

MAX_PINS :: 10
LAST_FRAME :: 9 // First Frame starts at 0 (not 1).
EXTRA_FRAME :: 10

Game :: struct {
	points:    [11][2]int,
	cur_frame: int,
	cur_ball:  int,
}

Error :: enum {
	None,
	Game_Over,
	Game_Not_Over,
	Roll_Not_Between_1_And_10,
	Rolls_in_Frame_Exceed_10_Points,
}

new_game :: proc() -> Game {
	return Game{}
}

is_strike :: proc(g: Game, frame: int) -> bool {

	return g.points[frame][0] == MAX_PINS
}

is_spare :: proc(g: Game, frame: int) -> bool {

	return g.points[frame][0] != MAX_PINS && (g.points[frame][0] + g.points[frame][1]) == MAX_PINS
}

is_game_over :: proc(g: Game) -> bool {

	return(
		g.cur_frame > EXTRA_FRAME ||
		g.cur_frame == EXTRA_FRAME &&
			!is_strike(g, LAST_FRAME) &&
			!((is_spare(g, LAST_FRAME) && g.cur_ball == 0)) \
	)
}

roll :: proc(g: ^Game, pins: int) -> Error {

	if is_game_over(g^) {
		return .Game_Over
	}
	if pins < 0 || pins > MAX_PINS {
		return .Roll_Not_Between_1_And_10
	}
	if g.cur_ball == 1 &&
	   (g.points[g.cur_frame][0] + pins) > MAX_PINS &&
	   !(g.cur_frame == EXTRA_FRAME && is_strike(g^, EXTRA_FRAME)) {
		return .Rolls_in_Frame_Exceed_10_Points
	}
	g.points[g.cur_frame][g.cur_ball] = pins
	if g.cur_frame < EXTRA_FRAME && is_strike(g^, g.cur_frame) {
		g.cur_frame += 1
	} else {
		g.cur_ball += 1
		if g.cur_ball == 2 {
			g.cur_frame += 1
			g.cur_ball = 0
		}
	}
	return .None
}

score :: proc(g: Game) -> (int, Error) {

	if !is_game_over(g) {
		return 0, .Game_Not_Over
	}
	score := 0
	for frame := 0; frame < EXTRA_FRAME; frame += 1 {

		score += g.points[frame][0] + g.points[frame][1]
		if is_spare(g, frame) {
			score += g.points[frame + 1][0]
		}
		if is_strike(g, frame) {
			score += g.points[frame + 1][0]
			if frame == LAST_FRAME || !is_strike(g, frame + 1) {
				score += g.points[frame + 1][1]
			} else {
				score += g.points[frame + 2][0]
			}
		}
	}
	return score, .None
}

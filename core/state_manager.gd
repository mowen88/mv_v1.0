extends Node

enum GameState { SPLASH, TITLE, CINEMATIC, GAMEPLAY }

const SCENES = {
	GameState.SPLASH: "res://states/splash_state/splash_state.tscn",
	GameState.TITLE: "res://states/title_state/title_state.tscn",
	GameState.CINEMATIC: "res://states/cinematic_state/cinematic_state.tscn",
	GameState.GAMEPLAY: "res://states/gameplay_state/gameplay_state.tscn"
}

func change_state(target_state: GameState):
	TransitionManager.fade_transition(func():
		var target_path = SCENES[target_state]
		get_tree().change_scene_to_file(target_path)
		)

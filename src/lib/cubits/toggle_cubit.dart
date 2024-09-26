
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/models/toggle_state.dart';

class ToggleCubit extends Cubit<ToggleState> {
	ToggleCubit() : super(ToggleState('Cat', Icons.pets));

	void toggleText() {
		if (state.text == 'Cat') {
			emit(ToggleState('Dog', Icons.person));
		} else {
			emit(ToggleState('Cat', Icons.pets));
		}
	}
}

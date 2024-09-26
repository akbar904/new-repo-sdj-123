
import 'package:flutter/material.dart';

class ToggleState {
	final String text;
	final IconData icon;

	ToggleState(this.text, this.icon);

	Map<String, dynamic> toJson() => {
		'text': text,
		'icon': icon.codePoint,
	};

	factory ToggleState.fromJson(Map<String, dynamic> json) {
		return ToggleState(
			json['text'] as String,
			IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
		);
	}
}

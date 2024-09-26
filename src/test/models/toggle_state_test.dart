
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:simple_app/models/toggle_state.dart';

void main() {
	group('ToggleState Model Tests', () {
		test('Initial state should be correctly instantiated', () {
			final toggleState = ToggleState('Cat', Icons.access_time);
			expect(toggleState.text, 'Cat');
			expect(toggleState.icon, Icons.access_time);
		});

		test('ToggleState should be properly serialized and deserialized', () {
			final toggleState = ToggleState('Dog', Icons.person);
			final toggleStateJson = {
				'text': 'Dog',
				'icon': Icons.person.codePoint,
			};

			expect(toggleState.toJson(), toggleStateJson);

			final deserializedToggleState = ToggleState.fromJson(toggleStateJson);
			expect(deserializedToggleState.text, 'Dog');
			expect(deserializedToggleState.icon, Icons.person);
		});
	});
}

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

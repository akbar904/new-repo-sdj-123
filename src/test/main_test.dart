
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/main.dart';

// Mock classes
class MockToggleCubit extends MockCubit<ToggleState> implements ToggleCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('App starts with HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('HomeScreen Widget Tests', () {
		testWidgets('Initial state displays "Cat" with clock icon', (WidgetTester tester) async {
			final toggleCubit = MockToggleCubit();
			when(() => toggleCubit.state).thenReturn(ToggleState('Cat', Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<ToggleCubit>.value(
					value: toggleCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Clicking text changes to "Dog" with person icon', (WidgetTester tester) async {
			final toggleCubit = MockToggleCubit();
			when(() => toggleCubit.state).thenReturn(ToggleState('Cat', Icons.access_time));
			whenListen(toggleCubit, Stream.fromIterable([ToggleState('Dog', Icons.person)]));

			await tester.pumpWidget(
				BlocProvider<ToggleCubit>.value(
					value: toggleCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}

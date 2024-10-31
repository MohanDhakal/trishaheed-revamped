import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trishaheed/form_widget.dart';

void main() {
  testWidgets("Check Presence of Widget before test", (tester) async {
       // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: FormWidget(),
    ));
    final nameField=find.byKey(ValueKey("nameField"));
    // Verify that our counter starts at 0.
    expect(find.text('Hello this is for testing'), findsOneWidget);
    
    //act
    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byKey(const ValueKey("btn")));
    await tester.enterText(nameField, "Mohan Dhakal");
    
    //same as calling setstate
    // await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Button is Pressed'), findsOne);
    expect(find.text("Mohan Dhakal"), findsOne);

    // await tester.tap(submitButton);
    // await tester.pump();
    // expect(find.text('Name Feild Cannot be empty'), findsOne);
  });
}

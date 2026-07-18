import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/tutorial/tutorial_state.dart';

class TutorialPopup extends StatelessWidget {
  final String title;
  final String description;

  const TutorialPopup({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}

void showTutorialDialog({
  required BuildContext context,
  required TutorialScreen screen,
  VoidCallback? onDismiss,
}) {
  if (_visibleTutorials.contains(screen)) return;

  final content = tutorialRegistry[screen]!;
  _visibleTutorials.add(screen);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(content.title),
        content: TutorialPopup(
          title: content.title,
          description: content.description,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _visibleTutorials.remove(screen);
              if (onDismiss != null) {
                onDismiss();
              }
            },
            child: const Text('Got it!'),
          ),
        ],
      ),
    ),
  );
}

final Set<TutorialScreen> _visibleTutorials = {};

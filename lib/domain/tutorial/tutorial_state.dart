import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';

part 'tutorial_state.g.dart';

enum TutorialScreen {
  home,
  groups,
  group,
  editGroup,
  bill,
  newBillSelection,
  editBill,
  profile,
  editProfile,
  transactions,
  unseenBill,
}

class TutorialContent {
  final String title;
  final String description;

  const TutorialContent({
    required this.title,
    required this.description,
  });
}

const Map<TutorialScreen, TutorialContent> tutorialRegistry = {
  TutorialScreen.home: TutorialContent(
    title: 'Welcome to SplitIt!',
    description:
        'This is your dashboard. Here you can see your overall balance across all groups, view recent bills that need your attention, and quickly jump into your groups.',
  ),
  TutorialScreen.groups: TutorialContent(
    title: 'Manage Groups',
    description:
        'View all your active groups here. You can join an existing group using an invite code or create a new one to start splitting expenses with friends.',
  ),
  TutorialScreen.group: TutorialContent(
    title: 'Group Overview',
    description:
        'Deep dive into your group\'s activity. See the full history of shared bills and the current balance of each member. You can also invite new members or add a new bill from here.',
  ),
  TutorialScreen.editGroup: TutorialContent(
    title: 'Group Settings',
    description:
        'Customize your group! Update the group name here to keep your shared expenses organized and easy to identify.',
  ),
  TutorialScreen.bill: TutorialContent(
    title: 'Bill Breakdown',
    description:
        'Review exactly how this bill was divided. See the total amount, the breakdown of individual contributions, and which items were split among specific members.',
  ),
  TutorialScreen.newBillSelection: TutorialContent(
    title: 'New Bill: Select Group',
    description:
        'Starting a new bill? First, choose the group that this expense belongs to. On the next screen, you\'ll be able to scan your receipt or add items manually.',
  ),
  TutorialScreen.editBill: TutorialContent(
    title: 'Splitting the Bill',
    description:
        'Add items manually or use the "Scan Items" feature for a faster experience. \n\nScanning Workflow:\n1. Take a clear photo of your receipt.\n2. Crop the image to focus on the items and prices.\n3. Verify the detected items in the "Check Items" list. You can reorder, edit, or delete them if the scan wasn\'t perfect.\n\nOnce items are added, select the contributors for each item to split the cost correctly.',
  ),
  TutorialScreen.profile: TutorialContent(
    title: 'Your Profile',
    description:
        'View your account information, including your registered email and username. You can also securely sign out of your account from this page.',
  ),
  TutorialScreen.editProfile: TutorialContent(
    title: 'Personalize Account',
    description:
        'Keep your profile up to date! Update your display name or change your profile picture so your friends can easily recognize you in groups.',
  ),
  TutorialScreen.transactions: TutorialContent(
    title: 'Payment History',
    description:
        'Keep track of the money flow. This page shows a detailed history of all transactions and settlements made across your various groups.',
  ),
  TutorialScreen.unseenBill: TutorialContent(
    title: 'Confirm Contribution',
    description:
        'Action needed! Someone added a new bill. Please review the items assigned to you and confirm your part of the expense to keep the group balances accurate.',
  ),
};

@riverpod
class TutorialController extends _$TutorialController {
  @override
  bool build(TutorialScreen screen) {
    final sharedUtility = ref.watch(sharedUtilityProvider);
    return sharedUtility.isTutorialSeen(screen.name);
  }

  void markAsSeen() {
    final sharedUtility = ref.read(sharedUtilityProvider);
    sharedUtility.setTutorialSeen(screen.name);
    state = true;
  }
}

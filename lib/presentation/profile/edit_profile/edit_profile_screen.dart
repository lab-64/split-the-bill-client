import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/presentation/profile/edit_profile/controllers.dart';
import 'package:split_the_bill/presentation/profile/edit_profile/edit_image_modal.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/bottom_modal.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

const maxFileSizeInBytes = 5 * 1048576; // 5MB

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  late User _user;

  @override
  void initState() {
    _user = ref.read(authStateProvider).requireValue;
    _username.text = _user.username;
    _email.text = _user.email;
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    super.dispose();
  }

  Future<void> _update(GoRouter goRouter) async {
    final controller = ref.read(editProfileControllerProvider.notifier);
    await controller.updateUser(_username.text, _image);
    goRouter.pop();
  }

  Future _getImage(ImageSource source) async {
    final XFile? image =
        await _picker.pickImage(source: source, imageQuality: 25);

    var imagePath = await image!.readAsBytes();

    var fileSize = imagePath.length; // Get the file size in bytes
    if (fileSize > maxFileSizeInBytes) {
      if (mounted) {
        showErrorSnackBar(
          context,
          "The image size is too large. Please select an image with a size less than 5MB.",
        );
      }
      return;
    }

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      floatingActionButton: ActionButton(
        icon: Icons.save,
        onPressed: () => _update(goRouter),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          children: [
            ProfileImage(
              user: _user,
              size: Sizes.p64,
              showOverlayIcon: true,
              onPressed: () => showBottomModal(
                context,
                "Edit Profile Picture",
                EditImageModal(
                  getImage: _getImage,
                ),
              ),
              previewImage: _image,
            ),
            gapH24,
            InputTextField(
              labelText: "Email",
              prefixIcon: const Icon(Icons.email),
              controller: _email,
              isDisabled: true,
            ),
            gapH16,
            InputTextField(
              labelText: "Username",
              prefixIcon: const Icon(Icons.person),
              controller: _username,
            ),
          ],
        ),
      ),
    );
  }
}

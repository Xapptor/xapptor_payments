// ignore_for_file: invalid_use_of_protected_member

import 'package:file_picker/file_picker.dart';
import 'package:xapptor_business/workplace_exam/wpe_editor/wpe_editor.dart';

extension StateExtension on WpeEditorState {
  choose_profile_image() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      chosen_image_path =
          'users/${current_user!.uid}/wpes/wpe_profile_image.${result.files.single.extension}';
      chosen_image_bytes = result.files.single.bytes!;
      setState(() {});
    }
  }
}

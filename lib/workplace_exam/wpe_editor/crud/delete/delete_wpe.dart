import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_business/workplace_exam/wpe_editor/crud/read/get_wpe_ref.dart';
import 'package:xapptor_business/workplace_exam/wpe_editor/wpe_editor.dart';
import 'package:xapptor_business/workplace_exam/wpe_editor/show_result_snack_bar.dart';

extension StateExtension on WpeEditorState {
  delete_wpe() async {
    DocumentReference wpe_doc_ref = get_wpe_ref();

    await wpe_doc_ref.delete().then((value) async {
      //wpes.removeAt();

      show_result_snack_bar(
        result_snack_bar_type: ResultSnackBarType.deleted,
      );
    });
  }
}

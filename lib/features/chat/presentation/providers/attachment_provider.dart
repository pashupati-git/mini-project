import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attachment_provider.g.dart';

enum AttachmentType {
  image,
  video,
  document,
  audio,
}

class Attachment {
  final String id;
  final String path;
  final AttachmentType type;
  final int? size;
  final String? mimeType;

  Attachment({
    required this.id,
    required this.path,
    required this.type,
    this.size,
    this.mimeType,
  });
}

// Attachment Upload Provider
@riverpod
class AttachmentUploader extends _$AttachmentUploader {
  @override
  Map<String, double> build() => {}; // attachment id -> progress (0.0 - 1.0)

  Future<void> uploadAttachment(Attachment attachment) async {
    // Simulate upload progress
    for (var i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      state = {...state, attachment.id: i / 10};
    }

    // Remove from state after upload completes
    final newState = Map<String, double>.from(state);
    newState.remove(attachment.id);
    state = newState;
  }

  double? getProgress(String attachmentId) {
    return state[attachmentId];
  }

  bool isUploading(String attachmentId) {
    return state.containsKey(attachmentId);
  }
}

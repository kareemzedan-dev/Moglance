import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model_states.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_states.dart';
import '../../../../../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../../../../../../../attachments/presentation/manager/delete_attachments_view_model/delete_attachments_view_model.dart';
import '../../../../../../../../attachments/presentation/manager/delete_attachments_view_model/delete_attachments_view_model_states.dart';
import '../../../../../../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
import '../../../../../../../../../core/components/dismissible_error_card.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_view_model.dart';
import '../../view_model/place_order_view_model/place_order_view_model.dart';

class AttachmentsFilesSection extends StatefulWidget {
  final UploadOrderAttachmentsViewModel uploadOrderAttachmentsViewModel;
  final VoidCallback? onTap;
  final VoidCallback? onClearAll;

  const AttachmentsFilesSection({
    super.key,
    required this.uploadOrderAttachmentsViewModel,
    this.onTap,
    this.onClearAll,
  });

  @override
  State<AttachmentsFilesSection> createState() =>
      _AttachmentsFilesSectionState();
}

class _AttachmentsFilesSectionState extends State<AttachmentsFilesSection> {
  late final DeleteAttachmentsViewModel deleteAttachmentsViewModel;

  @override
  void initState() {
    super.initState();
    deleteAttachmentsViewModel = getIt<DeleteAttachmentsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.uploadOrderAttachmentsViewModel),
        BlocProvider.value(value: deleteAttachmentsViewModel),
      ],
      child: BlocConsumer<UploadOrderAttachmentsViewModel,
          UploadOrderAttachmentsViewModelStates>(
        listener: (context, state) {
          if (state is UploadOrderAttachmentsViewModelStatesLoading) {
            _showTemporaryMessage(local.uploading, MessageType.success);
          } else if (state is UploadOrderAttachmentsViewModelStatesError) {
            _showTemporaryMessage(local.error(state.message), MessageType.error);

          } else if (state is UploadOrderAttachmentsViewModelStatesSuccess) {
            _showTemporaryMessage(local.uploaded_successfully, MessageType.success);
            context.read<PlaceOrderViewModel>().setUploadedAttachments(
              state.attachments.map((e) => AttachmentModel(
                id: e.id,
                url: e.url,
                name: e.name,
                type: e.type,
                size: e.size,
                storagePath: e.storagePath,
              )).toList(),
            );

          }

        },
        builder: (context, state) {
          final files = widget.uploadOrderAttachmentsViewModel.files;
          final uploadedHashes =
              widget.uploadOrderAttachmentsViewModel.uploadedFileHashes;

          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon:
                    const Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: () async {
                      await widget.uploadOrderAttachmentsViewModel
                          .pickFilesFromDevice();
                    },
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.onTap,
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                          child: Text(
                            widget.uploadOrderAttachmentsViewModel.uploadedFileHashes.isEmpty
                                ? local.no_files_uploaded_yet
                                : local.files_uploaded_count(uploadedHashes.length),

                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(

                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ...files.map((file) {
                final uniqueKey = Key('${file.path}_${file.lengthSync()}');

                return FutureBuilder<String>(
                  key: uniqueKey,
                  future:
                  widget.uploadOrderAttachmentsViewModel.generateFileHash(file),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child:
                              CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                file.path.split('/').last,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(

                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          local.error(snapshot.error.toString()),
                        ),

                      );
                    }

                    final fileHash = snapshot.data;
                    final isUploaded =
                        fileHash != null && uploadedHashes.contains(fileHash);

                    return BlocConsumer<DeleteAttachmentsViewModel,
                        DeleteAttachmentsViewModelStates>(
                      listener: (context, state) {
                        if (state is DeleteAttachmentsViewModelStatesError &&
                            mounted) {
                          _showTemporaryMessage(local.error(state.message), MessageType.error);

                        } else if (state
                        is DeleteAttachmentsViewModelStatesSuccess &&
                            mounted) {
                          _showTemporaryMessage(
                              local.file_deleted_successfully,
                              MessageType.success);
                        }
                      },
                      builder: (context, _) => Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isUploaded
                                ? Colors.green
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          color:
                          isUploaded ? Colors.green.withOpacity(0.1) : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                file.path.split('/').last,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  color: isUploaded ? Colors.green : null,
                                  fontWeight:
                                  isUploaded ? FontWeight.bold : null,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isUploaded)
                              const Icon(Icons.check_circle,
                                  color: Colors.green, size: 20)
                            else if (state is UploadAttachmentsViewModelStatesLoading)
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            else
                              const Icon(Icons.pending,
                                  color: Colors.orange, size: 20),
                            SizedBox(width: 8.w),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18,color: Colors.grey,),
                              onPressed: () => _onDeleteFile(file, local),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }

  void _onDeleteFile(File file, AppLocalizations local) async {
    widget.uploadOrderAttachmentsViewModel.removeFileFromQueue(file);

    final attachments = widget.uploadOrderAttachmentsViewModel.uploadedAttachments
        .where((e) => e.name == file.path.split('/').last)
        .toList();

    if (attachments.isEmpty) {
      if (mounted) {
        _showTemporaryMessage(local.file_not_found_for_deletion, MessageType.error);
      }
      return;
    }

    final attachment = attachments.first;
    final result =
    await deleteAttachmentsViewModel.deleteAttachment(attachment.storagePath);

    if (!mounted) return;

    result.fold(
          (failure) {
        _showTemporaryMessage(local.failed_to_delete_file, MessageType.error);
      },
          (_) {
        _showTemporaryMessage(local.file_deleted_successfully, MessageType.success);
        widget.uploadOrderAttachmentsViewModel.uploadedAttachments.remove(attachment);
      },
    );
  }

  void _showTemporaryMessage(String message, MessageType type) {
    if (mounted) {
      showTemporaryMessage(context, message, type);
    }
  }
}

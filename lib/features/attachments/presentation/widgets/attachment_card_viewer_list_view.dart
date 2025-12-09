import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../data/models/attachments_dm/attachments_dm.dart';
import '../manager/download_attachments_view_model/download_attachments_view_model.dart';
import 'attachment_card_viewer.dart';

class AttachmentCardViewerListView extends StatelessWidget {
  final List<AttachmentModel> attachmentEntity;
  final bool isFreelancer;

  const AttachmentCardViewerListView({
    super.key,
    required this.attachmentEntity,
    required this.isFreelancer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: attachmentEntity.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocProvider(
              create: (context) =>  getIt<DownloadAttachmentsViewModel>(),
              child: AttachmentItemViewer(
                attachmentName: attachmentEntity[index].name,
                attachmentPath: attachmentEntity[index].url,
                isFreelancer: true,
              ),
            )
          );
        },
      ),
    );
  }
}

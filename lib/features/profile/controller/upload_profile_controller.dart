import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:social/features/messenger/controller/image_picker_mixin.dart';
import 'package:taakitecture/taakitecture.dart';
import 'package:dio/dio.dart' as dio;
import '../../../core/app/utils/mixin/handle_failure_mixin.dart';
import '../../messenger/controller/messenger_media_mixin.dart';
import 'edit_profile_controller.dart';

class UploadProfileController extends BaseController with ImagePickerMixin, MessengerMediaMixin, HandleFailureMixin {
  UploadProfileController(super.remoteRepository);

  static UploadProfileController get to => Get.find();

  @override
  onFilePicked(XFile bytes) async {
    final file = await cropImage(bytes.path);
    return uploadAvatar(file ?? bytes);
  }

  uploadAvatar(XFile bytes) async {
    final file = dio.MultipartFile.fromBytes(await bytes.readAsBytes(), filename: bytes.name);

    final formData = dio.FormData();
    formData.files.add(MapEntry('files', file));

    uploadFile(formData: formData).then(
      (either) => either.fold(
        (l) => onFailure(bytes.toString(), l, () => uploadAvatar(bytes)),
        (r) => EditProfileController.to.editProfile(r.name),
      ),
    );
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:taakitecture/taakitecture.dart';
part 'register_otp_model.g.dart';

@JsonSerializable()
class RegisterOtpModel extends BaseModel{
  late String identity, otp;

  @override
  fromJson(Map<String, dynamic> json) => _$RegisterOtpModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterOtpModelToJson(this);
}
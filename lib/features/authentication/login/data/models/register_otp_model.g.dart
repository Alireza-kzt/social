// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterOtpModel _$RegisterOtpModelFromJson(Map<String, dynamic> json) =>
    RegisterOtpModel()
      ..identity = json['identity'] as String
      ..otp = json['otp'] as String;

Map<String, dynamic> _$RegisterOtpModelToJson(RegisterOtpModel instance) =>
    <String, dynamic>{
      'identity': instance.identity,
      'code': instance.otp,
    };

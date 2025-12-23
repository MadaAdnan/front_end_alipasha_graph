import 'dart:io';

class IdentityVerificationModel {
  File? frontImage;
  File? backImage;
  bool isUploading = false;
  bool isVerified = false;

  IdentityVerificationModel({
    this.frontImage,
    this.backImage,
    this.isUploading = false,
    this.isVerified = false,
  });
}
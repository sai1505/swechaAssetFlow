import 'dart:io';
import 'dart:typed_data';

import 'package:cloudflare_r2/cloudflare_r2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class R2StorageService {
  // Load from .env file
  static final String accountId = dotenv.env['ACCOUNT_ID'] ?? '';
  static final String accessKeyId = dotenv.env['R2_ACCESS_KEY'] ?? '';
  static final String secretAccessKey = dotenv.env['R2_SECRET_KEY'] ?? '';
  static final String bucketName = dotenv.env['R2_BUCKET'] ?? '';

  /// Initialize CloudFlare R2 - Call this before any operations
  static void init() {
    CloudFlareR2.init(
      accountId: accountId,
      accessKeyId: accessKeyId,
      secretAccessKey: secretAccessKey,
    );
  }

  /// Upload file to R2
  static Future<bool> uploadFile(
    File file,
    String fileName, {
    String contentType = 'application/octet-stream',
  }) async {
    try {
      init();
      final Uint8List objectBytes = await file.readAsBytes();

      await CloudFlareR2.putObject(
        bucket: bucketName,
        objectName: fileName,
        objectBytes: objectBytes,
        contentType: contentType,
      );

      return true;
    } catch (e) {
      print('Upload error: $e');
      return false;
    }
  }

  /// Download file from R2
  static Future<List<int>?> downloadFile(String fileName) async {
    try {
      init();
      return await CloudFlareR2.getObject(
        bucket: bucketName,
        objectName: fileName,
      );
    } catch (e) {
      print('Download error: $e');
      return null;
    }
  }

  /// Delete file from R2
  static Future<bool> deleteFile(String fileName) async {
    try {
      init();
      await CloudFlareR2.deleteObject(
        bucket: bucketName,
        objectName: fileName,
      );
      return true;
    } catch (e) {
      print('Delete error: $e');
      return false;
    }
  }

  static Future<bool> uploadBytes(
    Uint8List bytes,
    String fileName, {
    String contentType = 'application/octet-stream',
  }) async {
    try {
      init();

      await CloudFlareR2.putObject(
        bucket: bucketName,
        objectName: fileName,
        objectBytes: bytes,
        contentType: contentType,
      );

      print('Uploaded: $fileName');
      return true;
    } catch (e) {
      print('Upload bytes error: $e');
      return false;
    }
  }

  /// Get public URL (if bucket is public)
  static String getPublicUrl(String fileName) {
    return 'https://$accountId.r2.cloudflarestorage.com/$bucketName/$fileName';
  }
}

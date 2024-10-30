import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  // Fungsi untuk mengambil gambar dari galeri
  Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    // Memilih gambar dari galeri
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final filePath = image.path;
      // Memeriksa ekstensi file
      if (filePath.endsWith('.jpg') || filePath.endsWith('.jpeg') || filePath.endsWith('.png')) {
        // Mengembalikan file gambar
        return File(image.path);
      }
    } else {
      return null;
    }
    return null;
  }

  Future<Uint8List?> fileToBinary(String filePath) async {
    try {
      // Membaca file sebagai binary
      final File file = File(filePath);
      Uint8List bytes = await file.readAsBytes();
      return bytes;
    } catch (e) {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class StopwatchController extends GetxController {
  var bgcolor = const Color(0xFFF6F8FE).obs;
  var secondry = const Color(0xFFECEFF9).obs;
  var highlight = const Color(0xFFE7EBF7).obs;

  var lapsList = <Map<String, String>>[].obs;
  var elapsedTime = Duration.zero.obs;
  var isStart = false.obs;
  var isPause = false.obs;
  Timer? _timer;

  String timeFormat(Duration duration) {
  // Fungsi untuk menambahkan dua digit angka dengan padding nol di depan jika perlu
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  
  // Fungsi untuk menambahkan tiga digit angka untuk milidetik
  String threeDigits(int n) => n.toString().padLeft(3, '0');

  // Mengambil jam, menit, detik, dan milidetik
  String hours = twoDigits(duration.inHours); // Jam (2 digit)
  String minutes = twoDigits(duration.inMinutes.remainder(60)); // Menit (2 digit)
  String seconds = twoDigits(duration.inSeconds.remainder(60)); // Detik (2 digit)
  String milliseconds = threeDigits(duration.inMilliseconds.remainder(1000)); // Milidetik (3 digit)

  // Mengembalikan waktu dalam format "jj:mm:dd:milidetik"
  return '$hours:$minutes:$seconds:$milliseconds';
}


  void startWatch() {
    if (!isStart.value && !isPause.value) {
      _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
        elapsedTime.value += const Duration(milliseconds: 1);
      });
      isStart.value = true;
    } else if (isPause.value) {
      _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
        elapsedTime.value += const Duration(milliseconds: 1);
      });
      isStart.value = true;
      isPause.value = false;
    }
  }

  void pauseWatch() {
    if (isStart.value) {
      _timer?.cancel();
      isPause.value = true;
      isStart.value = false;
    }
  }

  void reset() {
    _timer?.cancel();
    elapsedTime.value = Duration.zero;
    lapsList.clear();
    isStart.value = false;
    isPause.value = false;
  }

  void stop() {
    _timer?.cancel();
    elapsedTime.value = Duration.zero;
    isStart.value = false;
    isPause.value = false;
  }

  void addLap() {
    lapsList.add({
      'lap': 'LAP ${lapsList.length + 1}',
      'time': timeFormat(elapsedTime.value),
    });
  }
}

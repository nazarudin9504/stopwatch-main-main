import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'stopwatch_controller.dart';

class Home extends StatelessWidget {
  final StopwatchController stopwatchController = Get.put(StopwatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stopwatchController.bgcolor.value,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 25, top: 20),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
          ),
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 55, bottom: 5),
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: stopwatchController.secondry.value,
                borderRadius: BorderRadius.circular(360),
              ),
              child: const Center(
                child: Text(
                  'StopWatch',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Display Stopwatch Timer
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Center(
              child: InkWell(
                onTap: () {
                  if (stopwatchController.isStart.value) {
                    stopwatchController.addLap();
                  }
                },
                child: Container(
                  height: 270,
                  width: 270,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(360),
                    boxShadow: List.filled(
                      10,
                      BoxShadow(
                        color: stopwatchController.highlight.value,
                        blurRadius: 30,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Obx(() => Text(
                          stopwatchController.timeFormat(stopwatchController.elapsedTime.value),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontFamily: 'Redex',
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ),

          // List - Laps
          Obx(() => SizedBox(
                width: double.infinity,
                height: 250,
                child: ListView.builder(
                  itemCount: stopwatchController.lapsList.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
                  itemBuilder: (context, index) {
                    final lapsItem = stopwatchController.lapsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 5),
                      child: Container(
                        height: 120,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
                          crossAxisAlignment: CrossAxisAlignment.start, // Left-aligns horizontally
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15), // Align to the left horizontally
                              child: Text(
                                lapsItem['lap']!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Redex',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 15), // Align to the left horizontally
                              child: Text(
                                lapsItem['time']!,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),

          const Spacer(),

          // Row of Buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Start/Pause/Resume Button
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      if (stopwatchController.isStart.value) {
                        stopwatchController.pauseWatch();
                      } else {
                        stopwatchController.startWatch();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => Icon(
                                stopwatchController.isStart.value
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.grey.shade300,
                                size: 35,
                              )),
                          const SizedBox(width: 10),
                          Obx(() => Text(
                                stopwatchController.isStart.value
                                    ? 'PAUSE'
                                    : stopwatchController.isPause.value
                                        ? 'RESUME'
                                        : 'START',
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 19,
                                  fontFamily: 'Ubuntu',
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Stop/Reset Button
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      if (stopwatchController.isStart.value) {
                        stopwatchController.stop();
                      } else {
                        stopwatchController.reset();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => Icon(
                                stopwatchController.isStart.value
                                    ? Icons.stop_rounded
                                    : Icons.restart_alt,
                                color: Colors.grey.shade300,
                                size: 35,
                              )),
                          const SizedBox(width: 10),
                          Obx(() => Text(
                                stopwatchController.isStart.value ? 'STOP' : 'RESET',
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 19,
                                  fontFamily: 'Ubuntu',
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
             
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

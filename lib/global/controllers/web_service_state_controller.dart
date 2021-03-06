import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/widgets/lh_text.dart';
import 'package:lottie/lottie.dart';

class WebServiceStateController extends GetxController {
  RxDouble networkProgress = RxDouble(0.0);
  RxInt loading = RxInt(0);

  setNetworkProgress(num progress) {
    networkProgress.value = progress.toDouble();
  }

  pushLoading({Widget? childLoading}) {
    loading.value++;
    print('pushLoading ${loading.value}');
    if (isLoading() && Get.isDialogOpen != true) {
      Get.dialog(Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Center(child: childLoading ?? CircularProgressIndicator()),
        ),
      ));
    }
  }

  pushTimeout({Widget? timeout}) {
    loading.value++;
    print('pushLoading ${loading.value}');
    if (isLoading() && Get.isDialogOpen != true) {
      Get.dialog(
        Scaffold(
          body: StatefulBuilder(
            builder: (context, setState1) {
              return SafeArea(
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: timeout ??
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh, size: 30,),
                            LhValue.vSpaceSmall,
                            LhText('Thử lại', style: LhStyle.DEFAULT_16,),
                          ],
                        ),
                      ),
                  ),
                ),
              );
            },
          ),
        )
      );
    }
  }

  popLoading() {
    loading.value > 0 ? loading.value-- : loading.value = 0;
    if (!this.isLoading() && Get.isDialogOpen == true) {
      Get.back();
    }
    print('popLoading ${loading.value}');
  }

  bool isLoading() {
    return loading.value > 0;
  }
}

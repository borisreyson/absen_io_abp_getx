import 'package:face_id_plus/app/modules/home/buletin_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../providers/buletin_provider.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class HomeController extends GetxController {
  final _provider = BuletinProvider();
  final count = 0.obs;
  final indexSelect = 0.obs;
  Rx<Buletin>? buletin = Buletin().obs;
  final page = 1.obs;
  late RefreshController pullRefresh;
  @override
  void onInit() async {
    pullRefresh = RefreshController(initialRefresh: false);
    await _provider.getBuletinPage(1).then((value) {
      buletin?.value = value!;
    });
    super.onInit();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void onLoading() async {
    page.value++;
    await _provider
        .getBuletinPage(int.parse("$page"))
        .then((value) => buletin?.value = value!);
    pullRefresh.loadComplete();
    pullRefresh.refreshCompleted();
  }

  void onRefresh() async {
    page.value = 1;
    await _provider
        .getBuletinPage(int.parse("$page"))
        .then((value) => buletin?.value = value!);
    pullRefresh.loadComplete();
    pullRefresh.refreshCompleted();
  }
  internetPermission()async{
    // var permission = handler.Permission.
  }
}

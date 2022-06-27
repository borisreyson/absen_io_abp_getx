import 'package:get/get.dart';

import '../modules/buletin/bindings/buletin_binding.dart';
import '../modules/buletin/views/buletin_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hse/correctiveAction/bindings/corrective_action_binding.dart';
import '../modules/hse/correctiveAction/views/corrective_action_view.dart';
import '../modules/hse/detailHazard/bindings/detail_hazard_binding.dart';
import '../modules/hse/detailHazard/views/detail_hazard_view.dart';
import '../modules/hse/formHazard/bindings/form_hazard_binding.dart';
import '../modules/hse/formHazard/views/form_hazard_view.dart';
import '../modules/hse/hazardList/bindings/hazard_list_binding.dart';
import '../modules/hse/hazardList/views/hazard_list_view.dart';
import '../modules/hse/hazardPJ/bindings/hazard_p_j_binding.dart';
import '../modules/hse/hazardPJ/views/hazard_p_j_view.dart';
import '../modules/hse/hazardUser/bindings/hazard_user_binding.dart';
import '../modules/hse/hazardUser/views/hazard_user_view.dart';
import '../modules/hse/imageHazardView/bindings/image_hazard_view_binding.dart';
import '../modules/hse/imageHazardView/views/image_hazard_view_view.dart';
import '../modules/hse/kemungkinan/bindings/kemungkinan_binding.dart';
import '../modules/hse/kemungkinan/views/kemungkinan_view.dart';
import '../modules/hse/keparahan/bindings/keparahan_binding.dart';
import '../modules/hse/keparahan/views/keparahan_view.dart';
import '../modules/hse/listUser/bindings/list_user_binding.dart';
import '../modules/hse/listUser/views/list_user_view.dart';
import '../modules/hse/lokasiHazard/bindings/lokasi_hazard_binding.dart';
import '../modules/hse/lokasiHazard/views/lokasi_hazard_view.dart';
import '../modules/hse/pengendalian/bindings/pengendalian_binding.dart';
import '../modules/hse/pengendalian/views/pengendalian_view.dart';
import '../modules/hse/perusahaan/bindings/perusahaan_binding.dart';
import '../modules/hse/perusahaan/views/perusahaan_view.dart';
import '../modules/hse/profileAbp/bindings/profile_abp_binding.dart';
import '../modules/hse/profileAbp/views/profile_abp_view.dart';
import '../modules/hse/rubahHazard/bindings/rubah_hazard_binding.dart';
import '../modules/hse/rubahHazard/views/rubah_hazard_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menuAbp/bindings/menu_abp_binding.dart';
import '../modules/menuAbp/views/menu_abp_view.dart';
import '../modules/permission/galery/bindings/galery_binding.dart';
import '../modules/permission/galery/views/galery_view.dart';
import '../modules/permission/kamera/bindings/kamera_binding.dart';
import '../modules/permission/kamera/views/kamera_view.dart';
import '../modules/permission/lokasi/bindings/lokasi_binding.dart';
import '../modules/permission/lokasi/views/lokasi_view.dart';
import '../modules/permission/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/permission/notifikasi/views/notifikasi_view.dart';
import '../modules/permission/penimpanan/bindings/penimpanan_binding.dart';
import '../modules/permission/penimpanan/views/penimpanan_view.dart';
import '../modules/presensi/absenMasuk/bindings/absen_masuk_binding.dart';
import '../modules/presensi/absenMasuk/views/absen_masuk_view.dart';
import '../modules/presensi/absenPulang/bindings/absen_pulang_binding.dart';
import '../modules/presensi/absenPulang/views/absen_pulang_view.dart';
import '../modules/presensi/absensi/bindings/absensi_binding.dart';
import '../modules/presensi/absensi/views/absensi_view.dart';
import '../modules/presensi/absensiVPS/bindings/absensi_v_p_s_binding.dart';
import '../modules/presensi/absensiVPS/views/absensi_v_p_s_view.dart';
import '../modules/presensi/grafikKehadiran/bindings/grafik_kehadiran_binding.dart';
import '../modules/presensi/grafikKehadiran/views/grafik_kehadiran_view.dart';
import '../modules/presensi/listAbsen/bindings/list_absen_binding.dart';
import '../modules/presensi/listAbsen/views/list_absen_view.dart';
import '../modules/presensi/loginAbsen/bindings/login_absen_binding.dart';
import '../modules/presensi/loginAbsen/views/login_absen_view.dart';
import '../modules/presensi/mainAbsen/bindings/main_absen_binding.dart';
import '../modules/presensi/mainAbsen/views/main_absen_view.dart';
import '../modules/presensi/profile/bindings/profile_binding.dart';
import '../modules/presensi/profile/views/profile_view.dart';
import '../modules/presensi/rosterKerja/bindings/roster_kerja_binding.dart';
import '../modules/presensi/rosterKerja/views/roster_kerja_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN_ABSEN,
      page: () => LoginAbsenView(),
      binding: LoginAbsenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.BULETIN,
      page: () => BuletinView(),
      binding: BuletinBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ABSENSI,
      page: () => AbsensiView(),
      binding: AbsensiBinding(),
    ),
    GetPage(
      name: _Paths.MENU_ABP,
      page: () => MenuAbpView(),
      binding: MenuAbpBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.KAMERA,
      page: () => KameraView(),
      binding: KameraBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOKASI,
      page: () => LokasiView(),
      binding: LokasiBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PENIMPANAN,
      page: () => PenimpananView(),
      binding: PenimpananBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => NotifikasiView(),
      binding: NotifikasiBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.GALERY,
      page: () => GaleryView(),
      binding: GaleryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_ABSEN,
      page: () => MainAbsenView(),
      binding: MainAbsenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ABSENSI_V_P_S,
      page: () => AbsensiVPSView(),
      binding: AbsensiVPSBinding(),
    ),
    GetPage(
      name: _Paths.LIST_ABSEN,
      page: () => ListAbsenView(),
      binding: ListAbsenBinding(),
    ),
    GetPage(
      name: _Paths.ROSTER_KERJA,
      page: () => RosterKerjaView(),
      binding: RosterKerjaBinding(),
    ),
    GetPage(
      name: _Paths.GRAFIK_KEHADIRAN,
      page: () => GrafikKehadiranView(),
      binding: GrafikKehadiranBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN_MASUK,
      page: () => const AbsenMasukView(),
      binding: AbsenMasukBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN_PULANG,
      page: () => AbsenPulangView(),
      binding: AbsenPulangBinding(),
    ),
    GetPage(
      name: _Paths.CORRECTIVE_ACTION,
      page: () => CorrectiveActionView(),
      binding: CorrectiveActionBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_ABP,
      page: () => ProfileAbpView(),
      binding: ProfileAbpBinding(),
    ),
    GetPage(
      name: _Paths.HAZARD_LIST,
      page: () => HazardListView(),
      binding: HazardListBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HAZARD,
      page: () => DetailHazardView(),
      binding: DetailHazardBinding(),
    ),
    GetPage(
      name: _Paths.RUBAH_HAZARD,
      page: () => RubahHazardView(),
      binding: RubahHazardBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_HAZARD_VIEW,
      page: () => ImageHazardViewView(),
      binding: ImageHazardViewBinding(),
    ),
    GetPage(
      name: _Paths.HAZARD_USER,
      page: () => HazardUserView(),
      binding: HazardUserBinding(),
    ),
    GetPage(
      name: _Paths.HAZARD_P_J,
      page: () => HazardPJView(),
      binding: HazardPJBinding(),
    ),
    GetPage(
      name: _Paths.FORM_HAZARD,
      page: () => FormHazardView(),
      binding: FormHazardBinding(),
    ),
    GetPage(
      name: _Paths.LIST_USER,
      page: () => ListUserView(),
      binding: ListUserBinding(),
    ),
    GetPage(
      name: _Paths.KEMUNGKINAN,
      page: () => KemungkinanView(),
      binding: KemungkinanBinding(),
    ),
    GetPage(
      name: _Paths.KEPARAHAN,
      page: () => KeparahanView(),
      binding: KeparahanBinding(),
    ),
    GetPage(
      name: _Paths.PENGENDALIAN,
      page: () => PengendalianView(),
      binding: PengendalianBinding(),
    ),
    GetPage(
      name: _Paths.LOKASI_HAZARD,
      page: () => LokasiHazardView(),
      binding: LokasiHazardBinding(),
    ),
    GetPage(
      name: _Paths.PERUSAHAAN,
      page: () => PerusahaanView(),
      binding: PerusahaanBinding(),
    ),
  ];
}

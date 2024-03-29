import 'package:face_id_plus/app/modules/monitoring/screens/monitoringBarging/bindings/monitoring_barging_binding.dart';
import 'package:get/get.dart';

import '../modules/buletin/bindings/buletin_binding.dart';
import '../modules/buletin/views/buletin_view.dart';
import '../modules/hge/detail_kabag/bindings/detail_kabag_binding.dart';
import '../modules/hge/detail_kabag/views/detail_kabag_view.dart';
import '../modules/hge/rkb/bindings/rkb_binding.dart';
import '../modules/hge/rkb/views/rkb_view.dart';
import '../modules/hge/rkb_admin/bindings/rkb_admin_binding.dart';
import '../modules/hge/rkb_admin/views/rkb_admin_view.dart';
import '../modules/hge/rkb_dept/bindings/rkb_dept_binding.dart';
import '../modules/hge/rkb_dept/views/rkb_dept_view.dart';
import '../modules/hge/rkb_detail/bindings/rkb_detail_binding.dart';
import '../modules/hge/rkb_detail/views/rkb_detail_view.dart';
import '../modules/hge/rkb_kabag/bindings/rkb_kabag_binding.dart';
import '../modules/hge/rkb_kabag/views/rkb_kabag_view.dart';
import '../modules/hge/rkb_ktt/bindings/rkb_ktt_binding.dart';
import '../modules/hge/rkb_ktt/views/rkb_ktt_view.dart';
import '../modules/hge/rkb_lampiran/bindings/rkb_lampiran_binding.dart';
import '../modules/hge/rkb_lampiran/views/rkb_lampiran_view.dart';
import '../modules/hge/rkb_menu/bindings/rkb_menu_binding.dart';
import '../modules/hge/rkb_menu/views/rkb_menu_view.dart';
import '../modules/hge/rkb_pdf/bindings/rkb_pdf_binding.dart';
import '../modules/hge/rkb_pdf/views/rkb_pdf_view.dart';
import '../modules/hge/rkb_purchasing/bindings/rkb_purchasing_binding.dart';
import '../modules/hge/rkb_purchasing/views/rkb_purchasing_view.dart';
import '../modules/hge/rkb_section/bindings/rkb_section_binding.dart';
import '../modules/hge/rkb_section/views/rkb_section_view.dart';
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
import '../modules/hse/rubahBahaya/bindings/rubah_bahaya_binding.dart';
import '../modules/hse/rubahBahaya/views/rubah_bahaya_view.dart';
import '../modules/hse/rubahHazard/bindings/rubah_hazard_binding.dart';
import '../modules/hse/rubahHazard/views/rubah_hazard_view.dart';
import '../modules/hse/rubahKTA/bindings/rubah_k_t_a_binding.dart';
import '../modules/hse/rubahKTA/views/rubah_k_t_a_view.dart';
import '../modules/hse/rubahStatus/bindings/rubah_status_binding.dart';
import '../modules/hse/rubahStatus/views/rubah_status_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menuAbp/bindings/menu_abp_binding.dart';
import '../modules/menuAbp/views/menu_abp_view.dart';
import '../modules/monitoring/bindings/monitoring_binding.dart';
import '../modules/monitoring/screens/monitoringBarging/views/monitoring_barging_view.dart';
import '../modules/monitoring/screens/monitoringCrushing/bindings/monitoring_crushing_binding.dart';
import '../modules/monitoring/screens/monitoringCrushing/views/monitoring_crushing_view.dart';
import '../modules/monitoring/screens/monitoringHauling/bindings/monitoring_hauling_binding.dart';
import '../modules/monitoring/screens/monitoringHauling/views/monitoring_hauling_view.dart';
import '../modules/monitoring/screens/monitoringHaulingDelay/bindings/monitoring_hauling_delay_binding.dart';
import '../modules/monitoring/screens/monitoringHaulingDelay/views/monitoring_hauling_delay_view.dart';
import '../modules/monitoring/screens/monitoringOB/bindings/monitoring_o_b_binding.dart';
import '../modules/monitoring/screens/monitoringOB/views/monitoring_o_b_view.dart';
import '../modules/monitoring/screens/monitoringObDlay/bindings/monitoring_ob_dlay_binding.dart';
import '../modules/monitoring/screens/monitoringObDlay/views/monitoring_ob_dlay_view.dart';
import '../modules/monitoring/screens/monitoringStockProduct/bindings/monitoring_stock_product_binding.dart';
import '../modules/monitoring/screens/monitoringStockProduct/views/monitoring_stock_product_view.dart';
import '../modules/monitoring/screens/monitoringStockRom/bindings/monitoring_stock_rom_binding.dart';
import '../modules/monitoring/screens/monitoringStockRom/views/monitoring_stock_rom_view.dart';
import '../modules/monitoring/screens/monitoringTugboat/bindings/monitoring_tugboat_binding.dart';
import '../modules/monitoring/screens/monitoringTugboat/views/monitoring_tugboat_view.dart';
import '../modules/monitoring/views/monitoring_view.dart';
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
import '../modules/pesan/bindings/pesan_binding.dart';
import '../modules/pesan/views/pesan_view.dart';
import '../modules/presensi/absenMasuk/bindings/absen_masuk_binding.dart';
import '../modules/presensi/absenMasuk/views/absen_masuk_view.dart';
import '../modules/presensi/absenPulang/bindings/absen_pulang_binding.dart';
import '../modules/presensi/absenPulang/views/absen_pulang_view.dart';
import '../modules/presensi/absensi/bindings/absensi_binding.dart';
import '../modules/presensi/absensi/views/absensi_view.dart';
import '../modules/presensi/absensiVPS/bindings/absensi_v_p_s_binding.dart';
import '../modules/presensi/absensiVPS/views/absensi_v_p_s_view.dart';
import '../modules/presensi/detail_absensi/bindings/detail_absensi_binding.dart';
import '../modules/presensi/detail_absensi/views/detail_absensi_view.dart';
import '../modules/presensi/grafikKehadiran/bindings/grafik_kehadiran_binding.dart';
import '../modules/presensi/grafikKehadiran/views/grafik_kehadiran_view.dart';
import '../modules/presensi/listAbsen/bindings/list_absen_binding.dart';
import '../modules/presensi/listAbsen/views/list_absen_view.dart';
import '../modules/presensi/loginAbsen/bindings/login_absen_binding.dart';
import '../modules/presensi/loginAbsen/views/login_absen_view.dart';
import '../modules/presensi/lokasi_mati/bindings/lokasi_mati_binding.dart';
import '../modules/presensi/lokasi_mati/views/lokasi_mati_view.dart';
import '../modules/presensi/lokasi_palsu/bindings/lokasi_palsu_binding.dart';
import '../modules/presensi/lokasi_palsu/views/lokasi_palsu_view.dart';
import '../modules/presensi/mainAbsen/bindings/main_absen_binding.dart';
import '../modules/presensi/mainAbsen/views/main_absen_view.dart';
import '../modules/presensi/profile/bindings/profile_binding.dart';
import '../modules/presensi/profile/views/profile_view.dart';
import '../modules/presensi/rosterKerja/bindings/roster_kerja_binding.dart';
import '../modules/presensi/rosterKerja/views/roster_kerja_view.dart';
import '../modules/sarpras/barcode_security/bindings/barcode_security_binding.dart';
import '../modules/sarpras/barcode_security/views/barcode_security_view.dart';
import '../modules/sarpras/bukti_dilokasi/bindings/bukti_dilokasi_binding.dart';
import '../modules/sarpras/bukti_dilokasi/views/bukti_dilokasi_view.dart';
import '../modules/sarpras/form_izin_keluar/bindings/form_izin_keluar_binding.dart';
import '../modules/sarpras/form_izin_keluar/views/form_izin_keluar_view.dart';
import '../modules/sarpras/form_sarana/bindings/form_sarana_binding.dart';
import '../modules/sarpras/form_sarana/views/form_sarana_view.dart';
import '../modules/sarpras/menu_sarpras/bindings/menu_sarpras_binding.dart';
import '../modules/sarpras/menu_sarpras/views/menu_sarpras_view.dart';
import '../modules/sarpras/nomor_lambung/bindings/nomor_lambung_binding.dart';
import '../modules/sarpras/nomor_lambung/views/nomor_lambung_view.dart';
import '../modules/sarpras/penumpang/bindings/penumpang_binding.dart';
import '../modules/sarpras/penumpang/views/penumpang_view.dart';
import '../modules/sarpras/sarpras_admin/bindings/sarpras_admin_binding.dart';
import '../modules/sarpras/sarpras_admin/views/sarpras_admin_view.dart';
import '../modules/sarpras/sarpras_detail/bindings/sarpras_detail_binding.dart';
import '../modules/sarpras/sarpras_detail/views/sarpras_detail_view.dart';
import '../modules/sarpras/sarpras_hc/bindings/sarpras_hc_binding.dart';
import '../modules/sarpras/sarpras_hc/views/sarpras_hc_view.dart';
import '../modules/sarpras/sarpras_it/bindings/sarpras_it_binding.dart';
import '../modules/sarpras/sarpras_it/views/sarpras_it_view.dart';
import '../modules/sarpras/sarpras_kabag/bindings/sarpras_kabag_binding.dart';
import '../modules/sarpras/sarpras_kabag/views/sarpras_kabag_view.dart';
import '../modules/sarpras/sarpras_kordinator/bindings/sarpras_kordinator_binding.dart';
import '../modules/sarpras/sarpras_kordinator/views/sarpras_kordinator_view.dart';
import '../modules/sarpras/sarpras_ktt/bindings/sarpras_ktt_binding.dart';
import '../modules/sarpras/sarpras_ktt/views/sarpras_ktt_view.dart';
import '../modules/sarpras/sarpras_pdf/bindings/sarpras_pdf_binding.dart';
import '../modules/sarpras/sarpras_pdf/views/sarpras_pdf_view.dart';
import '../modules/sarpras/sarpras_section/bindings/sarpras_section_binding.dart';
import '../modules/sarpras/sarpras_section/views/sarpras_section_view.dart';
import '../modules/sarpras/sarpras_security/bindings/sarpras_security_binding.dart';
import '../modules/sarpras/sarpras_security/views/sarpras_security_view.dart';
import '../modules/sarpras/sarpras_user/bindings/sarpras_user_binding.dart';
import '../modules/sarpras/sarpras_user/views/sarpras_user_view.dart';
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
      page: () => const AbsensiVPSView(),
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
      page: () => AbsenMasukView(),
      binding: AbsenMasukBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN_PULANG,
      page: () => const AbsenPulangView(),
      binding: AbsenPulangBinding(),
    ),
    GetPage(
      name: _Paths.CORRECTIVE_ACTION,
      page: () => const CorrectiveActionView(),
      binding: CorrectiveActionBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_ABP,
      page: () => ProfileAbpView(),
      binding: ProfileAbpBinding(),
    ),
    GetPage(
      name: _Paths.HAZARD_LIST,
      page: () => const HazardListView(),
      binding: HazardListBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HAZARD,
      page: () => const DetailHazardView(),
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
    GetPage(
      name: _Paths.RUBAH_STATUS,
      page: () => RubahStatusView(),
      binding: RubahStatusBinding(),
    ),
    GetPage(
      name: _Paths.RUBAH_BAHAYA,
      page: () => RubahBahayaView(),
      binding: RubahBahayaBinding(),
    ),
    GetPage(
      name: _Paths.RUBAH_K_T_A,
      page: () => RubahKTAView(),
      binding: RubahKTABinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ABSENSI,
      page: () => const DetailAbsensiView(),
      binding: DetailAbsensiBinding(),
    ),
    GetPage(
      name: _Paths.RKB,
      page: () => const RkbView(),
      binding: RkbBinding(),
    ),
    GetPage(
      name: _Paths.RKB_DETAIL,
      page: () => const RkbDetailView(),
      binding: RkbDetailBinding(),
    ),
    GetPage(
      name: _Paths.RKB_PURCHASING,
      page: () => const RkbPurchasingView(),
      binding: RkbPurchasingBinding(),
    ),
    GetPage(
      name: _Paths.RKB_ADMIN,
      page: () => const RkbAdminView(),
      binding: RkbAdminBinding(),
    ),
    GetPage(
      name: _Paths.RKB_KABAG,
      page: () => RkbKabagView(),
      binding: RkbKabagBinding(),
    ),
    GetPage(
      name: _Paths.RKB_SECTION,
      page: () => const RkbSectionView(),
      binding: RkbSectionBinding(),
    ),
    GetPage(
      name: _Paths.RKB_KTT,
      page: () => const RkbKttView(),
      binding: RkbKttBinding(),
    ),
    GetPage(
      name: _Paths.RKB_MENU,
      page: () => const RkbMenuView(),
      binding: RkbMenuBinding(),
    ),
    GetPage(
      name: _Paths.RKB_LAMPIRAN,
      page: () => const RkbLampiranView(),
      binding: RkbLampiranBinding(),
    ),
    GetPage(
      name: _Paths.RKB_DEPT,
      page: () => const RkbDeptView(),
      binding: RkbDeptBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KABAG,
      page: () => const DetailKabagView(),
      binding: DetailKabagBinding(),
    ),
    GetPage(
      name: _Paths.PESAN,
      page: () => const PesanView(),
      binding: PesanBinding(),
    ),
    GetPage(
      name: _Paths.RKB_PDF,
      page: () => const RkbPdfView(),
      binding: RkbPdfBinding(),
    ),
    GetPage(
      name: _Paths.LOKASI_PALSU,
      page: () => const LokasiPalsuView(),
      binding: LokasiPalsuBinding(),
    ),
    GetPage(
      name: _Paths.MENU_SARPRAS,
      page: () => const MenuSarprasView(),
      binding: MenuSarprasBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_USER,
      page: () => const SarprasUserView(),
      binding: SarprasUserBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_KABAG,
      page: () => const SarprasKabagView(),
      binding: SarprasKabagBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_KTT,
      page: () => const SarprasKttView(),
      binding: SarprasKttBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_HC,
      page: () => const SarprasHcView(),
      binding: SarprasHcBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_SECTION,
      page: () => const SarprasSectionView(),
      binding: SarprasSectionBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_ADMIN,
      page: () => const SarprasAdminView(),
      binding: SarprasAdminBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_KORDINATOR,
      page: () => const SarprasKordinatorView(),
      binding: SarprasKordinatorBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_SECURITY,
      page: () => const SarprasSecurityView(),
      binding: SarprasSecurityBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_IT,
      page: () => const SarprasItView(),
      binding: SarprasItBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_DETAIL,
      page: () => const SarprasDetailView(),
      binding: SarprasDetailBinding(),
    ),
    GetPage(
      name: _Paths.SARPRAS_PDF,
      page: () => const SarprasPdfView(),
      binding: SarprasPdfBinding(),
    ),
    GetPage(
      name: _Paths.FORM_SARANA,
      page: () => const FormSaranaView(),
      binding: FormSaranaBinding(),
    ),
    GetPage(
      name: _Paths.FORM_IZIN_KELUAR,
      page: () => const FormIzinKeluarView(),
      binding: FormIzinKeluarBinding(),
    ),
    GetPage(
      name: _Paths.NOMOR_LAMBUNG,
      page: () => const NomorLambungView(),
      binding: NomorLambungBinding(),
    ),
    GetPage(
      name: _Paths.PENUMPANG,
      page: () => PenumpangView(),
      binding: PenumpangBinding(),
    ),
    GetPage(
      name: _Paths.BUKTI_DILOKASI,
      page: () => const BuktiDilokasiView(),
      binding: BuktiDilokasiBinding(),
    ),
    GetPage(
      name: _Paths.BARCODE_SECURITY,
      page: () => const BarcodeSecurityView(),
      binding: BarcodeSecurityBinding(),
    ),
    GetPage(
      name: _Paths.LOKASI_MATI,
      page: () => const LokasiMatiView(),
      binding: LokasiMatiBinding(),
    ),    GetPage(
      name: _Paths.MONITORING,
      page: () => MonitoringView(),
      binding: MonitoringBinding(),
      children: [
        GetPage(
          name: _Paths.MONITORING_OB_DLAY,
          page: () => MonitoringObDlayView(),
          binding: MonitoringObDlayBinding(),
        ),
        GetPage(
          name: _Paths.MONITORING_HAULING_DELAY,
          page: () => MonitoringHaulingDelayView(),
          binding: MonitoringHaulingDelayBinding(),
        ),
        GetPage(
          name: _Paths.MONITORING_TUGBOAT,
          page: () => MonitoringTugboatView(),
          binding: MonitoringTugboatBinding(),
        ),
      ],
    ),
    GetPage(
        name: _Paths.MONITORING_O_B,
        page: () => MonitoringOBView(),
        binding: MonitoringOBBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.MONITORING_HAULING,
      page: () => MonitoringHaulingView(),
      binding: MonitoringHaulingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: _Paths.MONITORING_CRUSHING,
        page: () => MonitoringCrushingView(),
        binding: MonitoringCrushingBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.MONITORING_BARGING,
        page: () => MonitoringBargingView(),
        binding: MonitoringBargingBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.MONITORING_STOCK_ROM,
        page: () => MonitoringStockRomView(),
        binding: MonitoringStockRomBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.MONITORING_STOCK_PRODUCT,
        page: () => MonitoringStockProductView(),
        binding: MonitoringStockProductBinding(),
        transition: Transition.fadeIn),
  ];
}

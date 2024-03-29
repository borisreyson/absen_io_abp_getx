part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const LOGIN_ABSEN = _Paths.LOGIN_ABSEN;
  static const BULETIN = _Paths.BULETIN;
  static const ABSENSI = _Paths.ABSENSI;
  static const MENU_ABP = _Paths.MENU_ABP;
  static const SPLASH = _Paths.SPLASH;
  static const KAMERA = _Paths.KAMERA;
  static const LOKASI = _Paths.LOKASI;
  static const PENIMPANAN = _Paths.PENIMPANAN;
  static const NOTIFIKASI = _Paths.NOTIFIKASI;
  static const GALERY = _Paths.GALERY;
  static const PROFILE = _Paths.PROFILE;
  static const MAIN_ABSEN = _Paths.MAIN_ABSEN;
  static const ABSENSI_V_P_S = _Paths.ABSENSI_V_P_S;
  static const LIST_ABSEN = _Paths.LIST_ABSEN;
  static const ROSTER_KERJA = _Paths.ROSTER_KERJA;
  static const GRAFIK_KEHADIRAN = _Paths.GRAFIK_KEHADIRAN;
  static const ABSEN_MASUK = _Paths.ABSEN_MASUK;
  static const ABSEN_PULANG = _Paths.ABSEN_PULANG;
  static const CORRECTIVE_ACTION = _Paths.CORRECTIVE_ACTION;
  static const PROFILE_ABP = _Paths.PROFILE_ABP;
  static const HAZARD_LIST = _Paths.HAZARD_LIST;
  static const DETAIL_HAZARD = _Paths.DETAIL_HAZARD;
  static const RUBAH_HAZARD = _Paths.RUBAH_HAZARD;
  static const IMAGE_HAZARD_VIEW = _Paths.IMAGE_HAZARD_VIEW;
  static const HAZARD_USER = _Paths.HAZARD_USER;
  static const HAZARD_P_J = _Paths.HAZARD_P_J;
  static const FORM_HAZARD = _Paths.FORM_HAZARD;
  static const LIST_USER = _Paths.LIST_USER;
  static const KEMUNGKINAN = _Paths.KEMUNGKINAN;
  static const KEPARAHAN = _Paths.KEPARAHAN;
  static const PENGENDALIAN = _Paths.PENGENDALIAN;
  static const LOKASI_HAZARD = _Paths.LOKASI_HAZARD;
  static const PERUSAHAAN = _Paths.PERUSAHAAN;
  static const RUBAH_STATUS = _Paths.RUBAH_STATUS;
  static const RUBAH_BAHAYA = _Paths.RUBAH_BAHAYA;
  static const RUBAH_K_T_A = _Paths.RUBAH_K_T_A;
  static const DETAIL_ABSENSI = _Paths.DETAIL_ABSENSI;
  static const RKB = _Paths.RKB;
  static const RKB_DETAIL = _Paths.RKB_DETAIL;
  static const RKB_PURCHASING = _Paths.RKB_PURCHASING;
  static const RKB_ADMIN = _Paths.RKB_ADMIN;
  static const RKB_KABAG = _Paths.RKB_KABAG;
  static const RKB_SECTION = _Paths.RKB_SECTION;
  static const RKB_KTT = _Paths.RKB_KTT;
  static const RKB_MENU = _Paths.RKB_MENU;
  static const RKB_LAMPIRAN = _Paths.RKB_LAMPIRAN;
  static const RKB_DEPT = _Paths.RKB_DEPT;
  static const DETAIL_KABAG = _Paths.DETAIL_KABAG;
  static const PESAN = _Paths.PESAN;
  static const RKB_PDF = _Paths.RKB_PDF;
  static const LOKASI_PALSU = _Paths.LOKASI_PALSU;
  static const SARPRAS = _Paths.SARPRAS;
  static const MENU_SARPRAS = _Paths.MENU_SARPRAS;
  static const SARPRAS_USER = _Paths.SARPRAS_USER;
  static const SECURITY = _Paths.SECURITY;
  static const KABAG = _Paths.KABAG;
  static const KTT = _Paths.KTT;
  static const SARPRAS_KABAG = _Paths.SARPRAS_KABAG;
  static const SARPRAS_KTT = _Paths.SARPRAS_KTT;
  static const SARPRAS_HC = _Paths.SARPRAS_HC;
  static const SARPRAS_SECTION = _Paths.SARPRAS_SECTION;
  static const SARPRAS_ADMIN = _Paths.SARPRAS_ADMIN;
  static const SARPRAS_KORDINATOR = _Paths.SARPRAS_KORDINATOR;
  static const SARPRAS_SECURITY = _Paths.SARPRAS_SECURITY;
  static const SARPRAS_IT = _Paths.SARPRAS_IT;
  static const SARPRAS_DETAIL = _Paths.SARPRAS_DETAIL;
  static const SARPRAS_PDF = _Paths.SARPRAS_PDF;
  static const FORM_SARANA = _Paths.FORM_SARANA;
  static const FORM_IZIN_KELUAR = _Paths.FORM_IZIN_KELUAR;
  static const NOMOR_LAMBUNG = _Paths.NOMOR_LAMBUNG;
  static const PENUMPANG = _Paths.PENUMPANG;
  static const BUKTI_DILOKASI = _Paths.BUKTI_DILOKASI;
  static const BARCODE_SECURITY = _Paths.BARCODE_SECURITY;
  static const LOKASI_MATI =  _Paths.LOKASI_MATI;
    static const MONITORING = _Paths.MONITORING;
  static const MONITORING_O_B = _Paths.MONITORING_O_B;
  static const MONITORING_HAULING = _Paths.MONITORING_HAULING;
  static const MONITORING_CRUSHING = _Paths.MONITORING_CRUSHING;
  static const MONITORING_BARGING = _Paths.MONITORING_BARGING;
  static const MONITORING_STOCK_ROM = _Paths.MONITORING_STOCK_ROM;
  static const MONITORING_STOCK_PRODUCT = _Paths.MONITORING_STOCK_PRODUCT;
  static const MONITORING_OB_DLAY =
      _Paths.MONITORING + _Paths.MONITORING_OB_DLAY;
  static const MONITORING_HAULING_DELAY =
      _Paths.MONITORING + _Paths.MONITORING_HAULING_DELAY;
  static const MONITORING_TUGBOAT =
      _Paths.MONITORING + _Paths.MONITORING_TUGBOAT;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const LOGIN_ABSEN = '/login-absen';
  static const BULETIN = '/buletin';
  static const ABSENSI = '/absensi';
  static const MENU_ABP = '/menu-abp';
  static const SPLASH = '/splash';
  static const KAMERA = '/kamera';
  static const LOKASI = '/lokasi';
  static const PENIMPANAN = '/penimpanan';
  static const NOTIFIKASI = '/notifikasi';
  static const GALERY = '/galery';
  static const PROFILE = '/profile';
  static const MAIN_ABSEN = '/main-absen';
  static const ABSENSI_V_P_S = '/absensi-v-p-s';
  static const LIST_ABSEN = '/list-absen';
  static const ROSTER_KERJA = '/roster-kerja';
  static const GRAFIK_KEHADIRAN = '/grafik-kehadiran';
  static const ABSEN_MASUK = '/absen-masuk';
  static const ABSEN_PULANG = '/absen-pulang';
  static const CORRECTIVE_ACTION = '/corrective-action';
  static const PROFILE_ABP = '/profile-abp';
  static const HAZARD_LIST = '/hazard-list';
  static const DETAIL_HAZARD = '/detail-hazard';
  static const RUBAH_HAZARD = '/rubah-hazard';
  static const IMAGE_HAZARD_VIEW = '/image-hazard-view';
  static const HAZARD_USER = '/hazard-user';
  static const HAZARD_P_J = '/hazard-p-j';
  static const HSE = '/hse';
  static const FORM_HAZARD = '/form-hazard';
  static const LIST_USER = '/list-user';
  static const KEMUNGKINAN = '/kemungkinan';
  static const KEPARAHAN = '/keparahan';
  static const PENGENDALIAN = '/pengendalian';
  static const LOKASI_HAZARD = '/lokasi-hazard';
  static const PERUSAHAAN = '/perusahaan';
  static const RUBAH_STATUS = '/rubah-status';
  static const RUBAH_BAHAYA = '/rubah-bahaya';
  static const RUBAH_K_T_A = '/rubah-k-t-a';
  static const DETAIL_ABSENSI = '/detail-absensi';
  static const HGE = '/hge';
  static const RKB = '/rkb';
  static const RKB_DETAIL = '/rkb-detail';
  static const RKB_PURCHASING = '/rkb-purchasing';
  static const RKB_ADMIN = '/rkb-admin';
  static const RKB_KABAG = '/rkb-kabag';
  static const RKB_SECTION = '/rkb-section';
  static const RKB_KTT = '/rkb-ktt';
  static const RKB_MENU = '/rkb-menu';
  static const RKB_LAMPIRAN = '/rkb-lampiran';
  static const RKB_DEPT = '/rkb-dept';
  static const DETAIL_KABAG = '/detail-kabag';
  static const PESAN = '/pesan';
  static const RKB_PDF = '/rkb-pdf';
  static const LOKASI_PALSU = '/lokasi-palsu';
  static const SARPRAS = '/sarpras';
  static const MENU_SARPRAS = '/menu-sarpras';
  static const SARPRAS_USER = '/sarpras-user';
  static const SECURITY = '/security';
  static const KABAG = '/kabag';
  static const KTT = '/ktt';
  static const SARPRAS_KABAG = '/sarpras-kabag';
  static const SARPRAS_KTT = '/sarpras-ktt';
  static const SARPRAS_HC = '/sarpras-hc';
  static const SARPRAS_SECTION = '/sarpras-section';
  static const SARPRAS_ADMIN = '/sarpras-admin';
  static const SARPRAS_KORDINATOR = '/sarpras-kordinator';
  static const SARPRAS_SECURITY = '/sarpras-security';
  static const SARPRAS_IT = '/sarpras-it';
  static const SARPRAS_DETAIL = '/sarpras-detail';
  static const SARPRAS_PDF = '/sarpras-pdf';
  static const FORM_SARANA = '/form-sarana';
  static const FORM_IZIN_KELUAR = '/form-izin-keluar';
  static const NOMOR_LAMBUNG = '/nomor-lambung';
  static const PENUMPANG = '/penumpang';
  static const BUKTI_DILOKASI = '/bukti-dilokasi';
  static const BARCODE_SECURITY = '/barcode-security';
  static const LOKASI_MATI = '/lokasi-mati';
    static const MONITORING = '/monitoring';
  static const MONITORING_O_B = '/monitoring-o-b';
  static const MONITORING_HAULING = '/monitoring-hauling';
  static const MONITORING_CRUSHING = '/monitoring-crushing';
  static const MONITORING_BARGING = '/monitoring-barging';
  static const MONITORING_STOCK_ROM = '/monitoring-stock-rom';
  static const MONITORING_STOCK_PRODUCT = '/monitoring-stock-product';
  static const MONITORING_OB_DLAY = '/monitoring-ob-dlay';
  static const MONITORING_HAULING_DELAY = '/monitoring-hauling-delay';
  static const MONITORING_TUGBOAT = '/monitoring-tugboat';
}

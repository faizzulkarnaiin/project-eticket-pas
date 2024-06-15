import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/bus/bindings/bus_binding.dart';
import '../modules/bus/views/bus_view.dart';
import '../modules/createBus/bindings/create_bus_binding.dart';
import '../modules/createBus/views/create_bus_view.dart';
import '../modules/createDiskon/bindings/create_diskon_binding.dart';
import '../modules/createDiskon/views/create_diskon_view.dart';
import '../modules/createJadwal/bindings/create_jadwal_binding.dart';
import '../modules/createJadwal/views/create_jadwal_view.dart';
import '../modules/createPayment/bindings/create_payment_binding.dart';
import '../modules/createPayment/views/create_payment_view.dart';
import '../modules/createTicket/bindings/create_ticket_binding.dart';
import '../modules/createTicket/views/create_ticket_view.dart';
import '../modules/diskon/bindings/diskon_binding.dart';
import '../modules/diskon/views/diskon_view.dart';
import '../modules/editBus/bindings/edit_bus_binding.dart';
import '../modules/editBus/views/edit_bus_view.dart';
import '../modules/editDiskon/bindings/edit_diskon_binding.dart';
import '../modules/editDiskon/views/edit_diskon_view.dart';
import '../modules/editJadwal/bindings/edit_jadwal_binding.dart';
import '../modules/editJadwal/views/edit_jadwal_view.dart';
import '../modules/editPayment/bindings/edit_payment_binding.dart';
import '../modules/editPayment/views/edit_payment_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/jadwalBus/bindings/jadwal_bus_binding.dart';
import '../modules/jadwalBus/views/jadwal_bus_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/paymenyMethod/bindings/paymeny_method_binding.dart';
import '../modules/paymenyMethod/views/paymeny_method_view.dart';
import '../modules/qrScan/bindings/qr_scan_binding.dart';
import '../modules/qrScan/views/qr_scan_view.dart';
import '../modules/qrView/bindings/qr_view_binding.dart';
import '../modules/qrView/views/qr_view_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/resetPassword/bindings/reset_password_binding.dart';
import '../modules/resetPassword/views/reset_password_view.dart';
import '../modules/scan/bindings/scan_binding.dart';
import '../modules/scan/views/scan_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

// ignore_for_file: prefer_const_constructors

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => const AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_BUS,
      page: () => const CreateBusView(),
      binding: CreateBusBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL_BUS,
      page: () => const JadwalBusView(),
      binding: JadwalBusBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENY_METHOD,
      page: () => const PaymenyMethodView(),
      binding: PaymenyMethodBinding(),
    ),
    GetPage(
      name: _Paths.SCAN,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: _Paths.BUS,
      page: () => const BusView(),
      binding: BusBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_BUS,
      page: () => const EditBusView(),
      binding: EditBusBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_JADWAL,
      page: () => const CreateJadwalView(),
      binding: CreateJadwalBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_JADWAL,
      page: () => const EditJadwalView(),
      binding: EditJadwalBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PAYMENT,
      page: () => const CreatePaymentView(),
      binding: CreatePaymentBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PAYMENT,
      page: () => const EditPaymentView(),
      binding: EditPaymentBinding(),
    ),
    GetPage(
      name: _Paths.DISKON,
      page: () => const DiskonView(),
      binding: DiskonBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_DISKON,
      page: () => const CreateDiskonView(),
      binding: CreateDiskonBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_DISKON,
      page: () => const EditDiskonView(),
      binding: EditDiskonBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TICKET,
      page: () => const CreateTicketView(),
      binding: CreateTicketBinding(),
    ),
    GetPage(
      name: _Paths.QR_VIEW,
      page: () => const QrViewView(),
      binding: QrViewBinding(),
    ),
    GetPage(
      name: _Paths.QR_SCAN,
      page: () =>  QrScanView(),
      binding: QrScanBinding(),
    ),
  ];
}

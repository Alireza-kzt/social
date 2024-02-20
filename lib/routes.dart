import 'package:get/get.dart';
import 'package:social/features/messenger/view/pages/messenger_page.dart';
import 'package:social/features/share_experience/profile/controller/share_experience_profile_activities_controller.dart';
import 'package:social/features/share_experience/profile/view/pages/edit_share_experience_profile_page.dart';
import 'package:social/features/share_experience/profile/view/pages/share_experience_profile_page.dart';
import 'package:social/features/share_experience/topic/view/pages/share_experience_topic_page.dart';
import 'core/app/constants/app_routes.dart';
import 'core/features/scaffold/app_scaffold_bindings.dart';
import 'core/features/scaffold/view/pages/app_scaffold_page.dart';
import 'core/features/splash/splash_bindings.dart';
import 'core/features/splash/view/pages/splash_page.dart';
import 'features/authentication/login/login_bindings.dart';
import 'features/authentication/login/view/pages/login_page.dart';
import 'features/authentication/login/view/pages/new_password_page.dart';
import 'features/authentication/login/view/pages/register_number_page.dart';
import 'features/authentication/login/view/pages/verify_code_page.dart';
import 'features/messenger/messanger_bindings.dart';
import 'features/profile/profile_bindings.dart';
import 'features/profile/view/pages/activity_page.dart';
import 'features/profile/view/pages/edit_profile_page.dart';
import 'features/report/report_bindings.dart';
import 'features/report/view/pages/financial_report_page.dart';
import 'features/report/view/pages/rating_report_page.dart';
import 'features/report/view/pages/ticket_report_page.dart';
import 'features/share_experience/comments/comment_bindings.dart';
import 'features/share_experience/profile/share_experience_profile_bindings.dart';
import 'features/share_experience/profile/view/pages/share_experience_profile_activities_page.dart';
import 'features/share_experience/share_exerience_bindings.dart';
import 'features/share_experience/comments/view/pages/share_experience_comment_page.dart';
import 'features/share_experience/social/topic_bindings.dart';
import 'features/ticket/ticket_bindings.dart';

class Routs {
  static List<GetPage> routs = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: AppRoutes.root,
      page: () => const AppScaffoldPage(),
      bindings: [
        TicketBindings(),
        ProfileBindings(),
        ReportOverviewBindings(),
        ShareExperienceBindings(),
        UploadShareExperienceBindings(),
      ]..add(AppScaffoldBindings()), // Must be last bindings
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: AppRoutes.number,
      page: () => const RegisterNumberPage(),
      binding: RegisterOtpBindings(),
    ),
    GetPage(
      name: AppRoutes.verifyCode,
      page: () => const VerifyCodePage(),
      binding: VerifyCodeBindings(),
    ),
    GetPage(
      name: AppRoutes.newPassword,
      page: () => const NewPasswordPage(),
      binding: NewPasswordBindings(),
    ),
    GetPage(
      name: AppRoutes.activity,
      page: () => const ActivityPage(),
      binding: SettingBindings(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfilePage(),
      bindings: [EditProfileBindings(), UploadProfileBindings()],
    ),
    GetPage(
      name: AppRoutes.rateReport,
      page: () => const RatingReportPage(),
      binding: RateReportBindings(),
    ),
    GetPage(
      name: AppRoutes.financialReport,
      page: () => const FinancialReportPage(),
      binding: FinancialBindings(),
    ),
    GetPage(
      name: AppRoutes.ticketReport,
      page: () => const TicketReportPage(),
      binding: TicketReportBindings(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const MessengerPage(),
      bindings: [
        MessengerBindings(),
        FileBindings(),
      ],
    ),
    GetPage(
      name: AppRoutes.topic,
      page: () => const ShareExperienceTopicPage(),
      binding: TopicBindings(),
    ),
    GetPage(
      name: AppRoutes.comment,
      page: () => const ShareExperienceCommentPage(),
      binding: CommentBindings(),
    ),
    GetPage(
      name: AppRoutes.shareExperienceProfile,
      page: () => const ShareExperienceProfilePage(),
      binding: ShareExperienceProfileBindings(),
    ),
    GetPage(
      name: AppRoutes.profileActivity,
      page: () => const shareExperienceProfileActivitiesPage(),
      binding: ShareExperienceProfileActivityBindings(),
    ),
    GetPage(
      name: AppRoutes.editShareExperienceProfile,
      page: () => const EditShareExperienceProfilePage(),
      binding: EditShareExperienceProfileBindings(),
    ),
  ];
}

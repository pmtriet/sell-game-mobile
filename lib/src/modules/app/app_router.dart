import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../auth/presentation/pages/login_page/login_page.dart';
import '../buy/infrastructor/models/category_product.dart';
import '../forgot_password/presentation/pages/account_verification_page.dart';
import '../forgot_password/presentation/pages/resend_email_page.dart';
import '../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../management_post/presentation/page/management_post_page.dart';
import '../my_rating/presentation/page/my_rating_page.dart';
import '../order_history/presentation/page/order_history_page.dart';
import '../post/presentation/pages/post_page.dart';
import '../preview/infrastructure/model/post_model.dart';
import '../preview/presentation/page/preview_page.dart';
import '../rating/presentation/page/rating_page.dart';
import '../register/presentation/page/register_page.dart';
import '../categories_all/presentation/page/categories_all_page.dart';
import '../edition_infor/presentation/pages/name_edition_page.dart';
import '../edition_infor/presentation/pages/phone_edition_page.dart';
import '../edition_infor/presentation/pages/phone_verification_page.dart';
import '../home/domain/entities/category.dart';
import '../info_order/presentation/pages/info_order_page.dart';
import '../order/presentation/pages/order_page.dart';
import '../personal_profile/presentation/pages/personal_profile_page.dart';
import '../personal_profile_edit/presentation/pages/personalprofile_edit_page.dart';
import '../buy/presentation/pages/buy_page.dart';
import '../report/presentation/page/report_page.dart';
import '../saved_post/presentation/pages/saved_post_page.dart';
import '../search/presentation/pages/search_page.dart';
import '../search/presentation/pages/search_results_page.dart';
import '../setting_account/presentation/pages/setting_account_page.dart';
import '../shop_profile/presentation/page/shop_profile_page.dart';
import '../tabbar/presentation/pages/tabbar_page.dart';
import '../../modules/splash/presentation/pages/splash_page.dart';
import '../category/presentation/pages/category_page.dart';
import '../settings/presentation/pages/settings_page.dart';
import '../supportive/presentation/pages/supportive_page.dart';
import '../product/presentation/pages/product_page.dart';
import '../view_update_preview_post/infrastructure/models/user_product_model.dart';
import '../view_update_preview_post/presentation/page/preview_post_page.dart';
import '../view_update_preview_post/presentation/page/update_post_page.dart';
import '../view_update_preview_post/presentation/page/view_post_page.dart';
import '../webview/web_view_page.dart';
import '../withdraw/presentation/pages/bank_edition_page.dart';
import '../withdraw/presentation/pages/bank_search_page.dart';
import '../withdraw/presentation/pages/withdraw_money_page.dart';
import '../transaction_history/presentation/pages/transaction_history_page.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/'),
        AutoRoute(page: TabBarRoute.page),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: CategoryRoute.page),
        AutoRoute(page: PostRoute.page),
        AutoRoute(page: PreviewRoute.page),
        AutoRoute(page: CategoriesAllRoute.page),
        AutoRoute(page: PersonalProfileRoute.page),
        AutoRoute(page: PersonalProfileEditRoute.page),
        AutoRoute(page: PhoneEditionRoute.page),
        AutoRoute(page: PhoneVerificationRoute.page),
        AutoRoute(page: NameEditionRoute.page),
        AutoRoute(page: WithdrawMoneyRoute.page),
        AutoRoute(page: BankEditionRoute.page),
        AutoRoute(page: BankSearchRoute.page),
        AutoRoute(page: TransactionHistoryRoute.page),
        AutoRoute(page: SettingAccountRoute.page),
        AutoRoute(page: SupportiveRoute.page),
        AutoRoute(page: ProductRoute.page),
        AutoRoute(page: BuyRoute.page),
        AutoRoute(page: SavedPostRoute.page),
        AutoRoute(page: OrderRoute.page),
        AutoRoute(page: InfoOrderRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: ShopProfileRoute.page),
        AutoRoute(page: SearchResultsRoute.page),
        AutoRoute(page: ManagementPostRoute.page),
        AutoRoute(page: ViewPostRoute.page),
        AutoRoute(page: UpdatePostRoute.page),
        AutoRoute(page: PreviewPostRoute.page),
        AutoRoute(page: RatingRoute.page),
        AutoRoute(page: MyRatingRoute.page),
        AutoRoute(page: ResendEmailRoute.page),
        AutoRoute(page: AccountVerificationRoute.page),
        AutoRoute(page: OrderHistoryRoute.page),
        AutoRoute(page: ReportRoute.page),
        AutoRoute(page: WebViewRoute.page),
      ];
}

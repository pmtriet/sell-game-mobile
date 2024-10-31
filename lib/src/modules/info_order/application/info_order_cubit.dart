import 'package:bloc/bloc.dart';

import '../../../common/mixin/cancelable_base_bloc.dart';
import '../infrastructure/models/info_order_model.dart';
import 'info_order_state.dart';

class InfoOrderCubit extends Cubit<InfoOrderState> with CancelableBaseBloc<InfoOrderState>{
  final int orderId;

  InfoOrderCubit(this.orderId) : super(const InfoOrderState.loading()) {
    fetchOrderInfo();
  }

  // Giả lập gọi API để lấy thông tin đơn hàng
  void fetchOrderInfo() async {
    try {
      await Future.delayed(
          const Duration(seconds: 2)); 
      final orderInfo = InfoOrderModel(
        orderId: orderId,
        orderCode: '1234567890',
        orderTime: DateTime.now(),
        totalPayment: 700000,
        discountCode: 0,
        finalPrice: 700000,
        imagePath: 'assets/images/home_default_img_slider.webp',
        title: 'Tướng 167 | Trang phục 208 | Linh thú 3',
        gameName: 'Liên Quân',
        productId: '1234567890',
        price: 700000,
        heroes: '96',
        skins: '150',
        rank: 'Kim Cương',
      );
      emit(InfoOrderState.loaded(orderInfo));
    } catch (e) {
      emit(const InfoOrderState.error('Failed to fetch order info'));
    }
  }
}

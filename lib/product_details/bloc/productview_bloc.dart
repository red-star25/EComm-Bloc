import 'package:bloc/bloc.dart';
import 'package:ecomm/data/repository/app_repository.dart';
import 'package:ecomm/product_details/data/repository/product_view_repository.dart';
import 'package:equatable/equatable.dart';

part 'productview_event.dart';
part 'productview_state.dart';

class ProductviewBloc extends Bloc<ProductviewEvent, ProductviewState> {
  ProductviewBloc({
    required this.productViewRepository,
    required this.appRepository,
  }) : super(ProductviewInitial()) {
    on<ProductIdsFetchFromCartEvent>(_fetchIdsFromCart);
    on<ProductAddedToCartEvent>(_addProductToCart);
    on<ProductRemoveFromCart>(_removeProductFromCart);
  }
  final ProductViewRepository productViewRepository;
  final AppRepository appRepository;

  Future<void> _fetchIdsFromCart(
    ProductviewEvent event,
    Emitter<ProductviewState> emit,
  ) async {
    emit(ProductViewLoading());
    try {
      final productIds = await productViewRepository
          .fetchCartProductIds(appRepository.userId!);
      emit(ProductIdsFetchFromCartSuccess(productIds: productIds));
    } catch (e) {
      emit(ProductViewError(message: e.toString()));
    }
  }

  Future<void> _addProductToCart(
    ProductAddedToCartEvent event,
    Emitter<ProductviewState> emit,
  ) async {
    emit(ProductViewLoading());
    try {
      await productViewRepository.addProductToCart(
        event.productId,
        appRepository.userId!,
      );
      final productIds = await productViewRepository
          .fetchCartProductIds(appRepository.userId!);
      emit(ProductIdsFetchFromCartSuccess(productIds: productIds));
    } catch (e) {
      emit(ProductViewError(message: e.toString()));
    }
  }

  Future<void> _removeProductFromCart(
    ProductRemoveFromCart event,
    Emitter<ProductviewState> emit,
  ) async {
    emit(ProductViewLoading());
    try {
      await productViewRepository.removeProductFromCart(
        event.productId,
        appRepository.userId!,
      );
      final productIds = await productViewRepository
          .fetchCartProductIds(appRepository.userId!);
      emit(ProductIdsFetchFromCartSuccess(productIds: productIds));
    } catch (e) {
      emit(ProductViewError(message: e.toString()));
    }
  }
}

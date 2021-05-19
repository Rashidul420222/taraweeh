import '../constants/route_names.dart';
import '../locator.dart';
import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToCreateView() =>
      _navigationService.navigateTo(CreatePostViewRoute);
}

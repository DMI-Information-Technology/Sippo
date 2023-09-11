// import 'package:flutter/cupertino.dart';
//
// enum PagedStatus { ERROR, SUCCESS, COMPLETED, LOADING }
// class PagedState<KeyType, DataType>{
//
//   final List<DataType> listItems = [];
//   // PagedState get status{
//   //
//   // }
// }
// class PaginationScrollViewController<KeyType, DataType> extends ChangeNotifier {
//
//   final scrollController = ScrollController();
//   final List<DataType> listItems = [];
//
//   void addNewPage(List<DataType> newItems, [bool isLastPage = false]) {
//     listItems.addAll(newItems);
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
//
// class CustomPaginationScrollView<KeyType, DataType> extends StatelessWidget {
//   const CustomPaginationScrollView({
//     super.key,
//     required this.controller,
//     required this.itemCount,
//     required this.itemBuilder,
//     required this.separatorBuilder,
//   });
//
//   final PaginationScrollViewController controller;
//   final Widget Function(BuildContext context, DataType item, int index)
//       itemBuilder;
//   final Widget Function(BuildContext context, int index) separatorBuilder;
//   final int itemCount;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: controller,
//       builder: (context, child) {
//         return ListView.separated(
//           itemBuilder: (context, index) {
//             final item = controller.listItems[index];
//             itemBuilder(context, item, index);
//           },
//           separatorBuilder: separatorBuilder,
//           itemCount: controller.listItems.length + 1,
//         );
//       },
//     );
//   }
// }

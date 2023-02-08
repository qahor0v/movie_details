import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:kinor/constants/app_colors.dart';
import 'package:kinor/mobile_ui/screens/detail_screen/persisent_widget.dart';
import 'package:kinor/mobile_ui/screens/helper/sized_box.dart';
import 'package:kinor/mobile_ui/screens/helper/sliver_sized_box.dart';
import 'package:kinor/mobile_ui/widgets/buttons/rating_movie.dart';
import 'package:kinor/mobile_ui/widgets/buttons/text_button.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import '../../constants/test_sources.dart';

final hideTitle = StateProvider<bool>((ref) {
  return false;
});

final kPageController = StateProvider<PageController>((ref) {
  return PageController();
});

final tapBarIndex = StateProvider<int>((ref) {
  return 0;
});
final sizeChanger = StateProvider<double>((ref) {
  return 0.0;
});
final snappingController = StateProvider<ScrollController>((ref) {
  return ScrollController();
});

class Test extends ConsumerWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final hideStatus = ref.watch(hideTitle);
    final tapBar = ref.watch(tapBarIndex);
    final kSize = ref.watch(sizeChanger);
    final controller = ref.watch(snappingController);
    final height = MediaQuery.of(context).size.height;
    final pageController = ref.watch(kPageController);
    return Scaffold(
      body: Stack(
        children: [
          SnappingSheet(
            lockOverflowDrag: true,
            initialSnappingPosition: const SnappingPosition.factor(
              positionFactor: 0.5,
            ),
            grabbingHeight: 80,
            grabbing: SafeArea(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                    top: !hideStatus
                        ? const Radius.circular(32)
                        : const Radius.circular(0.0),
                  ),
                ),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: const EdgeInsets.only(top: 8),
                      width: hideStatus ? 0.0 : 80,
                      height: hideStatus ? 0.0 : 3,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    AnimatedAlign(
                      alignment:
                          hideStatus ? Alignment.topLeft : Alignment.center,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: hideStatus ? 48 : 0.0,
                          top: 8,
                        ),
                        child: const Text(
                          "The Movie Name 2",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sheetBelow: SnappingSheetContent(
              childScrollController: controller,
              draggable: true,
              child: LayoutBuilder(
                builder: (context, size) {
                  Future.delayed(Duration.zero, () {
                    ref.read(sizeChanger.notifier).state = size.biggest.height;
                    if (size.biggest.height > height * 0.85) {
                      ref.read(hideTitle.notifier).state = true;
                    } else {
                      ref.read(hideTitle.notifier).state = false;
                    }
                  });
                  return Container(
                    color: Colors.black,
                    child: NestedScrollView(
                      controller: controller,
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        const SliverBox(4),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 16,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      WBox(8),
                                      Text(
                                        "Action, Fantastic, Drama",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      WBox(4),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 8,
                                        color: black20,
                                      ),
                                      WBox(4),
                                      Text(
                                        "2021",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      WBox(4),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 8,
                                        color: Colors.white,
                                      ),
                                      WBox(4),
                                      Text(
                                        "18+",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const HBox(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const WBox(8),
                                    const WhiteRatingMovie(rating: 6.8),
                                    const WBox(8),
                                    TextButtonScreen(
                                      title: "rate".tr(),
                                      function: () {},
                                    )
                                  ],
                                ),
                                const HBox(12),
                                Row(
                                  children: [
                                    const WBox(8),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                          IconlyLight.play,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "watch".tr(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                          ),
                                          backgroundColor: mainColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            side: const BorderSide(
                                              width: 1,
                                              color: mainColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const WBox(8),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                          IconlyLight.plus,
                                          color: mainColor,
                                        ),
                                        label: Text(
                                          "toFavourites".tr(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: mainColor,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            side: const BorderSide(
                                              width: 1,
                                              color: mainColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const WBox(8),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, top: 24),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16, top: 8, right: 8, bottom: 16),
                            child: Text(
                              kText,
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                              //maxLines: 6,
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: SeriePersistentHeader(
                            widget: Container(
                              color: kBackColor,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    WBox(16),
                                    MaterialButton(
                                        onPressed: () {
                                          ref.read(tapBarIndex.notifier).state =
                                              0;
                                          ref.read(kPageController.notifier).state.jumpToPage(0);
                                        },
                                        child: Text(
                                          "Actors",
                                          style: TextStyle(
                                            color:
                                                tapBar == 0 ? mainColor : white,

                                          ),
                                        )),
                                    WBox(8),
                                    MaterialButton(
                                      onPressed: () {
                                        ref.read(tapBarIndex.notifier).state =
                                            1;
                                        ref.read(kPageController.notifier).state.jumpToPage(1);
                                      },
                                      child: Text(
                                        "Trailers",
                                        style: TextStyle(
                                          color:
                                              tapBar == 1 ? mainColor : white,
                                        ),
                                      ),
                                    ),
                                    WBox(8),
                                    MaterialButton(
                                      onPressed: () {
                                        ref.read(tapBarIndex.notifier).state =
                                            2;
                                        ref.read(kPageController.notifier).state.jumpToPage(2);
                                      },
                                      child: Text(
                                        "Similar",
                                        style: TextStyle(
                                          color:
                                              tapBar == 2 ? mainColor : white,
                                        ),
                                      ),
                                    ),
                                    const WBox(16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      body: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          ref.read(tapBarIndex.notifier).state = index;
                        },
                        children: List<Widget>.generate(
                          3,
                          (index) {
                            return [
                              Container(
                                color: Colors.green,
                              ),
                              Container(
                                color: Colors.red,
                              ),
                              Container(
                                color: Colors.blue,
                              ),
                            ][index];
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/intro_images/041e410bd9a02b00b3bc6a16a6302485.jpg',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 80, sigmaX: 80),
                  child: Center(
                    child: AnimatedPadding(
                      duration: const Duration(
                        milliseconds: 50,
                      ),
                      padding: EdgeInsets.only(
                          left: (kSize / 5) < 32 ? 32 : kSize / 6,
                          right: (kSize / 5) < 32 ? 32 : kSize / 6,
                          top: 32,
                          bottom: kSize > 80 ? (kSize - 40) : 40),
                      child: Image.asset(
                        "assets/images/intro_images/041e410bd9a02b00b3bc6a16a6302485.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 8,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: mainColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

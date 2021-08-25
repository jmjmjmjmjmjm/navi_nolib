import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pla0823/controller/page_controller.dart';
import 'package:pla0823/model/example_model.dart';

class ProfileImage extends StatefulWidget {
  ContentModel model;
  ProfileImage({Key? key, required this.model}) : super(key: key);
  @override
  _ProfileImageState createState() => _ProfileImageState(model: model);
}

class _ProfileImageState extends State<ProfileImage>
    with SingleTickerProviderStateMixin {
  ContentModel model;
  _ProfileImageState({required this.model});
  int count = 1;
  PageController pageController = PageController();
  late AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 400));

  countF(int c) {
    setState(() {
      count = c;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageReController c = Get.put(PageReController());
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 180,
              padding: EdgeInsets.only(bottom: 7, left: 5, right: 5),
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) => Container(
                  child: GestureDetector(
                    onTap: () => showDial(context, model,
                        PageController(initialPage: index + 400)),
                    child: Image.network(
                      model.photos![index],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                itemCount: model.photos!.length,
                onPageChanged: (value) {
                  countF(value + 1);
                  c.count.value = value + 1;
                  c.opacity.value = 1.0;
                },
              ),
            ),
          ),
          Container(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.type != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF3B111)),
                          width: 65,
                          height: 20,
                          child: Center(
                            child: Text(
                              typeCheck(model.type.toString()),
                              style: GoogleFonts.notoSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff292979),
                            borderRadius: BorderRadius.circular(20)),
                        width: 40,
                        height: 20,
                        child: Center(
                          child: Text(
                            '$count' + '/' + model.photos!.length.toString(),
                            style: GoogleFonts.notoSans(
                                color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List transformationController = <TransformationController>[];
  List doubleTapDetails = <TapDownDetails>[];

  showDial(BuildContext context, ContentModel model, PageController pageC) {
    for (int i = 0; i < model.photos!.length + 1; i++) {
      transformationController.add(TransformationController());
      doubleTapDetails.add(TapDownDetails());
    }

    PageReController c = Get.put(PageReController());
    _handleDoubleTapDown(TapDownDetails details, int i) {
      doubleTapDetails[i] = details;
    }

    _handleDoubleTap(int i) {
      late Animation _animation;
      _animationController.addListener(() {
        transformationController[i].value = _animation.value;
      });

      if (transformationController[i].value != Matrix4.identity()) {
        _animation = Matrix4Tween(
          begin: transformationController[i].value,
          end: Matrix4.identity(),
        ).animate(
          CurveTween(curve: Curves.easeInOut).animate(_animationController),
        );
        _animationController.forward(from: 0);
        transformationController[i].value = Matrix4.identity();
        c.pageScroll.value = true;
        c.opacity.value = 1.0;
      } else {
        c.pageScroll.value = false;
        final position = doubleTapDetails[i].localPosition;
        var dy = -position.dy * 2;
        if (i == 1) dy = -645.0;
        if (dy < -900.0) return null;
        if (dy > -350) return null;
        if (dy > -580.0) dy = -580.0;
        if (dy < -700.0) dy = -700.0;

        transformationController[i].value = Matrix4.identity()
          ..translate(-position.dx * 2, dy)
          ..scale(3.0);

        _animation = Matrix4Tween(
          begin: Matrix4.identity(),
          end: transformationController[i].value,
        ).animate(
          CurveTween(curve: Curves.easeInOut).animate(_animationController),
        );
        c.opacity.value = 0.0;
        _animationController.forward(from: 0);
      }
    }

    return showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          Obx(
            () => PageView.builder(
              allowImplicitScrolling: true,
              physics: c.pageScroll.value
                  ? ClampingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              controller: pageC,
              onPageChanged: (value) {
                c.count.value = (value % model.photos!.length + 1);
                pageController.jumpToPage(value % model.photos!.length);
              },
              itemBuilder: (context, index) => AbsorbPointer(
                absorbing: false,
                ignoringSemantics: false,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onDoubleTap: () =>
                      _handleDoubleTap(index % model.photos!.length),
                  onDoubleTapDown: (details) => _handleDoubleTapDown(
                      details, index % model.photos!.length),
                  child: InteractiveViewer(
                    onInteractionEnd: (details) {
                      c.opacity.value = 0.0;
                      if (details.velocity.pixelsPerSecond.dx > 1500 ||
                          details.velocity.pixelsPerSecond.dx < -1500)
                        c.pageScroll.value = true;
                      else
                        c.pageScroll.value = false;
                      if (transformationController[index % model.photos!.length]
                              .value[0] ==
                          1.0) {
                        c.pageScroll.value = true;
                        c.opacity.value = 1.0;
                      }
                    },
                    transformationController:
                        transformationController[index % model.photos!.length],
                    child: Obx(
                      () => AbsorbPointer(
                        absorbing: c.pageScroll.value ? false : true,
                        child: Dismissible(
                          behavior: c.pageScroll.value
                              ? HitTestBehavior.deferToChild
                              : HitTestBehavior.translucent,
                          onDismissed: (direction) => Navigator.pop(context),
                          direction: DismissDirection.down,
                          key: Key(''),
                          child: Container(
                            width: 1000,
                            height: 1000,
                            color: Colors.black,
                            child: Image.network(
                              model.photos![index % model.photos!.length],
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Opacity(
              opacity: c.opacity.value,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Opacity(
              opacity: c.opacity.value,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        c.count.value.toString() +
                            ' / ' +
                            model.photos!.length.toString(),
                        style: GoogleFonts.notoSans(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  typeCheck(String type) {
    switch (type) {
      case 'day':
        return '일일 베스트';
      case 'month':
        return '월간 베스트';
      default:
        return '';
    }
  }
}

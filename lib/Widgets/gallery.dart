import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'appbar.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({
    super.key,
    required this.initialIndex,
    required this.images,
    this.isShowBar,
  });

  // 图片初始位置
  final int initialIndex;

  // 图片列表
  final List<AssetEntity> images;

  // 是否显示bar
  final bool? isShowBar;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> with SingleTickerProviderStateMixin {
  bool isShowBar = true;

  // 动画控制器
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    isShowBar = widget.isShowBar ?? true;
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  // 图片列表
  Widget _buildImageView() {
    return ExtendedImageGesturePageView.builder(
      controller: ExtendedPageController(
        initialPage: widget.initialIndex,
      ),
      itemCount: widget.images.length,
      itemBuilder: (BuildContext context, int index) {
        final AssetEntity item = widget.images[index];
        return ExtendedImage(
          image: AssetEntityImageProvider(
            item,
            isOriginal: true,
          ),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: ((state) {
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: true,
              initialAlignment: InitialAlignment.center,
            );
          }),
        );
      },
    );
  }

  Widget _buildMainView() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 解决点击空白处无效问题
      onTap: () {
        setState(() {
          isShowBar = !isShowBar;
        });
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: SlideAppBarWidget(
          controller: controller,
          isShowBar: isShowBar,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        body: _buildImageView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }
}

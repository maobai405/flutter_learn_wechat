import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../config/init.dart';

class ReleaseEditPage extends StatefulWidget {
  const ReleaseEditPage({super.key});

  @override
  State<ReleaseEditPage> createState() => _ReleaseEditPageState();
}

class _ReleaseEditPageState extends State<ReleaseEditPage> {
  List<AssetEntity> selectedAssets = [];

  // 图片列表
  Widget _buildImageList() {
    return Padding(
      padding: const EdgeInsets.all(spacing),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double width = (constraints.maxWidth - spacing * 2) / 3;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              // 渲染已选择的图片
              ...selectedAssets.map((asset) {
                return AssetEntityImage(
                  isOriginal: false,
                  asset,
                  width: width,
                  height: width,
                  fit: BoxFit.cover,
                );
              }).toList(),
              // 添加图片按钮
              if (selectedAssets.length < maxAssets)
                GestureDetector(
                  onTap: () async {
                    final List<AssetEntity>? result = await AssetPicker.pickAssets(
                      context,
                      pickerConfig: AssetPickerConfig(
                        selectedAssets: selectedAssets,
                        maxAssets: maxAssets,
                      ),
                    );
                    setState(() {
                      selectedAssets = result ?? [];
                    });
                  },
                  child: Container(
                    width: width,
                    height: width,
                    color: Colors.black12,
                    child: const Icon(Icons.add, size: 50, color: Colors.black38),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        // 图片列表
        _buildImageList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('发布')),
      body: _buildView(),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pill_city/data_moudle/data_post.dart';
import 'package:pill_city/home/timeline_one/timeline_block/home_block_view_controller.dart';

class HomeBlockView extends State<HomeBlockViewController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataPost post = widget.data;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        // 最外層縱向
        children: [
          Padding(
            // 頭像名字橫向列下端間距
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              // 頭像名字橫向列
              children: [
                ConstrainedBox(
                  // 限制頭像尺寸
                  constraints:
                      const BoxConstraints(maxHeight: 50, maxWidth: 50),
                  child: CachedNetworkImage(
                    // 頭像
                    imageUrl: post.author.avatar_url,
                    imageBuilder: (context, imageProvider) => Container(
                      // 圆角用w
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(), // 轉圈等待
                    errorWidget: (context, url, error) => Image.asset(
                      // 無頭像
                      'images/kusuou.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    // 頭像右側兩行資訊
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            // 使用者暱稱
                            post.author.display_name,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            post.created_at_seconds.toString(),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(child: Text(post.content)),
            ],
          ),
        ],
      ),
    );
  }
}

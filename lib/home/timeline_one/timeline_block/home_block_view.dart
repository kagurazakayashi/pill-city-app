import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pill_city/common/i18n_function/i18n_function.dart';
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
            // 層疊頭像名字橫向列的左側資訊和右側選單按鈕
            child: Stack(
              children: <Widget>[
                // 頭像名字橫向列
                Row(
                  children: [
                    // 限制頭像尺寸
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 50, maxWidth: 50),
                      child: CachedNetworkImage(
                        // 頭像
                        imageUrl: post.author.avatar_url,
                        // 圆角用w
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // 轉圈等待
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        // 無頭像
                        errorWidget: (context, url, error) => Image.asset(
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // 分享範圍箭頭
                              Icon(
                                Icons.play_arrow,
                                color:
                                    post.is_public ? Colors.blue : Colors.green,
                                size: 15.0,
                              ),
                              // 分享範圍
                              Text(
                                post.is_public
                                    ? tr("post.public")
                                    : post.circlesString(),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: post.is_public
                                      ? Colors.blue
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                post.created_at_seconds.toString(),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
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

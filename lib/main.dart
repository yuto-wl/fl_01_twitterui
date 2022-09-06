import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  static const String userName = 'Yuto';
  static const String userId = 'yt_flutteruniv';
  static const String userAvatarAddress = 'images/twitter_avatar.jpg';
  static const int tweetCount = 6;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: HexColor('171f2a'),
          // Appバー
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: AppBar(
              backgroundColor: HexColor('2e3636'),
              titleSpacing: 30,
              // ユーザ名、ツイート数
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 23),
                  ),
                  Text(
                    'ツイート $tweetCount',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              // アイコン：戻る
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 28,
                onPressed: () {},
              ),
              // アイコン：探す、その他
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  iconSize: 28,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  iconSize: 28,
                  onPressed: () {},
                )
              ],
              // タブバー
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(45),
                child: ColoredBox(
                  color: HexColor('171f2a'),
                  child: const TabBar(
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.only(left: 25, right: 25),
                    tabs: [
                      Tab(text: 'ツイート'),
                      Tab(text: 'ツイートと返信'),
                      Tab(text: 'メディア'),
                      Tab(text: 'いいね'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              // ツイート群
              Scrollbar(
                child: ListView(
                  children: const [
                    TweetTile(
                      userName: userName,
                      userId: userId,
                      userAvatarAddress: userAvatarAddress,
                      tweetText: '最高でした。',
                      tweetTime: '4分',
                      tweetImageAddress: null,
                      replyCount: 315,
                      retweetCount: 346,
                      favoriteCount: 765,
                    ),
                    TweetTile(
                      userName: userName,
                      userId: userId,
                      userAvatarAddress: userAvatarAddress,
                      tweetText: '黒酢酢豚、めっちゃ美味しくできたー(o・∇・o)',
                      tweetTime: '5分',
                      tweetImageAddress: 'images/cooking_01.jpg',
                      replyCount: 5,
                      retweetCount: 47,
                      favoriteCount: 211,
                    ),
                    TweetTile(
                      userName: userName,
                      userId: userId,
                      userAvatarAddress: userAvatarAddress,
                      tweetText: '四暗刻和了った！',
                      tweetTime: '5分',
                      tweetImageAddress: 'images/mahjong_01.png',
                      replyCount: 0,
                      retweetCount: 33,
                      favoriteCount: 5,
                    ),
                    TweetTile(
                      userName: userName,
                      userId: userId,
                      userAvatarAddress: userAvatarAddress,
                      tweetText: '「赤外線通信」…そろそろ若い人たちには通じなさそう',
                      tweetTime: '8分',
                      tweetImageAddress: null,
                      replyCount: 0,
                      retweetCount: 101,
                      favoriteCount: 157,
                    ),
                    TweetTile(
                      userName: userName,
                      userId: userId,
                      userAvatarAddress: userAvatarAddress,
                      tweetText: 'グレープフルーツと生ハムの冷製パスタ(o・∇・o)',
                      tweetTime: '19分',
                      tweetImageAddress: 'images/cooking_02.jpg',
                      replyCount: 2,
                      retweetCount: 13,
                      favoriteCount: 31,
                    ),
                    TweetTile(
                      userName: userName,
                      userId: userId,
                      userAvatarAddress: userAvatarAddress,
                      tweetText: 'アカウント作成！',
                      tweetTime: '21分',
                      tweetImageAddress: null,
                      replyCount: 0,
                      retweetCount: 1,
                      favoriteCount: 5,
                    ),
                  ],
                ),
              ),
              // プラスボタン
              /// 素直に floatingActionButton: プロパティに渡したほうが良さそう。
              /// 微調整は padding 等でやるとよい。
              // Align(
              //   alignment: const Alignment(0.95, 0.95),
              //   child: FloatingActionButton(
              //       backgroundColor: Colors.blue,
              //       child: const Icon(Icons.add, color: Colors.white),
              //       onPressed: () {}),
              // )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

extension IntEx on int {
  /// 0以上の数字なら空文字する関数を作ったほうがスッキリするかもしれない
  /// 関数名が雑ですみません...
  String toStringRemovingZero() {
    if (this > 0) {
      return toString();
    }
    return '';
  }
}

// ツイートタイル
class TweetTile extends StatelessWidget {
  const TweetTile({
    Key? key,
    required this.userName,
    required this.userId,
    required this.userAvatarAddress,
    required this.tweetText,
    required this.tweetTime,
    required this.tweetImageAddress,
    required this.replyCount,
    required this.retweetCount,
    required this.favoriteCount,
  }) : super(key: key);

  final String userName;
  final String userId;
  final String userAvatarAddress;
  final String tweetText;
  final String tweetTime;
  final String? tweetImageAddress;
  final int replyCount;
  final int retweetCount;
  final int favoriteCount;

  // ツイート画像表示
  Widget tweetImage(BuildContext context) {
    return tweetImageAddress != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(tweetImageAddress!))
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    // スクリーンサイズを取得
    var screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.1))),
      padding: EdgeInsets.all(screenSize.width * 0.02),
      child: Row(
        // アカウントアバター
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: screenSize.width * 0.20,
              child: CircleAvatar(
                backgroundImage: AssetImage(userAvatarAddress),
                maxRadius: 27,
              )),
          SizedBox(width: screenSize.width * 0.02),
          SizedBox(
            width: screenSize.width * 0.74,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //アカウント名、ツイート日付
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: screenSize.width * 0.01),
                        Text('＠$userId',
                            style: const TextStyle(color: Colors.grey)),
                        Text('・$tweetTime',
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    // アイコン：その他
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: Colors.grey,
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                      iconSize: 15,
                    )
                  ],
                ),
                // ツイート本文、画像
                Align(alignment: Alignment.topLeft, child: Text(tweetText)),
                SizedBox(height: screenSize.width * 0.01),
                // 画像
                tweetImage(context),
                // アイコン群
                /// 局所的にstyleを一括で変更したい場合に便利
                DefaultTextStyle(
                  style: const TextStyle(color: Colors.grey),
                  child: Row(children: [
                    // アイコン：リプライ
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minHeight: 40),
                      color: Colors.grey,
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline),
                      iconSize: 18,
                    ),
                    SizedBox(width: screenSize.width * 0.01),
                    // リプライ数
                    Text(replyCount.toStringRemovingZero()),
                    // replyCounter(context),
                    const Spacer(flex: 5),
                    // アイコン：リツイート
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minHeight: 30),
                      color: Colors.grey,
                      onPressed: () {},
                      icon: const Icon(Icons.transform),
                      iconSize: 18,
                    ),
                    SizedBox(width: screenSize.width * 0.01),
                    // リツイート数
                    Text(retweetCount.toString()),
                    // retweetCounter(context),
                    const Spacer(flex: 5),
                    // アイコン：フェイバリット
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minHeight: 30),
                      color: Colors.grey,
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      iconSize: 18,
                    ),
                    SizedBox(width: screenSize.width * 0.01),
                    // フェイバリット数
                    Text(favoriteCount.toStringRemovingZero()),
                    // favoriteCounter(context),
                    const Spacer(flex: 5),
                    // アイコン：共有
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minHeight: 30),
                      color: Colors.grey,
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined),
                      iconSize: 18,
                    ),
                    const Spacer(flex: 1),
                    // アイコン：アクティビティ
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minHeight: 30),
                      color: Colors.grey,
                      onPressed: () {},
                      icon: const Icon(Icons.bar_chart),
                      iconSize: 15,
                    ),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Hexcolorで色指定するためのクラス
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

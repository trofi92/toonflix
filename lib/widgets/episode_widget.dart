import 'package:flutter/material.dart';
import 'package:toonflix/model/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episodes extends StatelessWidget {
  const Episodes({
    super.key,
    required this.episodes,
    required this.webtoonId,
  });
  final String webtoonId;
  final Future<List<WebtoonEpisodeModel>> episodes;

  onButtonTap({required String episodeId}) async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=$episodeId");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: episodes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 145,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var episode = snapshot.data![index];
                  return GestureDetector(
                    onTap: () => onButtonTap(episodeId: episode.id),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(9, 9),
                                )
                              ],
                              color: Colors.green.shade300,
                              border: Border.all(
                                color: Colors.black87,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      episode.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // maxLines: 1,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            );
          }
          return Container();
        });
  }
}

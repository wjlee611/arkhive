import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlWidget extends StatelessWidget {
  const UrlWidget({
    Key? key,
    this.platform = 'browser',
    required this.url,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String platform;
  final String url;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        late final url_ = Uri.parse(url);

        // youtube launch
        String yt = url.split('//').last;
        // ignore: deprecated_member_use
        if (platform == 'youtube' && await canLaunch('youtube://$yt')) {
          // ignore: deprecated_member_use
          await launch('youtube://$yt', forceSafariVC: false);
          return;
        }

        if (await canLaunchUrl(url_)) {
          launchUrl(url_, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            Icon(
              platform == "naver"
                  ? Icons.local_cafe_rounded
                  : platform == 'twitter'
                      ? FontAwesomeIcons.twitter
                      : platform == "facebook"
                          ? Icons.facebook
                          : platform == "youtube"
                              ? Icons.play_arrow
                              : Icons.grain_outlined,
              color: Colors.white,
            ),
            Text(
              " $title",
              style: const TextStyle(
                fontSize: 14,
                fontFamily: FontFamily.nanumGothic,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

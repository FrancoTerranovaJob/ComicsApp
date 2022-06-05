import 'package:comics_app/app/data/comics_data/providers/api/model/response/get_comics_response.dart';
import 'package:intl/intl.dart';

void main() {
  final comicResp = GetComicsResponse.fromJson(const {
    'number_of_total_results': 12,
    'number_of_page_results': 10,
    'results': [
      {
        "aliases": null,
        "api_detail_url": "https://comicvine.gamespot.com/api/issue/4000-6/",
        "cover_date": "1952-10-01",
        "date_added": "2008-06-06 11:10:16",
        "date_last_updated": "2015-07-11 12:08:20",
        "deck": null,
        "description":
            "<p>The horrors of:</p><p>- Lost race!</p><p>- The man germ!</p><p>- Man in the hood!</p><p>- The things!</p><p>-Stories behind the stars, featuring the legendary battle between Hercules, Hydra and Iolaus!</p><p>Plus, two page long prose-stories.</p>",
        "has_staff_review": false,
        "id": 6,
        "image": {
          "icon_url":
              "https://comicvine.gamespot.com/a/uploads/square_avatar/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "medium_url":
              "https://comicvine.gamespot.com/a/uploads/scale_medium/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "screen_url":
              "https://comicvine.gamespot.com/a/uploads/screen_medium/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "screen_large_url":
              "https://comicvine.gamespot.com/a/uploads/screen_kubrick/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "small_url":
              "https://comicvine.gamespot.com/a/uploads/scale_small/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "super_url":
              "https://comicvine.gamespot.com/a/uploads/scale_large/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "thumb_url":
              "https://comicvine.gamespot.com/a/uploads/scale_avatar/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "tiny_url":
              "https://comicvine.gamespot.com/a/uploads/square_mini/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "original_url":
              "https://comicvine.gamespot.com/a/uploads/original/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
          "image_tags": "All Images"
        },
        "associated_images": [
          {
            "original_url":
                "https://comicvine.gamespot.com/a/uploads/original/0/4/7-1487-6-1-chamber-of-chills.jpg",
            "id": 7,
            "caption": null,
            "image_tags": "All Images"
          }
        ],
        "issue_number": "13",
        "name": "The Lost Race",
        "site_detail_url":
            "https://comicvine.gamespot.com/chamber-of-chills-magazine-13-the-lost-race/4000-6/",
        "store_date": null,
        "volume": {
          "api_detail_url":
              "https://comicvine.gamespot.com/api/volume/4050-1487/",
          "id": 1487,
          "name": "Chamber of Chills Magazine",
          "site_detail_url":
              "https://comicvine.gamespot.com/chamber-of-chills-magazine/4050-1487/"
        }
      }
    ]
  });
  var now = DateTime(DateTime.now().year, 1, 1);
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  print('$formattedDate|${DateTime.now().toString()}');
}
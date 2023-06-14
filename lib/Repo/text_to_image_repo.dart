
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:saudi_guide/Models/api_keys.dart';
import 'package:saudi_guide/Models/image_saudi_model.dart';

class TextToImageRepo{



static Future<int> getTextToImage({required ImageSaudiModel model})async{


    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiKeys.stableDiffusion}',
        'Cookie': '__cf_bm=_qXVATb4mv3lW8awSJtiq.la13CUEGJFCP03IL35g4g-1684653014-0-ARqbk1V3FTIRdZCWz/7M9D3YhqAxbhgqvECzXY+3k6D6UXZpCZ3piUnCUFhgEr2uN32h8TvvstPwJQkWxjmO6aU='
      };
      var request = http.Request('POST', Uri.parse('https://api.stability.ai/v1/generation/stable-diffusion-xl-beta-v2-2-2/text-to-image'));
      request.body = json.encode(
      {
      "text_prompts": [
      {
      "text": model.prompt,
      } ],
      "cfg_scale": 10,
      "height": 512,
      "width": 512,
      "samples": 1,
      "steps": 50, "style_preset": "enhance", "seed": model.seed
      }
      //     {
      //   "text_prompts": [
      //     {
      //       "text": model.prompt
      //     }
      //   ],
      //   "cfg_scale": 10,
      //   "height": 512,
      //   "width": 512,
      //   "samples": 1,
      //   "steps": 50,
      //   "style_preset": "enhance",
      //   "seed": 20000
      // }

      );



      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {


        var body = json.decode(await response.stream.bytesToString());
        TextToImageController.imageBase64 =  body['artifacts'][0]["base64"];
        return response.statusCode;
      }
      else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }

  }









static Future<int> getUserInputImage({required ImageSaudiModel model})async{


    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiKeys.stableDiffusion}',
        'Cookie': '__cf_bm=_qXVATb4mv3lW8awSJtiq.la13CUEGJFCP03IL35g4g-1684653014-0-ARqbk1V3FTIRdZCWz/7M9D3YhqAxbhgqvECzXY+3k6D6UXZpCZ3piUnCUFhgEr2uN32h8TvvstPwJQkWxjmO6aU='
      };
      var request = http.Request('POST', Uri.parse('https://api.stability.ai/v1/generation/stable-diffusion-xl-beta-v2-2-2/text-to-image'));
      request.body = json.encode(
      {
      "text_prompts": [
      {
      "text": model.prompt,
      } ],
      "cfg_scale": 10,
      "height": 512,
      "width": 512,
      "samples": 1,
      "steps": 50, "style_preset": "enhance",
      }
      //     {
      //   "text_prompts": [
      //     {
      //       "text": model.prompt
      //     }
      //   ],
      //   "cfg_scale": 10,
      //   "height": 512,
      //   "width": 512,
      //   "samples": 1,
      //   "steps": 50,
      //   "style_preset": "enhance",
      //   "seed": 20000
      // }

      );



      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {


        var body = json.decode(await response.stream.bytesToString());
        TextToImageController.imageBase64 =  body['artifacts'][0]["base64"];
        return response.statusCode;
      }
      else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }

  }






  // user in put










}
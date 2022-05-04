import { ConfigService } from '@nestjs/config';
import { Url } from 'src/url/domain/entities/url.entity';

export class ShortenedUrlDto {
  shortUrl: string;
  origUrlDetails: Url;

  static createFromUrlEntity(_url: Url) {
    const instance = new ShortenedUrlDto();
    const config = new ConfigService();
    instance.shortUrl = config.get('EXPANDER_URL') + '/' + _url.getToken();
    instance.origUrlDetails = _url;
    return instance;
  }
}

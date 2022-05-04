import { CACHE_MANAGER, Inject, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Cache } from 'cache-manager';
import { ShortenedUrlDto } from 'src/url/infrastructure/dto/shortened-url.dto';
import { UrlRepository } from 'src/url/infrastructure/repositories/url.repository';
import { Url } from '../entities/url.entity';

@Injectable()
export class ShortenUrlService {
  constructor(
    private readonly config: ConfigService,
    private readonly urlRepository: UrlRepository,
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
  ) {}

  private async getUrlEntity(_url: string, _userId: string): Promise<Url> {
    const url = await this.urlRepository.findOne({
      where: { url: _url, userId: _userId },
    });

    return url;
  }

  async shortenUrl(_url: string, _userId: string) {
    console.log(this.config);
    const cleanUrl = _url.replace(/\/$/, '');
    const urlEntity = await this.getUrlEntity(cleanUrl, _userId);

    if (urlEntity) {
      return ShortenedUrlDto.createFromUrlEntity(urlEntity);
    }

    const url = await Url.create(cleanUrl, _userId); //just a very simple cleanup of the URL
    await this.urlRepository.save(url);

    this.cacheManager.set(url.getToken(), cleanUrl, { ttl: 0 });

    return ShortenedUrlDto.createFromUrlEntity(url);
  }
}

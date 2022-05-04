import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UrlController } from './api/url.controller';
import { ShortenUrlService } from './domain/services/shorten-url.service';
import { UrlRepository } from './infrastructure/repositories/url.repository';

@Module({
  imports: [TypeOrmModule.forFeature([UrlRepository])],
  providers: [ShortenUrlService],
  controllers: [UrlController],
})
export class UrlModule {}

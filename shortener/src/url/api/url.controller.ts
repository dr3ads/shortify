import { Controller, Post, Body, UseGuards, Request } from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth/domain/guards/jwt-auth.guard';
import { ShortenUrlService } from '../domain/services/shorten-url.service';
import { ShortenUrlDto } from '../infrastructure/dto/shorten-url.dto';

@Controller('url')
export class UrlController {
  constructor(private readonly shortenUrlService: ShortenUrlService) {}

  @UseGuards(JwtAuthGuard)
  @Post('shortify')
  async shorten(@Body() _dto: ShortenUrlDto, @Request() _req) {
    return this.shortenUrlService.shortenUrl(_dto.url, _req.user.userId);
  }
}

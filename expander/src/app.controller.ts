import {
  CACHE_MANAGER,
  Controller,
  Get,
  Inject,
  Param,
  Res,
} from '@nestjs/common';
import { Cache } from 'cache-manager';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
  ) {}

  @Get(':token')
  async redirect(@Param() _params, @Res() _res) {
    const url = await this.cacheManager.get(_params.token);
    console.log(url);
    return _res.redirect(url);
  }
}

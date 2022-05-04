import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from 'src/auth/domain/services/auth.service';

import { AuthUserDto } from 'src/auth/infrastructure/dto/auth-user.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  async login(@Body() _dto: AuthUserDto) {
    return this.authService.signin(_dto);
  }
}

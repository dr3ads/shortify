import { Controller, Post, Body } from '@nestjs/common';
import { RegistrationService } from '../domain/services/registration.service';
import { UserSignUpDto } from '../infrastructure/dto/user-signup.dto';

@Controller('user')
export class UserController {
  constructor(private readonly registrationService: RegistrationService) {}

  @Post('signup')
  async signup(@Body() _dto: UserSignUpDto) {
    return this.registrationService.signup(_dto);
  }
}

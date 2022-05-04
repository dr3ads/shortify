import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserController } from './api/user.controller';
import { UserSignedUpHandler } from './domain/handlers/user-signed-up.handler';
import { GetUserService } from './domain/services/get-user.service';
import { RegistrationService } from './domain/services/registration.service';
import { UserRepository } from './infrastructure/repositories/user.repository';

@Module({
  imports: [TypeOrmModule.forFeature([UserRepository])],
  providers: [UserSignedUpHandler, GetUserService, RegistrationService],
  exports: [GetUserService],
  controllers: [UserController],
})
export class UserModule {}

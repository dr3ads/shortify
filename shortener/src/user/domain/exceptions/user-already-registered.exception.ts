import { HttpException } from '@nestjs/common';
import { HttpStatus } from '@nestjs/common';

export class UserAlreadyRegisteredException extends HttpException {
  constructor() {
    super('Email address is already Registered', HttpStatus.BAD_REQUEST);
  }
}

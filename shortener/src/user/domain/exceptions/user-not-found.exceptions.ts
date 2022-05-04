import { HttpException } from '@nestjs/common';
import { HttpStatus } from '@nestjs/common';

export class UserNotFoundException extends HttpException {
  constructor() {
    super('User Not found', HttpStatus.BAD_REQUEST);
  }
}

import { Injectable } from '@nestjs/common';
import { EventEmitter2 } from '@nestjs/event-emitter';

import { UserAlreadyRegisteredException } from 'src/user/domain/exceptions/user-already-registered.exception';
import { UserSignUpDto } from 'src/user/infrastructure/dto/user-signup.dto';
import { UserRepository } from 'src/user/infrastructure/repositories/user.repository';

import { UserSignedUpEvent } from '../events/user-signed-up.event';

@Injectable()
export class RegistrationService {
  constructor(
    private readonly eventEmitter: EventEmitter2,
    private readonly userRepository: UserRepository,
  ) {}

  private async isEmailRegistered(_email: string): Promise<boolean> {
    const user = await this.userRepository.findByEmail(_email);

    return user ? true : false;
  }

  async signup(_dto: UserSignUpDto) {
    //TODO::have to look for a better approach on this.
    // possible options:
    // 1. move the registration service to user module and call that service in this module -- leaning towards this
    // 2. create a service under user module that will handle the validation
    if (await this.isEmailRegistered(_dto.email)) {
      throw new UserAlreadyRegisteredException();
    }

    this.eventEmitter.emit(
      'user.signed.up',
      new UserSignedUpEvent(
        _dto.firstName,
        _dto.lastName,
        _dto.email,
        _dto.password,
      ),
    );
  }
}

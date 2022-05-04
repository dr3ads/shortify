import { Injectable } from '@nestjs/common';
import { EventEmitter2, OnEvent } from '@nestjs/event-emitter';
import { UserRepository } from 'src/user/infrastructure/repositories/user.repository';
import { User } from '../entities/user.entity';
import { UserRegistered } from '../events/user-registered.event';
import { UserAlreadyRegisteredException } from '../exceptions/user-already-registered.exception';
import { Password } from '../valueObjects/password.value-object';

interface Event {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
}

@Injectable()
export class UserSignedUpHandler {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly eventEmitter: EventEmitter2,
  ) {}

  private async isEmailRegistered(_email: string): Promise<boolean> {
    const user = await this.userRepository.findByEmail(_email);

    return user ? true : false;
  }

  @OnEvent('user.signed.up')
  async handleUserSignedUp(_payload: Event) {
    if (await this.isEmailRegistered(_payload.email)) {
      throw new UserAlreadyRegisteredException();
    }

    const user = User.create(
      _payload.email,
      await Password.create(_payload.password),
      _payload.firstName,
      _payload.lastName,
    );

    this.userRepository
      .save(user)
      .then(() => {
        this.eventEmitter.emit(
          'user.registered',
          new UserRegistered(
            _payload.firstName,
            _payload.lastName,
            _payload.email,
          ),
        );
      })
      .catch((_err) => {
        throw _err;
      });
  }
}

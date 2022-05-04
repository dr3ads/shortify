import { Injectable } from '@nestjs/common';
import { UserRepository } from 'src/user/infrastructure/repositories/user.repository';
import { UserNotFoundException } from '../exceptions/user-not-found.exceptions';

@Injectable()
export class GetUserService {
  constructor(private readonly userRepository: UserRepository) {}

  async getUserByEmail(_email: string) {
    const user = await this.userRepository.findOne({
      where: { email: _email },
    });

    if (!user) {
      throw new UserNotFoundException();
    }

    return user;
  }
}

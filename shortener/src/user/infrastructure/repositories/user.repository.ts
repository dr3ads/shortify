import { Repository, EntityRepository } from 'typeorm';
import { User } from '../../domain/entities/user.entity';

@EntityRepository(User)
export class UserRepository extends Repository<User> {
  async findByEmail(_email: string): Promise<User> {
    return await this.findOne({ where: { email: _email } });
  }
}

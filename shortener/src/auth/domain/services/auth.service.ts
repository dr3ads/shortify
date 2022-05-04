import { ForbiddenException, Injectable } from '@nestjs/common';
import { AuthUserDto } from 'src/auth/infrastructure/dto/auth-user.dto';
import { GetUserService } from 'src/user/domain/services/get-user.service';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AuthService {
  constructor(
    private readonly getUserService: GetUserService,
    private readonly jwtService: JwtService,
    private readonly config: ConfigService,
  ) {}

  async signin(_dto: AuthUserDto) {
    const user = await this.getUserService.getUserByEmail(_dto.email);
    // if user does not exist throw exception
    if (!user) {
      throw new ForbiddenException('Credentials incorrect');
    }

    // compare password
    const pwMatches = await bcrypt.compare(_dto.password, user.getPassword());
    // if password incorrect throw exception
    if (!pwMatches) {
      throw new ForbiddenException('Credentials incorrect');
    }

    return {
      user: {
        firstName: user.getFirstName(),
        lastName: user.getLastName(),
      },
      token: await this.signToken(user.getId(), user.getEmail()),
    };
  }

  async signToken(userId: string, email: string): Promise<string> {
    const payload = {
      sub: userId,
      email,
    };
    const secret = this.config.get('JWT_SECRET');

    const token = await this.jwtService.signAsync(payload, {
      expiresIn: '5m',
      secret: secret,
    });

    return token;
  }
}

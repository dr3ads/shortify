import { CacheModule, Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { EventEmitterModule } from '@nestjs/event-emitter';
import { UrlModule } from './url/url.module';
import * as redisStore from 'cache-manager-redis-store';
import type { RedisClientOptions } from 'redis';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    UserModule,
    UrlModule,
    EventEmitterModule.forRoot(),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get('MYSQL_HOST'),
        port: +configService.get<number>('MYSQL_PORT'),
        username: configService.get('MYSQL_USER'),
        password: configService.get('MYSQL_PASS'),
        database: configService.get('MYSQL_DB'),
        entities: [__dirname + '/**/*.entity.{js,ts}'],

        synchronize: true,
        logging: JSON.parse(configService.get('TYPEORM_LOGGING')),
      }),
      inject: [ConfigService],
    }),
    CacheModule.register<RedisClientOptions>({
      isGlobal: true,
      store: redisStore,

      // Store-specific configuration:
      socket: {
        host: 'localhost',
        port: 6379,
      },
    }),
    UrlModule,
  ],
})
export class AppModule {}

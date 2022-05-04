import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { nanoid } from 'nanoid';

@Entity('urls')
export class Url {
  private constructor() {}

  @PrimaryGeneratedColumn('uuid')
  private id: string;

  @Column()
  private url: string;

  @Column()
  private userId: string;

  @Column('integer', { default: 0 })
  private visits: number;

  @Column('varchar', { length: 32, unique: true })
  private token: string;
  @CreateDateColumn()
  private createdAt: Date;

  @UpdateDateColumn()
  private updatedAt: Date;

  getToken() {
    return this.token;
  }

  static async create(_url: string, _userId: string) {
    const instance = new Url();
    instance.url = _url;
    instance.token = nanoid(8);
    instance.userId = _userId;

    return instance;
  }
}

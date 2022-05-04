import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Password } from '../valueObjects/password.value-object';

@Entity('users')
export class User {
  private constructor() {}

  @PrimaryGeneratedColumn('uuid')
  private id: string;

  @Column('varchar', { length: 50 })
  private firstName: string;

  @Column('varchar', { length: 50 })
  private lastName: string;

  @Column('varchar', { length: 50, unique: true })
  private email: string;

  @Column()
  private password: string;

  @CreateDateColumn()
  private createdAt: Date;

  @UpdateDateColumn()
  private updatedAt: Date;

  getId() {
    return this.id;
  }

  getEmail() {
    return this.email;
  }

  getFirstName() {
    return this.firstName;
  }

  getLastName() {
    return this.lastName;
  }

  getPassword() {
    return this.password;
  }

  static create(
    _email: string,
    _password: Password,

    _firstName?: string,
    _lastName?: string,
  ) {
    const instance = new User();
    instance.email = _email;
    instance.firstName = _firstName;
    instance.lastName = _lastName;
    instance.password = _password.password;

    return instance;
  }
}

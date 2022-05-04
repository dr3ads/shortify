export class UserSignedUpEvent {
  firstName: string;
  lastName: string;
  email: string;
  password: string;

  constructor(
    _firstName: string,
    _lastName: string,
    _email: string,
    _password: string,
  ) {
    this.firstName = _firstName;
    this.lastName = _lastName;
    this.email = _email;
    this.password = _password;
  }
}

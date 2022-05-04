export class UserRegistered {
  firstName: string;
  lastName: string;
  email: string;

  constructor(_firstName: string, _lastName: string, _email: string) {
    this.firstName = _firstName;
    this.lastName = _lastName;
    this.email = _email;
  }
}

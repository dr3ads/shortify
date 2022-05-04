import * as bcrypt from 'bcrypt';

export class Password {
  password: string;
  private readonly _saltOrRounds = 10;

  private constructor() {}

  async doHash(_toHash: string) {
    this.password = await bcrypt.hash(_toHash, this._saltOrRounds);
  }

  static async create(_password: string) {
    const instance = new Password();

    await instance.doHash(_password);

    return instance;
  }
}

import { Url } from 'src/url/domain/entities/url.entity';
import { Repository, EntityRepository } from 'typeorm';

@EntityRepository(Url)
export class UrlRepository extends Repository<Url> {}

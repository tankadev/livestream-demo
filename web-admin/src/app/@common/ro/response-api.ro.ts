export class ResponseApiRO<T> {
  statusCode: number;
  message: string;
  data: T;
}

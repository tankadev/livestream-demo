import { CustomerRO } from './customer.ro';

export class PendingVerifyRO {
    uuid: string;
    email: string;
    role: number;
    verifyStatus: number;
    image: string;
    firstName: string;
    lastName: string;
    birthday: string;
    address: string;
    pushToken: string;
    insertDate: string;
}

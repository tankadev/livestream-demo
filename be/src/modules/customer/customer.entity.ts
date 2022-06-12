import { Entity, Column, PrimaryColumn, OneToMany } from 'typeorm';
import { OrderEntity } from '../order/order.entity';

@Entity('customer')
export class CustomerEntity {
    @PrimaryColumn({ name: 'uuid', type: 'char', length: 32 })
    uuid: string;

    @Column({ name: 'name', type: 'varchar', length: 255 })
    name: string;

    @Column({ name: 'phone_number', type: 'varchar', length: 13 })
    phoneNumber: string;

    @Column({ name: 'insert_date', type: 'varchar', length: 30 })
    insertDate: string;

    @Column({ name: 'update_date', type: 'varchar', length: 30 })
    updateDate: string;

    @OneToMany(() => OrderEntity, order => order.customer)
    orders: OrderEntity[];
}

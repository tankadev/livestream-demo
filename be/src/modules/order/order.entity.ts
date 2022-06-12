import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { CustomerEntity } from '../customer/customer.entity';

@Entity('order')
export class OrderEntity {
    @PrimaryColumn({ name: 'uuid', type: 'char', length: 32 })
    uuid: string;

    @Column({ name: 'order_date', type: 'varchar', length: 30 })
    orderDate: string;

    @Column({ name: 'expected_delivery_date', type: 'varchar', length: 30 })
    expectedDeliveryDate: string;

    @Column({ name: 'delivery_date', type: 'varchar', length: 30 })
    deliveryDate: string;

    // 1-daguiyeucau,dangcho, 2-danglam, 3-daxong, 4-dagiao, 5-huy
    @Column({ name: 'status', type: 'tinyint', width: 1 })
    status: number;

    @Column({ name: 'expected_price', type: 'int' })
    expectedPrice: number;

    @Column({ name: 'price', type: 'int' })
    price: number;

    @Column({ name: 'note', type: 'text' })
    note: string;

    @Column({ name: 'image_url', type: 'varchar', length: 255 })
    imageUrl: string;

    @Column({ name: 'customer_uuid', type: 'char', length: 32 })
    customerUuid: string;

    // Foreign keys
    @ManyToOne(() => CustomerEntity, customer => customer.orders)
    @JoinColumn({ name: 'customer_uuid' })
    customer: CustomerEntity;
}

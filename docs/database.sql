CREATE DATABASE e_commerce_company;

CREATE SCHEMA IF NOT EXISTS user;

CREATE TABLE IF NOT EXISTS user.user (
    created_at timestamp,
    created_by uuid,
    modified_at timestamp,
    modified_by uuid,
    deleted_at timestamp,
    id uuid primary key,
    username varchar unique not null,
    password varchar not null,
    first_name varchar not null,
    last_name varchar,
    email varchar,
    phone varchar(15)
);

create table if not EXISTS user.user_address (
    created_at timestamp,
    created_by uuid,
    modified_at timestamp,
    modified_by uuid,
    deleted_at timestamp,
    id uuid,
    user_id uuid REFERENCES user.user(id),
    address_line varchar,
    phone varchar(15)
);

create SCHEMA if not EXISTS product;

create table if not EXISTS product.product (
    created_at timestamp,
    created_by uuid,
    modified_at timestamp,
    modified_by uuid,
    deleted_at timestamp,
    id uuid primary key,
    sku varchar,
    name varchar,
    description varchar,
    thumbnail varchar,
    image varchar,
    unit int,
    price bigint default 0,
    currency_unit varchar
);

create table if not EXISTS product.category (
    created_at timestamp,
    created_by uuid,
    modified_at timestamp,
    modified_by uuid,
    deleted_at timestamp,
    id uuid primary key,
    name varchar unique not null,
    description varchar
);

create table if not EXISTS product.product_category (
    created_at timestamp,
    created_by uuid,
    modified_at timestamp,
    modified_by uuid,
    deleted_at timestamp,
    id uuid primary key,
    product_id uuid REFERENCES product.product(id),
    category_id uuid REFERENCES product.category(id)
);

CREATE INDEX product_category_ix ON product.product_category (product_id, category_id)
WHERE (deleted_at is null);

create schema if not EXISTS activity;

create table if not EXISTS activity.order (
    created_at timestamp,
    created_by uuid,
    modified_at timestamp,
    modified_by uuid,
    deleted_at timestamp,
    id uuid primary key,
    user_id uuid REFERENCES user.user(id),
    ammount bigint,
    order_address_id uuid REFERENCES user.user_address(id),
    order_date timestamp,
    order_status varchar
);

create table if not EXISTS activity.order_detail (
    created_at timestamp,
    created_by uuid,
    modified_at timestamp,
    modified_by uuid,
    deleted_at timestamp,
    id uuid primary key,
    order_id uuid REFERENCES activity.order(id),
    product_id uuid REFERENCES product.product(id),
    price bigint,
    currency_unit varchar,
    quantity int
);
create table payment_provider (
    id varchar(255) NOT NULL,
    created datetime DEFAULT NULL,
    created_by varchar(255) DEFAULT NULL,
    status_record varchar(255) NOT NULL,
    updated datetime DEFAULT NULL,
    updated_by varchar(255) DEFAULT NULL,
    code varchar(100) NOT NULL,
    logo varchar(255) DEFAULT NULL,
    name varchar(100) NOT NULL
);

ALTER TABLE payment_provider
  ADD PRIMARY KEY (id);

create table invoice_type (
    id varchar(255) NOT NULL,
    created datetime DEFAULT NULL,
    created_by varchar(255) DEFAULT NULL,
    status_record varchar(255) NOT NULL,
    updated datetime DEFAULT NULL,
    updated_by varchar(255) DEFAULT NULL,
    code varchar(100) NOT NULL,
    name varchar(100) NOT NULL
);

ALTER TABLE invoice_type
  ADD PRIMARY KEY (id);

create table invoice (
  id varchar(255) NOT NULL,
  created datetime DEFAULT NULL,
  created_by varchar(255) DEFAULT NULL,
  status_record varchar(255) NOT NULL,
  updated datetime DEFAULT NULL,
  updated_by varchar(255) DEFAULT NULL,
  description varchar(255) NOT NULL,
  amount decimal(19,2) NOT NULL,
  due_date date NOT NULL,
  invoice_number varchar(255) NOT NULL,
  paid bit(1) NOT NULL,
  id_invoice_type varchar(255) NOT NULL
);

ALTER TABLE invoice
  ADD PRIMARY KEY (id),
  ADD KEY FKco4sbxv9cj2oevm6cdpq76ffb (id_invoice_type);
ALTER TABLE invoice
  ADD CONSTRAINT invoice_unique_number UNIQUE (invoice_number);
ALTER TABLE invoice
  ADD CONSTRAINT FKco4sbxv9cj2oevm6cdpq76ffb FOREIGN KEY (id_invoice_type) REFERENCES invoice_type (id);

create table virtual_account (
  id varchar(255) NOT NULL,
  created datetime DEFAULT NULL,
  created_by varchar(255) DEFAULT NULL,
  status_record varchar(255) NOT NULL,
  updated datetime DEFAULT NULL,
  updated_by varchar(255) DEFAULT NULL,
  account_number varchar(255) NOT NULL,
  company_id varchar(255) NOT NULL,
  virtual_account_type varchar(255) NOT NULL,
  id_invoice varchar(255) NOT NULL,
  id_payment_provider varchar(255) NOT NULL
);

ALTER TABLE virtual_account
  ADD PRIMARY KEY (id),
  ADD KEY FKbbdwdxpgdisiikyyhf2xteblc (id_invoice),
  ADD KEY FKt3t7f64hvgk4xjblsovqqkpll (id_payment_provider);
ALTER TABLE virtual_account
  ADD CONSTRAINT FKbbdwdxpgdisiikyyhf2xteblc FOREIGN KEY (id_invoice) REFERENCES invoice (id),
  ADD CONSTRAINT FKt3t7f64hvgk4xjblsovqqkpll FOREIGN KEY (id_payment_provider) REFERENCES payment_provider (id);

create table payment (
  id varchar(255) NOT NULL,
  created datetime DEFAULT NULL,
  created_by varchar(255) DEFAULT NULL,
  status_record varchar(255) NOT NULL,
  updated datetime DEFAULT NULL,
  updated_by varchar(255) DEFAULT NULL,
  amount decimal(19,2) NOT NULL,
  provider_reference varchar(255) NOT NULL,
  transaction_time datetime NOT NULL,
  id_virtual_account varchar(255) NOT NULL
);

ALTER TABLE payment
  ADD PRIMARY KEY (id),
  ADD KEY FKptriq88d7e8io9mhri8p10cq0 (id_virtual_account);
ALTER TABLE payment
  ADD CONSTRAINT FKptriq88d7e8io9mhri8p10cq0 FOREIGN KEY (id_virtual_account) REFERENCES virtual_account (id);
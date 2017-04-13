CREATE TABLE calendar (
	id INT IDENTITY (1, 1)
	,cdate DATETIME NOT NULL
	,day TINYINT NOT NULL
	,month TINYINT NOT NULL
	,year SMALLINT NOT NULL
);

ALTER TABLE calendar ADD CONSTRAINT calendar_pk PRIMARY KEY (id);
ALTER TABLE calendar ADD CONSTRAINT calendar_cdate_unq UNIQUE (cdate);

-----------------------

CREATE TABLE [user] (
	id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID()
);

ALTER TABLE [user] ADD CONSTRAINT user_pk PRIMARY KEY (id);

-----------------------



/*CREATE TABLE money_movement_type (
	id TINYINT NOT NULL
	,[name] NVARCHAR(200) NOT NULL
);

ALTER TABLE money_movement_type ADD CONSTRAINT money_movement_type_pk PRIMARY KEY (id);

INSERT INTO money_movement_type
(
	[id]
	,[name]
)
VALUES
(
	0
	,N'Приход'
),
(
	1
	,N'Расход'
);*/

-----------------------

CREATE TABLE predefined_money_movement (
	id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID()
	,[name] NVARCHAR(200) NOT NULL
	,[user_id] UNIQUEIDENTIFIER NOT NULL	
	,default_value_unsigned MONEY NOT NULL
	,sign MONEY NOT NULL

);

ALTER TABLE predefined_money_movement ADD CONSTRAINT predefined_money_movement_pk PRIMARY KEY (id);
ALTER TABLE predefined_money_movement ADD CONSTRAINT predefined_money_movement_user_fk FOREIGN KEY (user_id) REFERENCES [USER] (id);


-----------------------

CREATE TABLE money_transaction_category (
	id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID()
	,parent_id UNIQUEIDENTIFIER NULL DEFAULT NEWID()
	,[user_id] UNIQUEIDENTIFIER NOT NULL
	,[name] NVARCHAR(200) NOT NULL
);


ALTER TABLE money_transaction_category ADD CONSTRAINT money_transaction_category_pk PRIMARY KEY (id);
ALTER TABLE money_transaction_category ADD CONSTRAINT money_transaction_category_user_fk FOREIGN KEY (user_id) REFERENCES [USER] (id);
ALTER TABLE money_transaction_category ADD CONSTRAINT money_transaction_category_user_fk FOREIGN KEY (parent_id) REFERENCES money_transaction_category (id);

-----------------------

CREATE TABLE money_transaction (
	id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID()
	,[user_id] UNIQUEIDENTIFIER NOT NULL
	,[calendar_id] INT NOT NULL
	,is_planned BIT NOT NULL
	,[description] NVARCHAR(200) NULL
	,value_unsigned MONEY NOT NULL
	,sign MONEY NOT NULL
);

ALTER TABLE money_transaction ADD CONSTRAINT money_transaction_pk PRIMARY KEY (id);
ALTER TABLE money_transaction ADD CONSTRAINT money_transaction_user_fk FOREIGN KEY (user_id) REFERENCES [USER] (id);
ALTER TABLE money_transaction ADD CONSTRAINT money_transaction_accomplishment_type_fk FOREIGN KEY (accomplishment_type) REFERENCES money_transaction_accomplishment_type (id);

-----------------------
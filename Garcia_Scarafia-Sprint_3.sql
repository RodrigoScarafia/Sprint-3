-- Nivel 1 exercici 1

/*Tu tarea es diseñar y crear una tabla llamada "credit_card" que almacene detalles cruciales sobre las tarjetas de crédito. 
La nueva tabla debe ser capaz de identificar de forma única cada tarjeta y establecer una relación adecuada con las otras 
dos tablas ("transaction" y "company"). Después de crear la tabla será necesario que ingreses la información del documento 
denominado "datos_introducir_credit". Recuerda mostrar el diagrama y realizar una breve descripción del mismo.
*/

-- cremaos el índice
create index idx_credit_card_id on transaction(credit_card_id);
-- cremaos tabla credit_card
create table if not exists credit_card (
		id varchar(15) primary key,
        iban varchar(150),
        pan varchar(150),
        pin varchar(100),
        cvv varchar(100),
        expiring_date varchar(100)
);
-- creamos la FK en la tabla de hechos transaction
alter table transaction
add foreign key (credit_card_id) references credit_card(id);

 -- exploración y muestra de tablas
show columns from credit_card;
-- alter table credit_card change pan pan varchar(150);
-- drop table credit_card;
show tables;
desc credit_card;
desc transaction;

-- Nivel 1 Exercici 2

-- El departamento de Recursos Humanos ha identificado un error en el número de cuenta del usuario con ID CcU-2938. 
-- La información que debe mostrarse para este registro es: R323456312213576817699999. Recuerda mostrar que el cambio 
-- se realizó.

select iban from credit_card where id = 'CcU-2938';

update credit_card set iban = 'R323456312213576817699999' where id = 'CcU-2938';

-- nivel 1 Exercici 3

/*
En la tabla "transaction" ingresa un nuevo usuario con la siguiente información:

Id	108B1D1D-5B23-A76C-55EF-C568E49A99DD
credit_card_id	CcU-9999
company_id	b-9999
user_id	9999
lato	829.999
longitud	-117.999
amunt	111.11
declined	0
*/
-- verifico los campos de la tabla transaction para ver los tipos de datos a insertar, agrego el campo timestamp que faltaba.
desc transaction; -- values('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999, -117.999, current_date(), 111.11, 0);
-- confirmo que la compañia no existe en la tabla compañia, verifico los campos de la tabla y agrego el id
select * from company
where id = 'b-9999';
desc company;
insert into company(id) values ('b-9999');
-- verificación del cumplimiento de las restricciones de clave externa (FK) en credit_card (id)
select id from credit_card where id = 'CcU-9999';
insert into credit_card(id) values ('CcU-9999');

-- ingreso el nuevo usuario solicitado
insert into transaction(id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined)
values('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999, -117.999, current_date(), 111.11, 0);
-- visualizo la transacción insertada
select * from transaction
order by timestamp desc
limit 5;

-- delete from transaction where company_id = 'b-9999';
-- delete from company where id = 'b-9999';

-- Nivel 1 Exercici 4

-- Desde recursos humanos te solicitan eliminar la columna "pan" de la tabla credit_card. Recuerda mostrar el cambio realizado.

SELECT pan FROM credit_card;
alter table credit_card drop column pan;
show columns from credit_card;

-- drop table credit_card
-- corro codigo sin foreign key
-- creo FK segun discord
-- ordenar código de arriba a abajo

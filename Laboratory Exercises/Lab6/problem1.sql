-- 1
create or replace trigger retain_removed_agents_call_history
before delete on Agent_Seler
for each row
begin
    update Scheduled_Talks
    set AGENT_SELLER_SSN = 'Seller Removed from DB'
    where AGENT_SELLER_SSN = :OLD.ssn;
end;


-- delete from Agent_Seler where id = '101010101'
--2

-- kreiranje na nova kolona i zadavanje na 0, moze i so set default, no oracle ne dava
alter table AGENT_SELER add TotalNumberOfCalls NUMBER;
update AGENT_SELER
set TotalNumberOfCalls =0

--triggerot
CREATE OR REPLACE TRIGGER total_number_of_calls
AFTER INSERT ON SCHEDULED_TALKS
FOR EACH ROW
BEGIN
    UPDATE AGENT_SELER
    SET TotalNumberOfCalls = TotalNumberOfCalls + 1
    WHERE AGENT_SELER.ssn = :NEW.AGENT_SELLER_SSN;
END;

-- testiranje
insert into Scheduled_Talks(AGENT_SELLER_SSN) values(101010101)

select * from Scheduled_Talks

select * from Agent_Seler

--3
-- dodavanje kolona
select * from store
alter table store add StockQuantity NUMBER
select * from store

--zemanje kolicini i nivno soodvetno popolnuvanje vo prodavnicata

create view store_stock_quantity(store_id, stock_quantity) as(
select store_id, sum(count) as StockQuantity from stock group by store_id)

update store s
set StockQuantity = (select stock_quantity from store_stock_quantity where store_stock_quantity.store_id = s.id)

select * from store

select * from stock

--trigeri
create or replace trigger update_quantity
after update of count on stock
for each row
begin
    update store
    set StockQuantity = StockQuantity - :OLD.count + :NEW.count
    where store.id = :old.store_id;
end

create or replace trigger add_new_product
after insert on stock
for each row
begin
    update store
    set StockQuantity = StockQuantity + :NEW.count
    where store.id = :new.store_id;
end

create or replace trigger delete_product
after delete on stock
for each row
begin
    update store
    set StockQuantity = StockQuantity - :old.count
    where store.id = :old.store_id;
end;

select * from stock


delete stock
where id = 1

select * from store
--4
-- dodavanje na kolonata
select * from store
alter table store add TotalGoodsPrice NUMBER



--zemanje na vkupna cena i soodvetno popolnuvanje vo prodavnicata
create or replace view store_total_goods_price(store_id, total_price) as(select store_id, sum(total) from (select store_id, product_code, sum(count) * (select price from product where product.code = product_code) as total from stock
group by store_id, product_code) group by store_id)

select * from store_total_goods_price

update store s
set TotalGoodsPrice = (select total_price from store_total_goods_price where store_total_goods_price.store_id = s.id)

select * from store

--trigeri
create or replace trigger add_new_product_total
after insert on stock
for each row
begin
    update store
    set TotalGoodsPrice = TotalGoodsPrice + (select price from product where product.code = :new.product_code) * :new.count
    where store.id = :new.store_id;
end

create or replace trigger remove_product_total
after delete on stock
for each row
begin
    update store
    set TotalGoodsPrice = TotalGoodsPrice + (select price from product where product.code = :old.product_code) * :old.count
    where store.id = :old.store_id;
end

create or replace trigger change_stock_total
after update of count on stock
for each row
begin
    update store
    set TotalGoodsPrice = TotalGoodsPrice - ((select price from product where product.code = :old.product_code) * :old.count) + ((select price from product where product.code = :new.product_code) * :new.count)
    where store.id = :new.store_id;
end

select * from product
select * from stock

--ke go povika prethodniot triger
create or replace trigger change_product_price_total
before update of price on product
for each row
begin
    update stock
    set count = count + 1 - 1
    where stock.product_code = :new.code;
end


--testiranje
select * from stock
select * from product


update product set price = 1000 where code = 'ABC124'

select * from store

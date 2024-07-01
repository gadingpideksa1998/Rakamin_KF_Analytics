CREATE TABLE kimia_farma.tabel_analisa as
SELECT A.transaction_id, A.date, A.branch_id, B.branch_name, B.kota, B.provinsi, B.rating as rating_cabang, A.customer_name, A.product_id, C.product_name, A.price 
,A.discount_percentage,
CASE 
 WHEN A.price <= 50000 Then 0.1
 WHEN A.price BETWEEN 50001 AND 100000 Then 0.15
 WHEN A.price BETWEEN 100001 AND 300000 Then 0.2
 WHEN A.price BETWEEN 300001 AND 500000 Then 0.25
 WHEN A.price >= 500001 Then 0.3
END as persentase_gross_laba ,
A.price - (A.price * A.discount_percentage) as nett_sales,
CASE 
 WHEN A.price <= 50000 Then A.price*0.1
 WHEN A.price BETWEEN 50001 AND 100000 Then A.price*0.15
 WHEN A.price BETWEEN 100001 AND 300000 Then A.price*0.2
 WHEN A.price BETWEEN 300001 AND 500000 Then A.price*0.25
 WHEN A.price >= 500001 Then A.price*0.3
END as nett_profit ,
A.rating
FROM kimia_farma.kf_final_transaction as A
left join kimia_farma.kf_kantor_cabang as B
on A.branch_id = B.branch_id
left join kimia_farma.kf_product as C
on A.product_id = C.product_id

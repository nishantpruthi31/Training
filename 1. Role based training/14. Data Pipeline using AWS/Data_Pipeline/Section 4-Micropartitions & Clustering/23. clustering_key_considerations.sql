use role accountadmin;

use role sysadmin; 

use schema "ECOMMERCE_DB"."ECOMMERCE_LIV";

alter table lineitem cluster by (L_SUPPKEY,L_SHIPDATE);

create table lineitem_clone clone lineitem;

alter table lineitem_clone cluster by (L_SUPPKEY,L_SHIPDATE);  // sup_key has low cardinality i.e. unique values are less and hence it will be in first order

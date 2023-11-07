/*
tạo thủ tục sau L:
- Tạo thủ tục trả về danh sách sản phẩm
- tạo thủ tục thêm mới sản phẩm
- Tạo thủ tục cập nhập sản phẩm
- Tạo thủ tục xoá sản phẩm
- Tạo thủ tục phân trang ( truyển vào số limit , số trang hiện tại ) ;
*/
use shop_managenment;

DELIMITER //
CREATE PROCEDURE proc_getall_pro()
begin
    SELECT * from products;
end //
DELIMITER ;
call proc_getall_pro();

DELIMITER //
CREATE PROCEDURE proc_update_pro( IN id int ,IN new_name varchar(50) , In new_price int  )
begin
    UPDATE products set product_name = new_name , product_price = new_price where product_id = id;
end //
DELIMITER ;

call proc_update_pro(6, 'iphone 15', 11);

DELIMITER //
CREATE PROCEDURE proc_delete_pro( In id int  )
begin
    DELETE from products where product_id = id ;
end //
DELIMITER ;

call proc_delete_pro(7);

-- phân trang
/*
Hình dung bài toán
    - Truyền vào số lượng limit ( số sản phẩm bạn muốn xuất hiêhb trên 1 trang )
    - số trang hiện tại
INPUT ( )
*/
-- xoá prodcdure
DROP PROCEDURE  proc_pagination_pro;
DELIMITER //
CREATE PROCEDURE proc_pagination_pro( in no_page int   , In limit_pro int )
begin
    DECLARE start INT ;
    SET start = (no_page -1) * limit_pro ;
    SELECT * from products limit start, limit_pro  ;
end //
DELIMITER ;

call proc_pagination_pro(2,2);
call proc_getall_pro();


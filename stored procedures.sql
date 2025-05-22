use AssetManagement;
go 

--CREATE PROCEDURE sp_AddAsset
--	@asset_id int,
--    @name NVARCHAR(100),
--    @type NVARCHAR(50),
--    @serial_number NVARCHAR(100),
--    @purchase_date DATE,
--    @location NVARCHAR(100),
--    @status NVARCHAR(50),
--    @owner_id INT
--AS
--BEGIN
--    INSERT INTO assets (asset_id,name, type, serial_number, purchase_date, location, status, owner_id)
--    VALUES (@asset_id,@name, @type, @serial_number, @purchase_date, @location, @status, @owner_id);
--END;
--go

----------------------------------------
CREATE PROCEDURE sp_UpdateAsset
    @asset_id INT,
    @name NVARCHAR(100),
    @type NVARCHAR(50),
    @location NVARCHAR(100),
    @status NVARCHAR(50)
AS
BEGIN
    UPDATE assets
    SET name = @name,
        type = @type,
        location = @location,
        status = @status
    WHERE asset_id = @asset_id;
END;
go

-------------------------------------------
CREATE PROCEDURE sp_DeleteAsset
    @id INT
AS
BEGIN
    DELETE FROM assets WHERE asset_id = @id;
END;
go

--------------------------------------------
CREATE PROCEDURE sp_AllocateAsset
    @asset_id INT,
    @employee_id INT,
    @allocation_date DATE
AS
BEGIN
    INSERT INTO asset_allocations (asset_id, employee_id, allocation_date)
    VALUES (@asset_id, @employee_id, @allocation_date);
END;
go
------------------------------------------------
CREATE PROCEDURE sp_DeallocateAsset
    @asset_id INT,
    @employee_id INT,
    @return_date DATE
AS
BEGIN
    UPDATE asset_allocations
    SET return_date = @return_date
    WHERE asset_id = @asset_id AND employee_id = @employee_id AND return_date IS NULL;
END;
go
---------------------------------------------------
CREATE PROCEDURE sp_PerformMaintenance
    @asset_id INT,
    @maintenance_date DATE,
    @description NVARCHAR(500),
    @cost FLOAT
AS
BEGIN
    INSERT INTO maintenance_records (asset_id, maintenance_date, description, cost)
    VALUES (@asset_id, @maintenance_date, @description, @cost);
END;
go
--------------------------------------------------
CREATE PROCEDURE sp_ReserveAsset
    @asset_id INT,
    @employee_id INT,
    @reservation_date DATE,
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    INSERT INTO reservations (asset_id, employee_id, reservation_date, start_date, end_date, status)
    VALUES (@asset_id, @employee_id, @reservation_date, @start_date, @end_date, 'pending');
END;
go
---------------------------------------------------
CREATE PROCEDURE sp_WithdrawReservation
    @reservation_id INT
AS
BEGIN
    UPDATE reservations
    SET status = 'cancelled'
    WHERE reservation_id = @reservation_id;
END;
go

----------------------------------
CREATE PROCEDURE sp_GetAllAssets
AS
BEGIN
    SELECT 
        asset_id,
        Name,
        Type,
        serial_number,
        purchase_date,
        Location,
        Status,
        owner_id
    FROM 
        assets
    ORDER BY 
        asset_id;
END;
go


---------------------------------------------------

CREATE PROCEDURE sp_GetAssetById
    @asset_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        asset_id,
        Name,
        Type,
        serial_number,
        purchase_date,
        Location,
        Status,
        owner_id
    FROM 
        assets
    WHERE 
        asset_id = @asset_id;
END

-------------------------------------------------------

CREATE PROCEDURE sp_AddAsset
    @asset_id INT,
    @name NVARCHAR(100),
    @type NVARCHAR(50),
    @serial_number NVARCHAR(100),
    @purchase_date DATE,
    @location NVARCHAR(100),
    @status NVARCHAR(50),
    @owner_id INT
AS
BEGIN
    INSERT INTO assets (asset_id, name, type, serial_number, purchase_date, location, status, owner_id)
    VALUES (@asset_id, @name, @type, @serial_number, @purchase_date, @location, @status, @owner_id)
END
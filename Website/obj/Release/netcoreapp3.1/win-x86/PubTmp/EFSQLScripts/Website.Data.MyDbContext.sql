IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [KhachHang] (
        [MaKh] int NOT NULL IDENTITY,
        [HoTen] nvarchar(100) NOT NULL,
        [SoDienThoai] nvarchar(20) NOT NULL,
        [Email] nvarchar(100) NOT NULL,
        [MatKhau] nvarchar(max) NULL,
        [DiaChi] nvarchar(max) NULL,
        [DangHoatDong] bit NOT NULL,
        [MaNgauNhien] nvarchar(10) NOT NULL,
        CONSTRAINT [PK_KhachHang] PRIMARY KEY ([MaKh])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [Loai] (
        [MaLoai] int NOT NULL IDENTITY,
        [TenLoai] nvarchar(100) NOT NULL,
        [MoTa] nvarchar(max) NULL,
        [MaLoaiCha] int NULL,
        CONSTRAINT [PK_Loai] PRIMARY KEY ([MaLoai]),
        CONSTRAINT [FK_Loai_Loai_MaLoaiCha] FOREIGN KEY ([MaLoaiCha]) REFERENCES [Loai] ([MaLoai]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [Reviews] (
        [Id] int NOT NULL IDENTITY,
        [Criteria] nvarchar(max) NULL,
        [Active] bit NOT NULL,
        CONSTRAINT [PK_Reviews] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [Role] (
        [RoleId] int NOT NULL IDENTITY,
        [RoleName] nvarchar(50) NOT NULL,
        [IsSystem] bit NOT NULL,
        CONSTRAINT [PK_Role] PRIMARY KEY ([RoleId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [Tag] (
        [TagKey] nvarchar(50) NOT NULL,
        [TagValue] nvarchar(max) NULL,
        CONSTRAINT [PK_Tag] PRIMARY KEY ([TagKey])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [DonHang] (
        [MaDh] uniqueidentifier NOT NULL,
        [NgayDat] datetime2 NOT NULL,
        [MaKh] int NULL,
        [NguoiNhan] nvarchar(max) NULL,
        [DiaChiGiao] nvarchar(max) NULL,
        [TongTien] float NOT NULL,
        [TinhTrangDonHang] int NOT NULL,
        CONSTRAINT [PK_DonHang] PRIMARY KEY ([MaDh]),
        CONSTRAINT [FK_DonHang_KhachHang_MaKh] FOREIGN KEY ([MaKh]) REFERENCES [KhachHang] ([MaKh]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [HangHoa] (
        [MaHangHoa] uniqueidentifier NOT NULL DEFAULT (newid()),
        [TenHh] nvarchar(100) NOT NULL,
        [DonGia] float NOT NULL,
        [GiamGia] tinyint NOT NULL,
        [SoLuong] int NOT NULL,
        [Hinh] nvarchar(max) NULL,
        [Hinh2] nvarchar(max) NULL,
        [Hinh3] nvarchar(max) NULL,
        [Hinh4] nvarchar(max) NULL,
        [Hinh5] nvarchar(max) NULL,
        [ChiTiet] nvarchar(max) NULL,
        [MoTa] nvarchar(200) NULL,
        [MaLoai] int NULL,
        [DiemReview] float NULL,
        CONSTRAINT [PK_HangHoa] PRIMARY KEY ([MaHangHoa]),
        CONSTRAINT [FK_HangHoa_Loai_MaLoai] FOREIGN KEY ([MaLoai]) REFERENCES [Loai] ([MaLoai]) ON DELETE SET NULL
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [UserRole] (
        [RoleId] int NOT NULL,
        [UserId] int NOT NULL,
        CONSTRAINT [PK_UserRole] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_UserRole_Role_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [Role] ([RoleId]) ON DELETE CASCADE,
        CONSTRAINT [FK_UserRole_KhachHang_UserId] FOREIGN KEY ([UserId]) REFERENCES [KhachHang] ([MaKh]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [DonHangChiTiet] (
        [MaDh] uniqueidentifier NOT NULL,
        [MaHh] uniqueidentifier NOT NULL,
        [SoLuong] int NOT NULL,
        [DonGia] float NOT NULL,
        CONSTRAINT [PK_DonHangChiTiet] PRIMARY KEY ([MaDh], [MaHh]),
        CONSTRAINT [FK_DonHangChiTiet_DonHang_MaDh] FOREIGN KEY ([MaDh]) REFERENCES [DonHang] ([MaDh]) ON DELETE CASCADE,
        CONSTRAINT [FK_DonHangChiTiet_HangHoa_MaHh] FOREIGN KEY ([MaHh]) REFERENCES [HangHoa] ([MaHangHoa]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [HangHoaTag] (
        [TagKey] nvarchar(50) NOT NULL,
        [MaHangHoa] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_HangHoaTag] PRIMARY KEY ([TagKey], [MaHangHoa]),
        CONSTRAINT [FK_HangHoaTag_HangHoa_MaHangHoa] FOREIGN KEY ([MaHangHoa]) REFERENCES [HangHoa] ([MaHangHoa]) ON DELETE CASCADE,
        CONSTRAINT [FK_HangHoaTag_Tag_TagKey] FOREIGN KEY ([TagKey]) REFERENCES [Tag] ([TagKey]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [HinhPhus] (
        [Id] uniqueidentifier NOT NULL,
        [Url] nvarchar(max) NULL,
        [Active] bit NOT NULL,
        [MaHangHoa] uniqueidentifier NULL,
        CONSTRAINT [PK_HinhPhus] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_HinhPhus_HangHoa_MaHangHoa] FOREIGN KEY ([MaHangHoa]) REFERENCES [HangHoa] ([MaHangHoa]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE TABLE [ReviewHangHoas] (
        [Id] uniqueidentifier NOT NULL,
        [NgayReview] datetime2 NOT NULL,
        [DiemReview] tinyint NOT NULL,
        [TieuChi] int NOT NULL,
        [MaHangHoa] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_ReviewHangHoas] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ReviewHangHoas_HangHoa_MaHangHoa] FOREIGN KEY ([MaHangHoa]) REFERENCES [HangHoa] ([MaHangHoa]) ON DELETE CASCADE,
        CONSTRAINT [FK_ReviewHangHoas_Reviews_TieuChi] FOREIGN KEY ([TieuChi]) REFERENCES [Reviews] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_DonHang_MaKh] ON [DonHang] ([MaKh]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_DonHangChiTiet_MaHh] ON [DonHangChiTiet] ([MaHh]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_HangHoa_MaLoai] ON [HangHoa] ([MaLoai]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE UNIQUE INDEX [IX_HangHoa_TenHh] ON [HangHoa] ([TenHh]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_HangHoaTag_MaHangHoa] ON [HangHoaTag] ([MaHangHoa]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_HinhPhus_MaHangHoa] ON [HinhPhus] ([MaHangHoa]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE UNIQUE INDEX [IX_KhachHang_Email] ON [KhachHang] ([Email]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_Loai_MaLoaiCha] ON [Loai] ([MaLoaiCha]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_ReviewHangHoas_MaHangHoa] ON [ReviewHangHoas] ([MaHangHoa]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_ReviewHangHoas_TieuChi] ON [ReviewHangHoas] ([TieuChi]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    CREATE INDEX [IX_UserRole_RoleId] ON [UserRole] ([RoleId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN

    SET IDENTITY_INSERT Role ON;
    INSERT INTO Role(RoleId, RoleName, IsSystem) VALUES(1, N'Quản trị Hệ thống', 1)
    INSERT INTO Role(RoleId, RoleName, IsSystem) VALUES(2, N'Bán hàng', 1)
    INSERT INTO Role(RoleId, RoleName, IsSystem) VALUES(3, N'Thủ kho', 1)
    INSERT INTO Role(RoleId, RoleName, IsSystem) VALUES(4, N'Khách hàng', 1)
    SET IDENTITY_INSERT Role OFF;             

END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN

        DECLARE @MaNV int
            
        BEGIN TRY
            BEGIN TRANSACTION
            INSERT INTO KhachHang(HoTen, SoDienThoai, Email, MatKhau, DangHoatDong, MaNgauNhien) VALUES(N'Quản trị Hệ thống', '0909009990', 'admin@gmail.com','3/7r0e9aA1fL6vZbPY1OV7qtlZyDywgFn3CoJ5WYMOMRtmwsTqWvZrGXR46BPjA+yLytl4ndmBgwcSAORZh5rA==', 1, '$96w1')

            SET @MaNV = @@IDENTITY

            --Set quyền
            INSERT INTO UserRole(RoleId, UserId) VALUES (1, @MaNV),(2, @MaNV),(3, @MaNV),(4, @MaNV)
            COMMIT TRANSACTION
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION
        END CATCH

END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20201122081125_Initial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20201122081125_Initial', N'3.1.4');
END;

GO


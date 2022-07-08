CREATE PROCEDURE dbo.UpdateDimHost 
@HostID int,
@HostName varchar(MAX), 
@HostSince datetime,
@Location varchar(Max),
@ResponseTime varchar(Max),
@Superhost bit,
@Neighbourhood varchar(Max),
@Verified bit
AS
BEGIN
if not exists (select hostSK from dbo.DimHost where AlternateHostID = @HostID)
BEGIN
insert into dbo.DimHost
(AlternateHostID, name, host_since, location, response_time, is_superhost, neighbourhood, verified, InsertDate, ModifiedDate) values
(@HostID, @HostName, @HostSince, @Location, @ResponseTime, @Superhost, @Neighbourhood, @Verified, GETDATE(), GETDATE())
END;
if exists (select hostSK from dbo.DimHost where AlternateHostID = @HostID)
BEGIN
update dbo.DimHost
set name = @HostName, 
	host_since = @HostSince, 
	location = @Location, 
	response_time = @ResponseTime, 
	is_superhost = @Superhost, 
	neighbourhood = @Neighbourhood,
	verified = @Verified,
	ModifiedDate = GETDATE()
where AlternateHostID = @HostID
END;
END;
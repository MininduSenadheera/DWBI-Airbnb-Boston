CREATE PROCEDURE dbo.UpdateDimListing
@ListingID int,
@Name varchar(100), 
@HostKey int,
@Location varchar(100), 
@Neighbourhood varchar(50),
@Zipcode varchar(50), 
@Latitude varchar(15), 
@Longitude varchar(50), 
@PropertyType varchar(50), 
@RoomType varchar(50), 
@Accomadates int,
@Bathrooms float,
@Bedrooms int,
@Beds int,
@Price money,
@MinimumNights int,
@Review int,
@Cancellation varchar(50)
AS
BEGIN
if not exists (select listingSK from dbo.DimListing where AlternateListingID = @ListingID)
BEGIN
insert into dbo.DimListing (AlternateListingID, [name], hostkey, [location], neighbourhood, zipcode, latitude, longitude, property_type, room_type, 
							accomadates, bathrooms, bedrooms, beds, price, minimum_nights, review_scores_rating, cancellation_policy, InsertDate, ModifiedDate)
values(@ListingID, @Name, @HostKey, @Location, @Neighbourhood, @Zipcode, @Latitude, @Longitude, @PropertyType, @RoomType, 
		@Accomadates, @Bathrooms, @Bedrooms, @Beds, @Price, @MinimumNights, @Review, @Cancellation, GETDATE(), GETDATE())
END;
if exists (select listingSK from dbo.DimListing where AlternateListingID = @ListingID)
BEGIN
update dbo.DimListing
set [name] = @Name, 
	hostkey = @HostKey, 
	[location] = @Location,
	neighbourhood = @Neighbourhood, 
	zipcode = @Zipcode, 
	latitude = @Latitude,
	longitude = @Longitude,
	property_type = @PropertyType, 
	room_type = @RoomType, 
	accomadates = @Accomadates,
	bathrooms = @Bathrooms, 
	bedrooms = @Bedrooms, 
	beds = @Beds,
	price = @Price, 
	minimum_nights = @MinimumNights, 
	review_scores_rating = @Review,
	cancellation_policy = @Cancellation,
	ModifiedDate = GETDATE()
where AlternateListingID = @ListingID
END;
END;
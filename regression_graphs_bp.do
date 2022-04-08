use airbnb_cleaning.dta, clear
//Writing a simple regression, probably not that meaningful, explaining the variation in prices
reg price2 bedrooms host_is_superhost host_has_profile_pic host_response_rate host_for_days dummy_property_type1 dummy_property_type2 dummy_room_type1 dummy_room_type2

//Exporting regression table
outreg2 using regression_table_bp.docx, replace ctitle (Model 1) label

//Creating a loop for drawing and saving separate graphs based on property type - apartment, b&b, house
foreach yvar in 1 2 3 {
	twoway (scatter price2 bedrooms if dummy_property_type`yvar'==1 ,title("dummy_property_type"`yvar')  xti("Number of bedrooms") yti("Price of listing") ylabel(, angle(horizontal))) 
graph export price_bedrooms_bp`yvar'.png, replace
}
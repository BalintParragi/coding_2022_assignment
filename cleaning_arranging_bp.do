pwd
import delimited raw\airbnb_london_listing.csv, clear
describe
//Removing $ and , from price, dropping missing values
destring price, generate(price2) ignore("$ ,,")
drop if missing(price2)
sum price2
describe host_since
//Creating variable: for how many days a host is a host - going until the scraping date, 2017-03-05
replace host_since = subinstr(host_since, "-", "",.)
gen host_since_num_format = date(host_since,"YMD")
gen host_for_days = date("20170305", "YMD")-host_since_num_format
destring host_for_days,replace
//Aggregating values - mean - by neighbourhood
egen mean_price = mean(price2), by(neighbourhood_cleansed)

//Creating dummies instead of true or false
replace host_is_superhost = "1" if host_is_superhost == "t"
replace host_is_superhost = "0" if host_is_superhost == "f"
destring host_is_superhost,replace

replace host_has_profile_pic = "1" if host_has_profile_pic == "t"
replace host_has_profile_pic = "0" if host_has_profile_pic == "f"
destring host_has_profile_pic,replace

//Removing signs as percent or string NA
replace host_response_rate = subinstr(host_response_rate, "%", "",.)
replace host_response_rate = subinstr(host_response_rate, "N/A", "",.)
destring host_response_rate, replace

//Keeping only a couple of variable as there are many
keep price2 neighbourhood_cleansed host_has_profile_pic host_is_superhost host_response_rate host_for_days mean_price reviews_per_month cancellation_policy property_type room_type bathrooms bedrooms beds

//Calculating the share of each property type within the sample, then dropping the rare ones - below 1% share
bysort property_type: gen m_property = _N
gen m_property_share = m_property/_N
drop if m_property_share <= 0.01

replace bathrooms = subinstr(bathrooms, "NA", "",.)
destring bathrooms,replace
replace bedrooms = subinstr(bedrooms, "NA", "",.)
destring bedrooms,replace
replace beds = subinstr(beds, "NA", "",.)
destring beds,replace
replace reviews_per_month = subinstr(reviews_per_month, "NA", "",.)
destring reviews_per_month,replace

//Generating dummy columns instead of one - string - variable
tabulate property_type, generate(dummy_property_type)
tabulate room_type, generate(dummy_room_type)

save airbnb_cleaning.dta,replace

//Installing winsor2 package
ssc install winsor2
//This package is useful for trimming below and above specific thresholds - so to remove extreme outliers




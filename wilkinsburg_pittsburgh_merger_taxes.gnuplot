set terminal svg enhanced size 1920,1080

# https://alleghenycountytreasurer.us/real-estate-tax/
# 4.73 mills
allegheny_county_property_taxes(x) = x * (4.73/1000)

#
wilkinsburg_income_taxes(x) = x * 0.01
pittsburgh_income_taxes(x) = x * 0.03

# https://alleghenycountytreasurer.us/real-estate-tax/local-and-school-district-tax-millage/
wilkinsburg_borough_property_taxes(x) = x * (14.00/1000)
wilkinsburg_school_property_taxes(x) = x * (29.5/1000)
wilkinsburg_total_property_taxes(x) = wilkinsburg_borough_property_taxes(x) + wilkinsburg_school_property_taxes(x)

pittsburgh_borough_property_taxes(x) = x * (8.06/1000)
pittsburgh_school_property_taxes(x) = x * (9.95/1000)
pittsburgh_total_property_taxes(x) = pittsburgh_borough_property_taxes(x) + pittsburgh_school_property_taxes(x)


wilkinsburg_taxes(income,property) = wilkinsburg_income_taxes(income) + wilkinsburg_total_property_taxes(property)

pittsburgh_taxes(income,property) = pittsburgh_income_taxes(income) + pittsburgh_total_property_taxes(property)

pct_change(income,property) = wilkinsburg_taxes(income,property)/pittsburgh_taxes(income,property)

set tic scale 0

set palette rgbformula -7,2,-7
#set cbrange [0:5]
set cblabel "Percent Change"
unset cbtics

set termoption enhanced
save_encoding = GPVAL_ENCODING
set encoding utf8

set title "Proposed Wilkinsburg/Pittsburgh Merger Effect on Total Income and Property Tax for Wilkinsburg Residents"
#set key Left center top reverse
unset key
 
set xlabel "Earned Income Taxes"
set xrange [ 0 : 250000 ]
set format x "$%d"
set xtics auto
 
set yrange [ 0 : 750000 ]
set ylabel "Property Taxes"
set format y "$%d"
set ytics auto

set samples 50,30
set style fill solid 0.4 noborder

set view map

splot '++' matrix using 1:2:(pct_change($1,$2)) with image
#, \
#'++' matrix using 1:2:(pct_change($1,$2)) with labels


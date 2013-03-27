# NOTES:

This branch is for use with Spree 1.3.0 and later.

1.3-related changes:

1. Change the I18 default locale to use the Rails setting
2. Rework the GUI to work better with the new 1.3 admin GUI (this is a work in progress - it is functional at the moment, but certainly not pretty)

### Earlier changes

Forked from what appeared to the be the most up to date for, and made the following general changes:

1. Removed the route that overrides the main admin overview page
2. Fixed a warning about ```ADVANCED_REPORTS``` being redefined
3. Improved PDF generation ([custom ruport](http://github.com/iloveitaly/ruport/tree/wicked-pdf) uses wicked_pdf instead of the ancient PDF::Writer)

## Includes:
* Base reports of Revenue, Units, Profit into Daily, Weekly, Monthly, and Yearly increments
* Geo reports of Revenue, Units divided into states and countries
* Two "top" reports for top products and top customers
* The ability to limit reports by order date, "store" (multi-store extension), product, and taxon.
* The ability to export data in PDF or CSV format.
* Transaction reports

## Dependencies:
* Ruport and Ruport-util
* Google Visualization

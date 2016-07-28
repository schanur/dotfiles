
function timestamp {
    date --rfc-3339=seconds |sed -e 's/[-\ :]//g' |sed -e 's/\+.*$//g'
}

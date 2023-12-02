YEAR="2023"
BASE_DIR="base"

for DAY in $(seq -w 1 24)
do
	day_dir="$YEAR/$DAY"
	if [ ! -d "$day_dir" ]; then
		mkdir -p "$day_dir"
		(cd "$BASE_DIR" && git ls-files) | while read -r file; do
		    mkdir -p "$(dirname "$day_dir/$file")"
		    cp "$BASE_DIR/$file" "$day_dir/$file"
		done
		find $day_dir -type f -exec grep -l 'replace_year_day' {} \; | xargs gsed -i "s/replace_year_day/aoc_year${YEAR}_day${DAY}/g" 
		find $day_dir -type f -exec grep -l 'replace-year-day' {} \; | xargs gsed -i "s/replace-year-day/aoc-year${YEAR}-day${DAY}/g" 
	fi
done

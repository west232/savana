#!/bin/bash

which wget 1>/dev/null 2>/dev/null
if [ $? -ne 0 ]
then 
    echo "please install wget"
    exit 1
fi
# Step 1: Save content of 10 random websites to 10 files
websites=(
    "https://www.youtube.com/"
    "https://www.wikipedia.org"
    "https://nexus.io/"
    "https://www.nytimes.com"
    "https://www.linkedin.com"
    "https://www.stackoverflow.com"
    "https://www.reddit.com"
    "https://www.nationalgeographic.com"
    "https://www.udemy.com" 
    "https://www.amazon.com"
    # Add more websites as needed
)

for ((i=1; i<=${#websites[@]}; i++)); do
    curl -s "${websites[i-1]}" > "website_${i}.html"
done


# Step 2: Count matching lines with the string "href=" in each file
for ((i=1; i<=${#websites[@]}; i++)); do
    count=$(grep -o 'href=' "website_${i}.html" | wc -l)
    echo "${count}" > "count_${i}.txt"

    # Step 3: Save results to new 10 files with logical naming
    if [ "$count" -gt 0 ]; then
        grep -o 'href=' "website_${i}.html" > "href_matches_${i}.txt"
    else
        echo "No href matches found." > "href_matches_${i}.txt"
    fi
done

# Step 4: Delete the newly created 10 files with results
rm count_*.txt website_*.html href*

# Step 5: Measure execution time
start_time=$(date +%s.%N)
end_time=$(date +%s.%N)
execution_time=$(echo "$end_time - $start_time" | bc)
echo "Execution time: ${execution_time} seconds"
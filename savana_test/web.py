import requests
import os
import time
import zipfile
with zipfile.ZipFile('test.zip','w') as z:
    z.write('web.py')

# Function to save the content of a website to a file
def save_website_content(url, filename):
    response = requests.get(url)
    with open(filename, 'w', encoding='utf-8') as file:
        file.write(response.text)

# Function to count matching lines with the string "href=" in a file
def count_href_lines(filename):
    with open(filename, 'r', encoding='utf-8') as file:
        lines = file.readlines()
        return sum("href=" in line for line in lines)

# Function to save results to new files with logical naming
def save_results(counts, base_filename):
    for i, count in enumerate(counts, 1):
        result_filename = f"{base_filename}_{i}.txt"
        with open(result_filename, 'w', encoding='utf-8') as file:
            file.write(str(count))

# Function to delete files
def delete_files(*filenames):
    for filename in filenames:
        os.remove(filename)

# Function to measure execution time
def measure_execution_time(start_time):
    end_time = time.time()
    execution_time = end_time - start_time
    print(f"Execution time: {execution_time:.2f} seconds")

if __name__ == "__main__":
    # List of 10 random websites
    websites = [
         "https://www.youtube.com/",
    "https://www.wikipedia.org",
    "https://nexus.io/",
    "https://www.nytimes.com",
    "https://www.linkedin.com",
    "https://www.stackoverflow.com",
    "https://www.reddit.com",
    "https://www.nationalgeographic.com",
    "https://www.udemy.com" ,
    "https://www.amazon.com"
        # Add more websites as needed
    ]

    # Step 0: Record the start time
    start_time = time.time()

    # Step 1: Save content of 10 random websites to 10 files
    for i, website in enumerate(websites, 1):
        save_website_content(website, f"website_{i}.html")

    # Step 2: Count matching lines with the string "href=" in each file
    href_counts = [count_href_lines(f"website_{i}.html") for i in range(1, 11)]

    # Step 3: Save results to new files with logical naming
    save_results(href_counts, "results")

    # Step 4: Delete the newly created 10 files with results
    #delete_files(* [f"website_{i}.html" for i in range(1, 11)])
    delete_files(* [f"results_{i}.txt" for i in range(1, 11)])
 
    # Step 5: Measure execution time
    measure_execution_time(start_time)


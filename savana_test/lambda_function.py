import os
import time
import requests

def save_website_content(event, context):
    print("1") 
    response = requests.get(event, timeout=10)
    print("2") 
    with open(context, 'w', encoding='utf-8') as file:
        print("log to response is :", response.text) 
        file.write(response.text)
        print("log response is:", response.text) 

    # count matching lines with the string "href="
def count_href_lines(context):
    with open(context, 'r', encoding='utf-8') as file:
        
        lines = file.readlines()
        return sum("href=" in line for line in lines)

# save results to new files
def save_results(counts, base_filename):
    for i, count in enumerate(counts, 1):
        result_filename = f"/tmp/{base_filename}_{i}.txt"
        with open(result_filename, 'w', encoding='utf-8') as file:
            file.write(str(count))
            
# delete files
def delete_files(*filenames):
    for context in filenames:
        os.remove(context)

# measure execution time
def measure_execution_time(start_time):
    end_time = time.time()
    execution_time = end_time - start_time
    print(f"/tmp/Execution time: {execution_time:.2f} seconds")
          
def lambda_handler(event, context):
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
    ]
    
    # Record the start time
    start_time = time.time()
    print("the start time is:", start_time)
    #  Save content of 10 random websites to 10 files
    for i, website in enumerate(websites, 1):
        #print(website) 
        save_website_content(website, f"/tmp/website_{i}.html")
          
    # Count matching lines with the string "href=" in each file
    href_counts = [count_href_lines(f"/tmp/website_{i}.html") for i in range(1, 11)]
    print("number of href is:", href_counts)
     
    # Save results to new files with logical naming
    save_results(href_counts, "results")

    # Delete the newly created 10 files with results
    delete_files(*[f"/tmp/website_{i}.html" for i in range(1, 11)])

    # Measure execution time
    measure_execution_time(start_time)

    return {
        'statusCode': 200,
        'body':""
    }
#lambda_handler(False, False)
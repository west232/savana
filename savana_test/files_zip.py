
# import os
# from zipfile import ZipFile

# def zip_files(directory, zip_filename):
#     with ZipFile(zip_filename, 'w') as zipf:
#         for root, _, files in os.walk(directory):
#             for file in files:
#                 if file.startswith("web.py"):
#                     file_path = os.path.join(root, file)
#                     arcname = os.path.relpath(file_path, directory)
#                     zipf.write(file_path, arcname=arcname)

# if __name__ == "__main__":
#     # Specify the directory containing the files
#     directory_to_zip = "./savana"

#     # Specify the name of the zip file to create
#     zip_filename = "websites.zip"

#     # Call the function to zip files
#     zip_files(directory_to_zip, zip_filename)

#     print(f"All 'website' files in '{directory_to_zip}' are zipped to '{zip_filename}'.")

import zipfile
with zipfile.ZipFile('test.zip','w') as z:
    z.write('web.py')
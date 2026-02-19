# coding=utf-8
# Global variables that are use in more than one web test
import os
import json
from dotenv import load_dotenv
load_dotenv()  # Loads .env file if any

###
# environmentToRunTest - This is used by the "Open Browser" keyword to enable different browser configurations. "LOCAL" | "HEADLESS"
environmentToRunTest = os.getenv('environmentToRunTest') if os.getenv('environmentToRunTest') else 'LOCAL'

# URL of the website to test.
URL = "https://the-internet.herokuapp.com"

# Browser to use.
BROWSER = "Chrome"

COMMON_TIMEOUT = 5

# dictionaries
# Available files for download from the-internet.herokuapp.com/download
available_download_files = [
    "upload.txt",
    "sample-zip-file.zip",
    "test5-automation.spec.ts",
    "Testcase1_hubspot-crm.xlsx",
    "Jpeg_with_exif.jpeg",
    "fileupload.txt",
    "test1.csv",
    "random_data.txt",
    "images (2).jpeg",
    "letter-of-transmittal.pdf",
    "pixelcut-export.jpeg",
    "upload.txt.txt",
    "blank_pdf_for_test.pdf",
    "selenide-intro.txt",
    "sample_media_file.png",
    "bb.txt",
    "test-upload.txt",
    "some-file.txt",
    "LambdaTest.txt",
    "B0B477E6-9AE9-4D30-984A-8E653EA877D0.png",
    "testfile.txt"
]

JWT_KEY = os.getenv('TEST_SECRET_JWT_KEY')

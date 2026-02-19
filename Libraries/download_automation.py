# coding=utf-8
"""
Library for automating file downloads and validations.
Provides keywords to handle file downloads, verify downloads, and validate file properties.
"""

import os
import time
from pathlib import Path
from robot.api import logger


def get_downloads_folder():
    """
    Gets the downloads folder path for the project.
    Returns the Data/Files/Downloads folder within the project.
    
    Returns:
        str: Absolute path to the project downloads folder
    """
    project_root = os.getcwd()
    downloads_folder = os.path.join(project_root, "Data", "Files", "Downloads")
    
    # Create the folder if it doesn't exist
    if not os.path.exists(downloads_folder):
        os.makedirs(downloads_folder)
    
    logger.info(f"Downloads folder: {downloads_folder}")
    return downloads_folder


def wait_for_file_download(file_name, timeout_seconds=30, download_folder=None):
    """
    Waits for a file to be downloaded.
    
    Args:
        file_name (str): Name of the file to wait for
        timeout_seconds (int): Maximum time to wait in seconds (default: 30)
        download_folder (str): Path to the downloads folder (default: user's Downloads)
    
    Returns:
        str: Absolute path to the downloaded file
        
    Raises:
        AssertionError: If the file is not found within the timeout period
    """
    # Convert timeout_seconds to int since Robot Framework passes it as string
    timeout_seconds = int(timeout_seconds) if isinstance(timeout_seconds, str) else timeout_seconds
    
    if download_folder is None:
        download_folder = get_downloads_folder()

    start_time = time.time()
    file_path = os.path.join(download_folder, file_name)

    while time.time() - start_time < timeout_seconds:
        if os.path.exists(file_path):
            logger.info(f"File found: {file_path}")
            return file_path
        time.sleep(0.5)

    raise AssertionError(f"File '{file_name}' was not downloaded within {timeout_seconds} seconds")


def file_should_exist(file_path):
    """
    Validates that a file exists.
    
    Args:
        file_path (str): Absolute path to the file
        
    Raises:
        AssertionError: If the file does not exist
    """
    if not os.path.exists(file_path):
        raise AssertionError(f"File '{file_path}' does not exist")
    logger.info(f"File exists: {file_path}")


def file_should_not_be_empty(file_path):
    """
    Validates that a file is not empty (has size > 0).
    
    Args:
        file_path (str): Absolute path to the file
        
    Raises:
        AssertionError: If the file is empty (0 bytes)
    """
    if not os.path.exists(file_path):
        raise AssertionError(f"File '{file_path}' does not exist")

    file_size = os.path.getsize(file_path)
    if file_size == 0:
        raise AssertionError(f"File '{file_path}' is empty (0 bytes)")

    logger.info(f"File is not empty. Size: {file_size} bytes")


def get_file_size(file_path):
    """
    Gets the size of a file in bytes.
    
    Args:
        file_path (str): Absolute path to the file
    
    Returns:
        int: File size in bytes
        
    Raises:
        AssertionError: If the file does not exist
    """
    if not os.path.exists(file_path):
        raise AssertionError(f"File '{file_path}' does not exist")

    file_size = os.path.getsize(file_path)
    logger.info(f"File size: {file_size} bytes")
    return file_size


def delete_downloaded_file(file_path):
    """
    Deletes a downloaded file.
    
    Args:
        file_path (str): Absolute path to the file to delete
        
    Raises:
        AssertionError: If the file cannot be deleted
    """
    if os.path.exists(file_path):
        try:
            os.remove(file_path)
            logger.info(f"File deleted: {file_path}")
        except OSError as e:
            raise AssertionError(f"Could not delete file '{file_path}': {e}")
    else:
        logger.warn(f"File does not exist: {file_path}")


def clean_download_file(file_name, download_folder=None):
    """
    Cleans up (deletes) a file from the downloads folder if it exists.
    Used in test setup to ensure a clean state before downloading.
    
    Args:
        file_name (str): Name of the file to delete
        download_folder (str): Path to the downloads folder (default: project downloads)
    """
    if download_folder is None:
        download_folder = get_downloads_folder()
    
    file_path = os.path.join(download_folder, file_name)
    
    if os.path.exists(file_path):
        try:
            os.remove(file_path)
            logger.info(f"Cleaned up file: {file_path}")
        except OSError as e:
            logger.warn(f"Could not delete file '{file_path}': {e}")
    else:
        logger.info(f"File does not exist (nothing to clean): {file_path}")

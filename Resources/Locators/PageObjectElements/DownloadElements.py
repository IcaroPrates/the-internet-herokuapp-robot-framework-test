# coding=utf-8

# PageObject file name must be the name of the page, using:
# UpperCamelCase for file name.
# snake_case for variable names.

generic_download_link = "xpath://a[contains(text(), '{PARAMETER}')] | (//a[contains(text(), '{PARAMETER}')])[1]"
## Sets the Windows Terminal to have a random GIF as the background of the terminal window
By executing this PowerShell code it will update your profile.json settings of your Windows Terminal to a random gif in a folder you specify. Each profile (Terminal) will get an randomized gif. It will only update profiles that have been previously modified to contain the json element "backgroundImage". Any profiles that do not contain this element will not be updated. 

# Prerequisites
* You have updated at least 1 profile in profiles.json to have a "backgroundImage" definition

```
    "backgroundImage": "",
    "backgroundImageOpacity": 0.25,
    "backgroundImageStretchMode": "uniformToFill",
```
    The "useAcrylic" element must be set to false for Background Images to display
'''
    "useAcrylic":  false
'''
* You have download 1 or more gif's and saved them into a folder on your computer
* On Line 2 of the script set your gif's folder path location




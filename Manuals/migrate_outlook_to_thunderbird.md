# 1. Copy file with mails from Outlook

# 2. Install required script:
```
sudo pacman -S libpst
```

# 3. Create folder for .mbox files:
```
mkdir <folder>
```

# 4. Run script on your .pst file:
## 4.1. With original folder structure:
```
readpst -r /path/to/x.pst
```
## 4.2. With flattened folder structure (every folder gets an own file):
```
readpst /path/to/x.pst
```

# 5. In Thunderbird:
## 5.1. Install the Add-In “ImportExportTools NG” in Thunderbird
## 5.2. Create a folder “Import_PST_Data”
## 5.3. Right-Click on it
### 5.3.1. ImportExportTools NG
### 5.3.2. Import mbox Files
### 5.3.3. All mbox Files from directory / (with sdb structure)

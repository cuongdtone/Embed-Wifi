@echo off

REM Check if Python is installed
python --version
IF %ERRORLEVEL% EQU 0 (
    echo Python is installed.
) ELSE (
    REM
    echo Python is not installed. Installing to specific directory...

    REM Run the Python installer silently
    start /wait python-3.11.6-amd64.exe /quiet InstallAllUsers=1 PrependPath=1
    REM Check if Python installation was successful
    IF %ERRORLEVEL% EQU 0 (
        echo Python installed successfully.
    ) ELSE (
        echo Failed to install Python.
        goto end
    )
)

REM
pip --version
IF %ERRORLEVEL% EQU 0 (
    echo pip installed.
    goto b1
)

REM
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

REM
pip --version

:b1
pip install -r requirements.txt

:end


REM Tạo Shortcut
powershell -Command "$shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\\Desktop\\Embed-Wifi.lnk'); $shortcut.TargetPath = '%CD%\\pc-app.bat'; $shortcut.IconLocation = '%~dp0embed.ico'; $shortcut.Save()"

REM Đặt Shortcut vào giữa màn hình
powershell -Command "$shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\\Desktop\\Embed-Wifi.lnk'); $shortcut.WindowStyle = 3; $shortcut.Save()"


pause
@echo off
echo ============================================
echo    iPhone Clone - Build Script
echo ============================================
echo.

REM Change to the project directory
cd /d "%~dp0"

REM Check if node_modules exists
if not exist "node_modules" (
    echo [1/5] Installing dependencies...
    npm install
    if errorlevel 1 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
    echo [✓] Dependencies installed successfully
) else (
    echo [1/5] Dependencies already installed
)

echo.
echo [2/5] Running linting...
npm run lint
if errorlevel 1 (
    echo WARNING: Linting failed, but continuing with build...
) else (
    echo [✓] Linting completed successfully
)

echo.
echo [3/5] Building application...
npm run build
if errorlevel 1 (
    echo ERROR: Build failed
    pause
    exit /b 1
)
echo [✓] Build completed successfully

echo.
echo [4/5] Running build preview...
start /B npm run preview > preview.log 2>&1
timeout /t 3 /nobreak > nul
tasklist /FI "IMAGENAME eq node.exe" 2>NUL | find /I /N "node.exe">NUL
if errorlevel 1 (
    echo ERROR: Preview server failed to start
    pause
    exit /b 1
) else (
    echo [✓] Preview server started successfully
)

echo.
echo [5/5] Build Summary:
echo ============================================
echo Build Output: dist/
echo Preview URL: http://localhost:4173
echo ============================================
echo.
echo Build completed successfully! 🎉
echo.
echo Press any key to open the build folder...
pause > nul

REM Open the dist folder
if exist "dist" (
    explorer "dist"
)

echo.
echo Press any key to exit...
pause > nul
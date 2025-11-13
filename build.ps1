param(
    [switch]$SkipInstall,
    [switch]$SkipLint,
    [switch]$SkipPreview,
    [switch]$Clean,
    [string]$OutputDir = "dist"
)

# iPhone Clone - PowerShell Build Script
# This script provides advanced build options for the iPhone Clone project

$ErrorActionPreference = "Stop"

# Colors for output
$Green = "Green"
$Red = "Red"
$Yellow = "Yellow"
$Blue = "Cyan"
$White = "White"

function Write-ColoredOutput {
    param([string]$Message, [string]$Color = $White)
    Write-Host $Message -ForegroundColor $Color
}

function Write-Success { param([string]$Message) Write-ColoredOutput "[✓] $Message" $Green }
function Write-Error { param([string]$Message) Write-ColoredOutput "[✗] $Message" $Red }
function Write-Warning { param([string]$Message) Write-ColoredOutput "[!] $Message" $Yellow }
function Write-Info { param([string]$Message) Write-ColoredOutput "[i] $Message" $Blue }

Write-ColoredOutput "============================================" $Blue
Write-ColoredOutput "    iPhone Clone - PowerShell Build Script" $Blue
Write-ColoredOutput "============================================" $Blue
Write-ColoredOutput ""

# Check if we're in the right directory
if (!(Test-Path "package.json")) {
    Write-Error "package.json not found. Please run this script from the project root directory."
    exit 1
}

# Clean build directory if requested
if ($Clean) {
    Write-Info "Cleaning previous build..."
    if (Test-Path $OutputDir) {
        Remove-Item -Recurse -Force $OutputDir
        Write-Success "Cleaned $OutputDir directory"
    } else {
        Write-Info "No previous build to clean"
    }
    Write-ColoredOutput ""
}

# Step 1: Install dependencies
if (!$SkipInstall) {
    Write-Info "Step 1/4: Installing dependencies..."
    try {
        npm install
        Write-Success "Dependencies installed successfully"
    } catch {
        Write-Error "Failed to install dependencies: $($_.Exception.Message)"
        exit 1
    }
} else {
    Write-Info "Skipping dependency installation"
}

Write-ColoredOutput ""

# Step 2: Run linting
if (!$SkipLint) {
    Write-Info "Step 2/4: Running linting..."
    try {
        npm run lint
        Write-Success "Linting completed successfully"
    } catch {
        Write-Warning "Linting failed, but continuing with build..."
        Write-Warning "Error: $($_.Exception.Message)"
    }
} else {
    Write-Info "Skipping linting"
}

Write-ColoredOutput ""

# Step 3: Build the application
Write-Info "Step 3/4: Building application..."
try {
    npm run build
    Write-Success "Build completed successfully"
} catch {
    Write-Error "Build failed: $($_.Exception.Message)"
    exit 1
}

Write-ColoredOutput ""

# Step 4: Check build output and start preview
Write-Info "Step 4/4: Checking build output..."
if (Test-Path $OutputDir) {
    $buildSize = (Get-ChildItem -Recurse $OutputDir | Measure-Object -Property Length -Sum).Sum
    $buildSizeMB = [math]::Round($buildSize / 1MB, 2)
    Write-Success "Build output created in $OutputDir/ (${buildSizeMB} MB)"

    if (!$SkipPreview) {
        Write-Info "Starting preview server..."
        Write-Info "Preview server will be available at: http://localhost:4173"

        # Start preview server in background
        $previewJob = Start-Job -ScriptBlock {
            try {
                npm run preview
            } catch {
                Write-Error "Preview server failed: $($_.Exception.Message)"
            }
        }

        # Wait a moment for server to start
        Start-Sleep -Seconds 3

        # Check if server is running
        $nodeProcesses = Get-Process node -ErrorAction SilentlyContinue
        if ($nodeProcesses) {
            Write-Success "Preview server started successfully"
            Write-ColoredOutput ""
            Write-ColoredOutput "============================================" $Blue
            Write-ColoredOutput "           Build Summary" $Blue
            Write-ColoredOutput "============================================" $Blue
            Write-ColoredOutput "Build Output: $(Resolve-Path $using:OutputDir)" $White
            Write-ColoredOutput "Build Size:   ${buildSizeMB} MB" $White
            Write-ColoredOutput "Preview URL:  http://localhost:4173" $White
            Write-ColoredOutput "============================================" $Blue
            Write-ColoredOutput ""
            Write-Success "Build completed successfully! 🎉"
            Write-ColoredOutput ""
            Write-Info "Press Ctrl+C to stop the preview server and exit"

            # Wait for the preview job
            Wait-Job $previewJob
        } else {
            Write-Error "Preview server failed to start"
            exit 1
        }
    } else {
        Write-Info "Skipping preview server"
        Write-ColoredOutput ""
        Write-ColoredOutput "============================================" $Blue
        Write-ColoredOutput "           Build Summary" $Blue
        Write-ColoredOutput "============================================" $Blue
        Write-ColoredOutput "Build Output: $(Resolve-Path $OutputDir)" $White
        Write-ColoredOutput "Build Size:   ${buildSizeMB} MB" $White
        Write-ColoredOutput "============================================" $Blue
        Write-ColoredOutput ""
        Write-Success "Build completed successfully! 🎉"
    }
} else {
    Write-Error "Build output directory not found"
    exit 1
}
# iPhone Clone - Build Configuration

This directory contains multiple build scripts for different platforms and use cases.

## Available Build Scripts

### 1. `build.bat` (Windows Batch Script)
**Usage:** Double-click the file or run from command prompt
```cmd
build.bat
```

**Features:**
- Automatic dependency installation
- Linting check
- Production build
- Preview server startup
- Build size reporting
- Opens build folder automatically

### 2. `build.sh` (Unix/Linux Shell Script)
**Usage:** Make executable and run
```bash
chmod +x build.sh
./build.sh
```

**Features:**
- Cross-platform compatibility
- Colored output
- Error handling
- Build verification
- Preview server with process management

### 3. `build.ps1` (PowerShell Script)
**Usage:** Run with PowerShell
```powershell
.\build.ps1
```

**Advanced Features:**
- Command-line parameters for customization
- Conditional execution (skip steps)
- Clean build option
- Custom output directory
- Background job management

## PowerShell Script Parameters

```powershell
.\build.ps1 [parameters]

Parameters:
  -SkipInstall    Skip npm install step
  -SkipLint      Skip linting step
  -SkipPreview   Skip preview server
  -Clean         Clean previous build before building
  -OutputDir     Specify custom output directory (default: "dist")
```

## Examples

### Basic Build
```powershell
.\build.ps1
```

### Clean Build with Custom Output
```powershell
.\build.ps1 -Clean -OutputDir "build"
```

### Quick Build (Skip linting and preview)
```powershell
.\build.ps1 -SkipLint -SkipPreview
```

### Development Build (Skip install)
```powershell
.\build.ps1 -SkipInstall
```

## Build Output

All scripts generate production-ready files in the `dist/` directory containing:
- Optimized JavaScript bundles
- Minified CSS
- Static assets (images, fonts)
- HTML entry point

## Environment Variables

Create a `.env` file in the project root for custom configuration:

```env
# Build configuration
VITE_APP_TITLE=iPhone Clone
VITE_APP_VERSION=1.0.0
```

## Troubleshooting

### Common Issues

1. **Build fails with dependency errors**
   - Delete `node_modules` and run build again
   - Check Node.js version (recommended: 16+)

2. **Preview server doesn't start**
   - Check if port 4173 is available
   - Kill any existing Node.js processes

3. **Large build size**
   - Enable production mode optimizations
   - Check for unused dependencies

### Build Optimization Tips

- Use `npm ci` instead of `npm install` for CI/CD
- Enable gzip compression on your server
- Use CDN for static assets
- Implement code splitting for better performance

## Deployment

After building, deploy the `dist/` folder to your web server:

### Static Hosting (Netlify, Vercel, etc.)
```bash
# Build and deploy
npm run build
# Upload dist/ folder to hosting service
```

### Traditional Server
```bash
# Build for production
npm run build
# Copy dist/ contents to web server
```

## CI/CD Integration

### GitHub Actions Example
```yaml
name: Build and Deploy
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run build
      - run: npm run preview
```

## Performance Monitoring

After deployment, monitor your build with:
- Lighthouse performance scores
- Bundle analyzer (`npm install --save-dev webpack-bundle-analyzer`)
- Core Web Vitals metrics

---

**Happy Building! 🚀**
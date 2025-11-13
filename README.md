# iPhone Clone

A stunning 3D iPhone clone built with React, Three.js, and GSAP animations. This project showcases modern web technologies with smooth animations and interactive 3D models.

## ✨ Features

- **3D iPhone Model**: Interactive 3D iPhone built with Three.js and React Three Fiber
- **Smooth Animations**: GSAP-powered animations for fluid user experience
- **Responsive Design**: Optimized for all screen sizes
- **Modern UI**: Clean and intuitive user interface
- **Performance Optimized**: Fast loading and smooth interactions

## 🚀 Tech Stack

- **React 19** - Modern React with hooks
- **Vite** - Fast build tool and development server
- **Three.js** - 3D graphics library
- **React Three Fiber** - React renderer for Three.js
- **React Three Drei** - Useful helpers for React Three Fiber
- **GSAP** - High-performance animation library
- **Tailwind CSS** - Utility-first CSS framework

## 🛠️ Getting Started

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd iphone-clone
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

4. Open [http://localhost:5173](http://localhost:5173) in your browser.

## 📦 Build Scripts

This project includes multiple build scripts for different platforms:

### Windows (Batch Script)
```cmd
# Double-click or run:
build.bat
```

### Linux/Mac (Shell Script)
```bash
chmod +x build.sh
./build.sh
```

### PowerShell (Advanced Options)
```powershell
# Basic build
.\build.ps1

# Clean build with custom options
.\build.ps1 -Clean -SkipLint -OutputDir "build"
```

See `BUILD_README.md` for detailed build instructions and options.

## 📜 Available Scripts

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run preview  # Preview production build
npm run lint     # Run ESLint
```

## 🎯 Project Structure

```
iphone-clone/
├── build.bat          # Windows build script
├── build.sh           # Linux/Mac build script
├── build.ps1          # PowerShell build script
├── BUILD_README.md    # Detailed build documentation
├── eslint.config.js
├── index.html
├── package.json
├── README.md
├── vite.config.js
├── public/
│   └── assets/
└── src/
    ├── App.jsx
    ├── index.css
    ├── main.jsx
    └── components/
```

## 🎨 Customization

### Colors and Themes
Modify the Tailwind CSS configuration in `tailwind.config.js` to customize colors and themes.

### 3D Model
The 3D iPhone model can be customized by modifying the Three.js components in the `components/` directory.

### Animations
GSAP animations can be adjusted in the component files to change timing, easing, and effects.

## 🚀 Deployment

### Build for Production
```bash
npm run build
```

### Deploy to Static Hosting
Upload the `dist/` folder to any static hosting service like:
- Netlify
- Vercel
- GitHub Pages
- AWS S3 + CloudFront

### Environment Variables
Create a `.env` file for custom configuration:
```env
VITE_APP_TITLE=iPhone Clone
VITE_APP_VERSION=1.0.0
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run the build scripts to test
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Three.js community for the amazing 3D library
- GSAP for the smooth animation capabilities
- React ecosystem for the powerful development tools

---

**Enjoy exploring the iPhone Clone! 📱✨**

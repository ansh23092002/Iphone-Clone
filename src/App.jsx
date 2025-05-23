
import Navbar from './components/Navbar';
import Model from './components/Model';
import Hero from './components/Hero';
import Highlights from './components/Highlights';
import Features from './components/Features';
import Chips from './components/Chips';
import Footer from './components/footer';


const  App =()=> {
 
  return (
  
     <main className='bg-black'>
      <Navbar/>
      <Hero/>
      <Highlights/>
      <Model/>
      <Features/>
      <Chips/>
      <Footer/>
      </main>
  )
} 

export default App

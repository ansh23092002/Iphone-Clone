import { useGSAP } from "@gsap/react"
import gsap from "gsap";
import ModelView from "./ModelView";
import { useState,useRef,useEffect } from "react";
import { yellowImg } from "../utils";

import * as THREE from "three";
import { models, sizes } from "../constants";
import { Canvas } from "@react-three/fiber";
import { View } from "@react-three/drei";
import { animateWithGsapTimeline } from "../utils/animation";

const Model = () => {

    const [size, setSize] = useState('small');
    const [model, setModel] = useState({
        title:'iPhone 15 pro in Natural Titanium',
        color:['#8F8A81','#FFE7B9','#6F6C64'],
        img: yellowImg,
    });

    // changeing the 3D moble small to large 
    const tl = useRef(gsap.timeline());
    useEffect(() => {
      if(size ==="large") {
        animateWithGsapTimeline(tl.current,small , smallRotation, "#view1","#view2",{
          transform: 'translateX(-100%)',
          duration:1
        })
      } if(size=== "small"){
            animateWithGsapTimeline(tl.current,large,  largeRotation, "#view2","#view1",{
            transform: 'translateX(0)',
          duration:1
        })
      }
     
    }, [size, largeRotation, smallRotation]);

    // camera contol for the model  view 
    const cameraControlSmall = useRef();
    const cameraControlLarge = useRef();

    //Rotation 
    const [smallRotation,setSmallRotation] =useState(0);
    const [largeRotation, setLargeRotation] = useState(0);
    
    // Three Gs use {camera control }
    const small  = useRef(new THREE.Group());// for small model 
     const large  = useRef(new THREE.Group());// for large model 

    // View container refs
    const view1Ref = useRef();
    const view2Ref = useRef(); 

    useGSAP(()=>{
           gsap.to('#heading',{y:0, opacity:1}) 
    },[]);

  return (
    <section className="common-padding">
        <div className="screen-max-width">
            <h1 id="heading" className="section-heading">Take a closer look.</h1>

             <div className="flex flex-col items-center mt-5">
                <div className="w-full h-[75vh] md:h-[90vh] overflow-hidden relative">
                    <div ref={view1Ref} id="view1" className="w-full h-full absolute" />
                    <div ref={view2Ref} id="view2" className="w-full h-full absolute right-[-100%]" />

                    <Canvas className="w-full h-full" style={{position:'fixed',top:0, bottom:0,left:0, right:0,overflow:'hidden'}} eventPrefix="client">
                    <View.Port />
                    <ModelView 
                    index={1} groupRef={small} gsapType="view1" controlRef={cameraControlSmall}
                    setRotationState={setSmallRotation} item={model} size={size} trackRef={view1Ref}/>
                    <ModelView 
                    index={2} groupRef={large} gsapType="view2" controlRef={cameraControlLarge}
                    setRotationState={setLargeRotation} item={model} size={size} trackRef={view2Ref}/>
                    </Canvas>
                </div>
                <div className="mx-auto w-full"> 
                    <p className="text-sm font-light text-center mb-5">{model.title}</p>
                    <div className="flex-center ">
                      <ul className="color-container">  
                        {models.map((item,i)=>(
                        <li key={i} className="w-5 h-6 rounded-full  mx-2 cursor-pointer" style={{background:item.color[0] }} onClick={()=> setModel(item)}/>
                       
                       ))}
                     </ul>
                     <button className="size-btn-container">
                          {sizes.map(({label,value})=>(
                            <span key={label} className="size-btn" style={{backgroundColor: size=== value ?'white': 'transparent', 
                              color: size=== value?'black':'white',
                            }} onClick={()=>setSize(value)}>
                              {label}
                            </span> 
                          ))}
                     </button>
                    </div>
                </div>
             </div>
        </div>
    </section>
  )
}

export default Model

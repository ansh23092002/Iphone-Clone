import { footerLinks } from "../constants";

const Footer = () => {
  return (
    <footer className="py-5 sm:py-10 px-5">
      <div className="screen-max-width">
        <div>
          <p className="font-semibold text-gray-500 text-xs">
            More way to shop:
            <span className="underline text-blue-600">
              Find an Apple Stroe{" "}
            </span>
            or
            <span className="underline text-blue-600">Fother Retailer </span>{" "}
            near you.
          </p>
           <p className="font-semibold text-gray-500 text-xs">or call 00080-71-2637</p>
        </div>
        <div className=" bg-neutral-700 my-5 h-[1px] w-full"/>
        <div className="flex md:flex-row flex-col md:items-center justify-between">
        <p className="font-semibold text-gray-500 text-xs"> copyright @ 2024 Apple Inc. All rights reserved.</p>
        <div className="flex ">
            {footerLinks.map((link) =>(
                <p key={link} className="font-semibold text-gray-500 text-xs">

                </p>
            ) )}
        </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;

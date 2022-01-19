
// initialization
I2C1.setup({ scl : 26, sda: 25 });
const SI7021_Address = '0x40';
var sensor = require("MS5803").connectI2C( I2C1 );
var pressure=0;

//LOOP CYCLE CALIBRATION (20 sec)
var count=0;
var startTime = new Date().getTime();
var interval = setInterval(()=>{ 
//MS5803 PRESSURE SENSOR 

sensor.reset();
sensor.begin();         
sensor.read(sensor.PRECISION.ADC_512).then((result) => {
    console.log("Temperature: " + result.temperature + " °C" );
    pressure = pressure + parseFloat(result.pressure.toFixed(2));
    console.log("Pressure: " + parseFloat(result.pressure.toFixed(2)) + " mBar");
    console.log('  ');
  });
//SI7021 HUMIDITY SENSOR 
   var foo= require("SI7021").connect(I2C1);
   let RH = foo.readRelativeHmidity();
    console.log("Humidity: " + RH + " %RH");  
   console.log('  ');
  if(new Date().getTime() - startTime > 20000){
        clearInterval(interval);
        avgpressure= pressure/count;
        console.log("Average Pressure Value: " + avgpressure);
         return;
      
      }
count++; 
},100);

(function (logger) {
    console.old = console.log;
    console.log = function () {
        var output = "", arg, i;

        for (i = 0; i < arguments.length; i++) {
            arg = arguments[i];
            output += "<span class=\"log-" + (typeof arg) + "\">";

            if (
                typeof arg === "object" &&
                typeof JSON === "object" &&
                typeof JSON.stringify === "function"
            ) {
                output += JSON.stringify(arg);   
            } else {
                output += arg;   
            }

            output += "</span>&nbsp;";
        }

        logger.innerHTML += output + "<br>";
        console.old.apply(undefined, arguments);
    };
})(document.getElementById("logger"));



// LOOP CYCLE READING 

setTimeout (() =>{
  setInterval(()=>{ 
//MS5803 PRESSURE SENSOR 

sensor.reset();
sensor.begin();         
sensor.read(sensor.PRECISION.ADC_512).then((result) => {
    console.log("Temperature: " + result.temperature + " °C" );
    console.log("Pressure: " + (parseFloat(result.pressure.toFixed(2)-avgpressure)) + " mBar");
    console.log('  ');
  });
//SI7021 HUMIDITY SENSOR 
   var foo= require("SI7021").connect(I2C1);
   let RH = foo.readRelativeHmidity();
    console.log("Humidity: " + RH + " %RH");  
   console.log('  ');
},100);
}, 40000);

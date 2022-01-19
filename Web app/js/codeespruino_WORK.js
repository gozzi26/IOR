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
    var data={}; 
    data.t= result.temperature.toFixed(2);
    pressure = pressure + parseFloat(result.pressure.toFixed(2));
    data.p=parseFloat(result.pressure.toFixed(2)); 
    console.log(data);
  });

  if(new Date().getTime() - startTime > 20000){
        clearInterval(interval);
        avgpressure= pressure/count;
       // console.log("Average Pressure Value: " + avgpressure);
         return;
      
      }
count++; 
},100);


// LOOP CYCLE READING 

setTimeout (() =>{
  setInterval(()=>{ 
//MS5803 PRESSURE SENSOR 

sensor.reset();
sensor.begin();         
sensor.read(sensor.PRECISION.ADC_512).then((result) => {
  var data={};
    data.t=result.temperature.toFixed(2);
    data.p=(parseFloat(result.pressure.toFixed(2)-avgpressure)).toFixed(2);
    console.log(data);
  });

},100);
}, 40000);


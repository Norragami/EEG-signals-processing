class LowPassFilter{
//// 30 HZ Lowpass filter
// // Numerator:  
// static double b0 = 0.000007864582431117388133931175864255181;
// static double b1 = 0.000078645824311173888115575336676954521;
// static double b2 = 0.000353906209400282401652398922564657369;
// static double b3 = 0.00094374989173408644054646954302256745;
// static double b4 = 0.001651562310534651027010832891050995386;
// static double b5 = 0.001981874772641581579357694664622613345;
// static double b6 = 0.001651562310534651460691701885252768989;
// static double b7 = 0.000943749891734086548966686791573010851;
// static double b8 = 0.000353906209400282455862507546839879069;
// static double b9 = 0.000078645824311173888115575336676954521;
// static double b10 = 0.000007864582431117388133931175864255181;
                   

static double b0 =0.008914457239463019488923123390122782439 ;
static double b1 =0.035657828957852077955692493560491129756  ;
static double b2 =0.053486743436778116933538740340736694634  ;
static double b3 =0.035657828957852077955692493560491129756   ;
static double b4 =0.008914457239463019488923123390122782439   ;
//  0.000007864582431117388133931175864255181  
// 0.000078645824311173888115575336676954521  
// 0.000353906209400282401652398922564657369  
// 0.00094374989173408644054646954302256745   
// 0.001651562310534651027010832891050995386  
// 0.001981874772641581579357694664622613345  
// 0.001651562310534651460691701885252768989  
// 0.000943749891734086548966686791573010851  
// 0.000353906209400282455862507546839879069  
// 0.000078645824311173888115575336676954521  
// 0.000007864582431117388133931175864255181  
// Denominator:                               
//                    
static double a1 = -2.048395137764509321698369603836908936501;
static double a2 =  1.841785841678162505274940485833212733269;
static double a3 = -0.782440103120936480962654968607239425182;
static double a4 =  0.131680715038691775742307754626381210983;


// static double a1 =-5.187004030285041977776927524246275424957;  
// static double a2 =12.811436406425322331870120251551270484924;
// static double a3 =-19.561083496292187788867522613145411014557;
// static double a4 =20.28702275242558528134395601227879524231;
// static double a5 =-14.85320231561015447141471668146550655365;
// static double a6 = 7.744559705112955327876989031210541725159;
// static double a7 =-2.831049565480619811808082886273041367531;
// static double a8 = 0.692722559385493874550832060776883736253;
// static double a9 =-0.102251507681233755331362544893636368215;
// static double a10 = 0.006902824409346522069319540548804070568;                
//  -5.187004030285041977776927524246275424957
//  12.811436406425322331870120251551270484924
// -19.561083496292187788867522613145411014557
//  20.28702275242558528134395601227879524231 
// -14.85320231561015447141471668146550655365 
//   7.744559705112955327876989031210541725159
//  -2.831049565480619811808082886273041367531
//   0.692722559385493874550832060776883736253
//  -0.102251507681233755331362544893636368215
//   0.006902824409346522069319540548804070568

  static List<double> filter(List<double> channel) {
    List<double> result = List.filled(channel.length, 0);

    // for (int i = 11; i<channel.length; i++) {
      // result[i]=(b0*channel[i] + b1*channel[i-1] + b2*channel[i-2] 
      //     + b3*channel[i-3] + b4*channel[i-4] + b5*channel[i-5] 
      //     + b6*channel[i-6] + b7*channel[i-7] + b8*channel[i-8] 
      //     + b9*channel[i-9] + b10*channel[i-10] + a1*result[i-1] 
      //     + a2*result[i-2] + a3*result[i-3] + a4*result[i-4] 
      //     + a5*result[i-5] + a6*result[i-6] + a7*result[i-7] 
      //     + a8*result[i-8] + a9*result[i-9] + a10*result[i-10]);
    for (int i = 4; i<channel.length; i++) {
      result[i]=(b0*channel[i] + b1*channel[i-1] + b2*channel[i-2] 
          + b3*channel[i-3] + b4*channel[i-4] - a1*result[i-1] 
          - a2*result[i-2] - a3*result[i-3] - a4*result[i-4]);
    }
    return  result;
  }
}






class Filter50Hz {
  
// static double b0 = 0.921878498246021971240793391189072281122;
// static double b1 =-2.849661180608559885030217628809623420238;
// static double b2 = 8.132880178476389332331564219202846288681;
// static double b3 =-13.576967809869648462495206331368535757065;
// static double b4 = 20.462599549077250316031495458446443080902;
// static double b5 =-21.537870375290015800828768988139927387238;
// static double b6 = 20.462599549077250316031495458446443080902;
// static double b7 =-13.576967809869648462495206331368535757065;
// static double b8 = 8.132880178476391108688403619453310966492;
// static double b9 =-2.849661180608559885030217628809623420238;
// static double b10 = 0.921878498246021971240793391189072281122;

// static double a1 = -3.040866342369468178219449328025802969933;
// static double a2 = 8.53633502857608483793683262774720788002;
// static double a3 = -14.019281781041668111242870509158819913864;
// static double a4 = 20.785682522890240875312883872538805007935;
// static double a5 = -21.525118593154203949779912363737821578979;
// static double a6 = 20.120325099923981326810462633147835731506;
// static double a7 = -13.136089465204838333534098637755960226059;
// static double a8= 7.742513834680843309854481049114838242531;
// static double a9= -2.669772174476418236110930592985823750496;
// static double a10= 0.849859965528344862839560391876148059964;

static double bo =   0.965080986344733937620787855848902836442;
static double b1 = -1.193282554333347178499025176279246807098;
static double b2 =    2.299023051351233526418127439683303236961;
static double b3 = -1.193282554333347178499025176279246807098;
static double b4 =     0.965080986344733937620787855848902836442;

static double a1 = -1.214493479318976998371226727613247931004;
static double a2 =   2.297803341913798202966745520825497806072;
static double a3 = -1.172071629347716026359194074757397174835;
static double a4 =   0.931381682126902532559142855461686849594;





static List<double> filter (List<double> channel) {

List<double> result = List.filled(channel.length, 0);

  // for (int i = 11; i<channel.length; i++) {
  //   result[i]=(b0*channel[i] + b1*channel[i-1] + b2*channel[i-2]
  //       + b3*channel[i-3] + b4*channel[i-4] + b5*channel[i-5]
  //       + b6*channel[i-6] + b7*channel[i-7] + b8*channel[i-8]
  //       + b9*channel[i-9] + b10*channel[i-10] - a1*result[i-1]
  //       - a2*result[i-2] - a3*result[i-3] - a4*result[i-4]
  //       - a5*result[i-5] - a6*result[i-6] - a7*result[i-7]
  //       - a8*result[i-8] - a9*result[i-9] - a10*result[i-10]);
  for (int i = 4; i<channel.length; i++) {
   result[i]=(bo*channel[i] + b1*channel[i-1] + b2*channel[i-2]
        + b3*channel[i-3] + b4*channel[i-4] - a1*result[i-1]
        - a2*result[i-2] - a3*result[i-3] - a4*result[i-4]);



  
  }
  return  result;
}

////50 Hz filter
// Numerator:                                 
//   0.921878498246021971240793391189072281122
//  -2.849661180608559885030217628809623420238
//   8.132880178476389332331564219202846288681
// -13.576967809869648462495206331368535757065
//  20.462599549077250316031495458446443080902
// -21.537870375290015800828768988139927387238
//  20.462599549077250316031495458446443080902
// -13.576967809869648462495206331368535757065
//   8.132880178476391108688403619453310966492
//  -2.849661180608559885030217628809623420238
//   0.921878498246021971240793391189072281122
// Denominator:                               
//                                           
//  -3.040866342369468178219449328025802969933
//   8.53633502857608483793683262774720788002 
// -14.019281781041668111242870509158819913864
//  20.785682522890240875312883872538805007935
// -21.525118593154203949779912363737821578979
//  20.120325099923981326810462633147835731506
// -13.136089465204838333534098637755960226059
//   7.742513834680843309854481049114838242531
//  -2.669772174476418236110930592985823750496
//   0.849859965528344862839560391876148059964

}





////bandpass filter 14-30 Hz
class BandPassFilter {
  static double bo =  0.001016116320113559208862530347516894835 ;
  static double b1 =  0                                         ;
  static double b2 = -0.004064465280454236835450121390067579341 ;  
  static double b3 =  0                                         ;
  static double b4 =  0.006096697920681355686856051079303142615 ;
  static double b5 = 0;
  static double b6 = -0.004064465280454236835450121390067579341 ;
  static double b7 = 0;
  static double b8 =  0.001016116320113559208862530347516894835 ;
  
  static double a1 =  -6.038117050206028402214997186092659831047;
  static double a2 =  16.702378553038716546552677755244076251984;
  static double a3 = -27.536641133275665538349130656570196151733;
  static double a4 =  29.547004438127881797981899580918252468109;
  static double a5 = -21.116969164532203961925915791653096675873;
  static double a6 =   9.822890374195518248257030791137367486954;
  static double a7 =  -2.72445261587102738332077933591790497303 ;
  static double a8 =   0.346724621516500852713704716734355315566;

  static List<double> filter(List<double> channel) {
    List<double> result = List.filled(channel.length, 0);
    for (int i = 8; i < channel.length; i++) {
      result[i]=(bo*channel[i] + b1*channel[i-1] + b2*channel[i-2]
           + b3*channel[i-3] + b4*channel[i-4] + b5*channel[i-5]
           + b6*channel[i-6] + b7*channel[i-7] + b8*channel[i-8]
           - a1*result[i-1] - a2*result[i-2] - a3*result[i-3]
           - a4*result[i-4] - a5*result[i-5] - a6*result[i-6]
           - a7*result[i-7] - a8*result[i-8]);
    }
    return result;
  }
  
}

class Detrend{


  // static List<double> detrend(List<double> channel) {
  //   List<double> result = List.filled(channel.length, 0);
  //   for (int i = 1; i < channel.length; i++) {
  //     result[i]=channel[i]-channel[i-1];
  //   }

  // static List<double> detrend(List<double> channel) {
  //   List<double> result = List.filled(channel.length, 0);
  //   for (int i = 0; i < channel.length; i++) {
  //     var start = 0;
  //     var end = 0;
  //     if (i-3<0){start=0;}else{start=i-3;}
  //     if(i+3>channel.length){end=channel.length;}else{end=i+3;}
  //     var mean = channel.sublist(start, end).reduce((a, b) => a + b) / (end-start);
      
  //     result[i]=mean;
  //   }

  //   return result;
  // }
  static List<double> detrend(List<double> channel){
    List<double> result = List.filled(channel.length, 0);
    List<double> x = List.generate(channel.length, (i) => i.toDouble());
    var meanX = x.reduce((a, b) => a + b) / x.length;
    var meanY = channel.reduce((a, b) => a + b) / channel.length;
    double numemator = 0;
    double denominator = 0;
    for(int i = 0; i < channel.length; i++){
      numemator += (x[i]-meanX)*(channel[i]-meanY);
      denominator += (x[i]-meanX)*(x[i]-meanX);
    }
    var b1 = numemator/denominator;
    var b0 = meanY - b1*meanX;
    for(int i = 0; i < channel.length; i++){
      result[i] = channel[i] - b0 - b1*x[i];
    }




    return result ;
  }
}
void setupGUI(){
  controlP5 = new ControlP5(this); 
  Bang b=controlP5.addBang("save",width-controlWidth+10,height-50,275,40);
  b.setLabel("");
  b.setId(205);
  Textlabel lbl=controlP5.addTextlabel("lblSave","save image", width-controlWidth+120,height-35);

  ControlGroup selection = controlP5.addGroup("selection",width-controlWidth+10,150,275);
  selection.setVisible(false);
  RadioButton r = controlP5.addRadioButton("attractorType",0,10);
  r.add("random",-1);
  r.add("blended",0);
  r.add("branched",1);
  r.add("simple blended",2); 
  r.add("simple branched",3);
  r.add("Gumowski-Mira",4);
  r.add("modified Gumowski-Mira",5);
  r.add("trigonometric",6); 
  r.add("Clifford",7);
  r.add("Peter de Jong",8);
  r.add("plaid",9);
  r.add("wreath",10); 
  r.add("modified wreath",11);
  r.add("desynced wreath",12);
  r.add("generic wreath",13);
  r.add("generic branched",14); 
  r.add("generic blended",15);
   r.activate("random");
  r.setGroup(selection);
  r.setId(1);

  ControlGroup general = controlP5.addGroup("general",width-controlWidth+10,150,275);
  general.setVisible(false);
  b=controlP5.addBang("mutate",0,10,275,40);
  b.setLabel("");
  b.setGroup(general);
  b.setId(3);
  lbl=controlP5.addTextlabel("lblMutate","mutate attractor", 110,25);
  lbl.setGroup(general);

  ControlGroup render =controlP5.addGroup("render",width-controlWidth+10,170,275);
  render.setVisible(false);
  
  r = controlP5.addRadioButton("quality",80,10);
  r.add("fast",0);
  r.add("bilinear",1);
  r.add("gaussian",2);
  r.activate("bilinear");
  r.setGroup(render);
  r.setId(11);
  r = controlP5.addRadioButton("sourceType",150,10);
  r.addItem("square",0);
  r.addItem("cross",1);
  r.addItem("grid",2);
  r.addItem("circle",3);
  r.addItem("rings",4);
  r.addItem("mozaic",5);
  r.addItem("spiral",6);
  r.activate("square");
  r.setGroup(render); 
  r.setId(12);

  ControlGroup particles =controlP5.addGroup("particles",width-controlWidth+10,300,275);
  particles.setVisible(false);
  Slider s =controlP5.addSlider("range",0.1f,200f,2f,0,10,120,10);
  s.setGroup(particles);
  s.setId(20);
  s =controlP5.addSlider("numberOfParticles",1,10000,1000,0,30,120,10);
  s.setGroup(particles);
  s.setId(21);
  s =controlP5.addSlider("particleLife",1,1000,500,0,50,120,10);
  s.setGroup(particles);
  s.setId(23);
  s =controlP5.addSlider("cutoff",0,20,1,0,70,120,10);
  s.setGroup(particles);
  s.setId(24);

  ControlGroup transforms= controlP5.addGroup("transforms",width-controlWidth+10,410,275);
  transforms.setVisible(false);
  s =controlP5.addSlider("symmetry",1,16,1,100,10,175,10);
  s.setGroup(transforms);
  s.setLabel("");
  s.setId(30);
  lbl=controlP5.addTextlabel("lblSymm","rotational symmetry",0,10);
  lbl.setGroup(transforms);
  lbl=controlP5.addTextlabel("lblMirror","mirror symmetry",0,30);
  lbl.setGroup(transforms);
  r = controlP5.addRadioButton("mirror",10,45);
  r.add("no mirror",0);
  r.add("x mirror",2);
  r.add("y mirror",3);
  r.add("x and y mirror",6); 
  r.activate("no mirror");
  r.setGroup(transforms);
  r.setId(31);
  Knob k=controlP5.addKnob("mirrorRotation",0f,360f,0f,130,30,60);
  k.setGroup(transforms);
  k.setId(33);
  k=controlP5.addKnob("rotation",0f,360f,0f,0,110,60);
  k.setGroup(transforms);
  k.setId(34);

  ControlGroup centers= controlP5.addGroup("centers",width-controlWidth+10,620,275);
  centers.setVisible(false);
  r = controlP5.addRadioButton("centerMode",15,30);
  r.add("display center",0);
  r.add("symmetry center",1);
  r.add("mirror center",2);
  r.add("rotation center",3); 
  r.setGroup(centers);
  r.setId(35);
  lbl=controlP5.addTextlabel("lblCenters","Press 'c' to put selected center at mouse position.", 13,10);
  lbl.setGroup(centers);

  ControlGroup channel= controlP5.addGroup("channel",width-controlWidth+10,150,275);
  channel.setVisible(false);
  lbl=controlP5.addTextlabel("lblChannel","select color channel",0,10);
  lbl.setGroup(channel);
  r = controlP5.addRadioButton("colorChannel",10,25);
  r.add("bri",2);
  r.add("hue",0);
  r.add("sat",1);
  r.activate("bri");
  r.setGroup(channel);
  r.setId(36);

  ControlGroup controls= controlP5.addGroup("controls",width-controlWidth+10,240,275);
  controls.setVisible(false);
  lbl=controlP5.addTextlabel("lblBias","bias",30,10);
  lbl.setGroup(controls);
  lbl=controlP5.addTextlabel("lblGain","gain",130,10);
  lbl.setGroup(controls);
  lbl=controlP5.addTextlabel("lblMultiplier","multiplier",220,10);
  lbl.setGroup(controls);
   lbl=controlP5.addTextlabel("lblOffset","offset",30,135);
  lbl.setGroup(controls);
  lbl=controlP5.addTextlabel("lblMin","min",130,135);
  lbl.setGroup(controls);
  lbl=controlP5.addTextlabel("lblMax","max",220,135);
  lbl.setGroup(controls);
  
  k=controlP5.addKnob("bias",0.1f,4.0f,1.0f,0,25,75);
  k.setId(40);
  k.setLabel("");
  k.setGroup(controls);
  k=controlP5.addKnob("gain",0.01f,0.99f,.5f,100,25,75);
  k.setLabel("");
  k.setId(50);
  k.setGroup(controls);
  k=controlP5.addKnob("multiplier",0f,3f,1f,200,25,75);
  k.setLabel("");
  k.setId(60);
  k.setGroup(controls); 
  
  k=controlP5.addKnob("offset",0f,1f,0f,0,150,75);
  k.setId(70);
  k.setLabel("");
  k.setGroup(controls);
  k=controlP5.addKnob("min",0f,1f,0f,100,150,75);
  k.setLabel("");
  k.setId(80);
  k.setGroup(controls);
  k=controlP5.addKnob("max",0f,1f,1f,200,150,75);
  k.setLabel("");
  k.setId(90);
  k.setGroup(controls); 
  
  
  b =controlP5.addBang("biasMinusL",0,110,11,11);
  b.setLabel("");
  b.setId(41);
  b.setGroup(controls);
  b =controlP5.addBang("biasMinusS",16,110,11,11);
  b.setLabel("");
  b.setId(42);
  b.setGroup(controls);
  b =controlP5.addBang("biasReset",32,110,11,11);
  b.setLabel("");
  b.setId(43);
  b.setGroup(controls);
  b =controlP5.addBang("biasPlusS",48,110,11,11);
  b.setLabel("");
  b.setId(44);
  b.setGroup(controls);
  b =controlP5.addBang("biasPlusL",64,110,11,11);
  b.setLabel("");
  b.setId(45);
  b.setGroup(controls);
  b =controlP5.addBang("gainMinusL",100,110,11,11);
  b.setLabel("");
  b.setId(51);
  b.setGroup(controls);
  b =controlP5.addBang("gainMinusS",116,110,11,11);
  b.setLabel("");
  b.setId(52);
  b.setGroup(controls);
  b =controlP5.addBang("gainReset",132,110,11,11);
  b.setLabel("");
  b.setId(53);
  b.setGroup(controls);
  b =controlP5.addBang("gainPlusS",148,110,11,11);
  b.setLabel("");
  b.setId(54);
  b.setGroup(controls);
  b =controlP5.addBang("gainPlusL",164,110,11,11);
  b.setLabel("");
  b.setId(55);
  b.setGroup(controls);
  b =controlP5.addBang("multMinusL",200,110,11,11);
  b.setLabel("");
  b.setId(61);
  b.setGroup(controls);
  b =controlP5.addBang("multMinusS",216,110,11,11);
  b.setLabel("");
  b.setId(62);
  b.setGroup(controls);
  b =controlP5.addBang("multReset",232,110,11,11);
  b.setLabel("");
  b.setId(63);
  b.setGroup(controls);
  b =controlP5.addBang("multPlusS",248,110,11,11);
  b.setLabel("");
  b.setId(64);
  b.setGroup(controls);
  b =controlP5.addBang("multPlusL",264,110,11,11);
  b.setLabel("");
  b.setId(65);
  b.setGroup(controls);
  
  
  b =controlP5.addBang("offsetMinusL",0,235,11,11);
  b.setLabel("");
  b.setId(71);
  b.setGroup(controls);
  b =controlP5.addBang("offsetMinusS",16,235,11,11);
  b.setLabel("");
  b.setId(72);
  b.setGroup(controls);
  b =controlP5.addBang("offsetReset",32,235,11,11);
  b.setLabel("");
  b.setId(73);
  b.setGroup(controls);
  b =controlP5.addBang("offsetPlusS",48,235,11,11);
  b.setLabel("");
  b.setId(74);
  b.setGroup(controls);
  b =controlP5.addBang("offsetPlusL",64,235,11,11);
  b.setLabel("");
  b.setId(75);
  b.setGroup(controls);
  b =controlP5.addBang("minMinusL",100,235,11,11);
  b.setLabel("");
  b.setId(81);
  b.setGroup(controls);
  b =controlP5.addBang("minMinusS",116,235,11,11);
  b.setLabel("");
  b.setId(82);
  b.setGroup(controls);
  b =controlP5.addBang("minReset",132,235,11,11);
  b.setLabel("");
  b.setId(83);
  b.setGroup(controls);
  b =controlP5.addBang("minPlusS",148,235,11,11);
  b.setLabel("");
  b.setId(84);
  b.setGroup(controls);
  b =controlP5.addBang("minPlusL",164,235,11,11);
  b.setLabel("");
  b.setId(85);
  b.setGroup(controls);
  b =controlP5.addBang("maxMinusL",200,235,11,11);
  b.setLabel("");
  b.setId(91);
  b.setGroup(controls);
  b =controlP5.addBang("maxMinusS",216,235,11,11);
  b.setLabel("");
  b.setId(92);
  b.setGroup(controls);
  b =controlP5.addBang("maxReset",232,235,11,11);
  b.setLabel("");
  b.setId(93);
  b.setGroup(controls);
  b =controlP5.addBang("maxPlusS",248,235,11,11);
  b.setLabel("");
  b.setId(94);
  b.setGroup(controls);
  b =controlP5.addBang("maxPlusL",264,235,11,11);
  b.setLabel("");
  b.setId(95);
  b.setGroup(controls);
 
  ControlGroup options= controlP5.addGroup("options",width-controlWidth+10,515,275);
  options.setVisible(false);
  lbl=controlP5.addTextlabel("lblOptions","select options for selected channel",0,10);
  lbl.setGroup(options);
  Toggle t=controlP5.addToggle("symmetric",10,55,10,10);
  t.setLabel("");
  t.setGroup(options);
  t.setId(102);
  lbl=controlP5.addTextlabel("lblSymmetric","symmetric",25,55);
  lbl.setGroup(options);
  t=controlP5.addToggle("repeat",10,70,10,10);
  t.setLabel("");
  t.setGroup(options);
  t.setId(103);
  lbl=controlP5.addTextlabel("lblRepeat","repeat",25,70);
  lbl.setGroup(options);  
  t=controlP5.addToggle("pingpong",10,85,10,10);
  t.setLabel("");
  t.setGroup(options);
  t.setId(104);
  lbl=controlP5.addTextlabel("lblPingPong","pingpong",25,85);
  lbl.setGroup(options);  
  t=controlP5.addToggle("invert",10,100,10,10);
  t.setLabel("");
  t.setGroup(options);
  t.setId(105);
  lbl=controlP5.addTextlabel("lblInvert","invert",25,100);
  lbl.setGroup(options);  

  ControlGroup colorBars= controlP5.addGroup("colorBars",width-controlWidth+10,660,275);
  colorBars.setVisible(false);
  lbl=controlP5.addTextlabel("lblBriBar","B",0,82);
  lbl.setGroup(colorBars);
  lbl=controlP5.addTextlabel("lblHueBar","H",0,42);
  lbl.setGroup(colorBars);
  lbl=controlP5.addTextlabel("lblSatBar","S",0,62);
  lbl.setGroup(colorBars);
  briBar = new Colorbar(width-controlWidth+25,740,260,10,new genericFunction(0.5f,0.5f,1f,0f,0f,1f,false,false,false,true,false),2); 
  hueBar = new Colorbar(width-controlWidth+25,700,260,10,new genericFunction(0.5f,0.5f,1f,0f,0f,1f,false,false,false,true,false),0); 
  satBar = new Colorbar(width-controlWidth+25,720,260,10,new genericFunction(0.5f,0.5f,1f,0f,0f,1f,false,false,false,true,false),1); 

  ControlGroup info= controlP5.addGroup("info",width-controlWidth+10,20,275);
  controlP5.addTextlabel("nfo1","                                               ",0,10).setGroup(info);
  controlP5.addTextlabel("nfo2","                                               ",10,32).setGroup(info);
  controlP5.addTextlabel("nfo3","                                               ",10,44).setGroup(info);
  controlP5.addTextlabel("nfo4","                                               ",10,56).setGroup(info);
  controlP5.addTextlabel("nfo5","                                               ",10,68).setGroup(info);
  controlP5.addTextlabel("nfo6","                                               ",10,80).setGroup(info);
  controlP5.addTextlabel("nfo7","                                               ",10,92).setGroup(info);
  controlP5.addTextlabel("nfo8","                                               ",10,104).setGroup(info);
  controlP5.addTextlabel("nfo9","                                               ",100,10).setGroup(info);
}

void updateGUI(){
  fill(0f,0f,.1f);
  rect(width-controlWidth,0,controlWidth-1,height);
  String s1="";
  String s2="";
  String s3="";
  String s4="";
  String s5="";
  String s6="";
  String s7="";
  String s8="";
  String s9="";
  switch(attractorDisplayArray.mode){
  case AttractorDisplayArray.INIT:
    s1="initializing";
    break;
  case AttractorDisplayArray.WAITING:    
    s1="waiting for selection";
    s2="click attractor for full screen mode.";
    s3="'1' : generate random attractors.";
    break;
  case AttractorDisplayArray.FULLSCREENACTIVE:
    s1="active view.";
    s9="updates: "+((attractorDisplayArray.active)?attractorDisplayArray.activeDisplay.NOfUpdates:0);
    s2="'1' : go back to attractor selection. All changes will be lost!";
    s3="'3' : go to attractor controls.";
    s4="'4' : go to color controls.";
    s5="'5' : go to stealth mode (a lot faster).";
        s7="Click save to save image.";
  s8="";
    break;
  case AttractorDisplayArray.FULLSCREENMODIFY:
    s1="modification preview";
    s2="'2' : go to active view";
    s3="'5' : go to stealth mode (a lot faster).";
    s5="use arrow keys to move attractor.";
    s6="use '+' and '-' to zoom.";
    s7="press 'c' to put selected center at mouse position.";
    break;
  case AttractorDisplayArray.FULLSCREENCOLOR:   
    s1="color preview.";
    s2="'2' : go back to active view";
    s3="'3' : go to attractor controls.";
    s4="'5' : go to stealth mode(a lot faster).";
    s6="Click save to save image to browser.";
    s7="This may take some time!";
    break;
  case AttractorDisplayArray.FULLSCREENSTEALTH:
    s1="stealth mode.";
    s9="updates: "+((attractorDisplayArray.active)?attractorDisplayArray.activeDisplay.NOfUpdates:0);
    s2="'2' : go to active view.";
    s3="'3' : go to attractor controls.";
    s4="'4' : go to color controls.";
    s6="Click display to update render. ";

    break;
  case AttractorDisplayArray.SAVING:
    s1="saving image";
    break;
  }
  ((Textlabel)controlP5.getController("nfo1")).setValue(s1);
  ((Textlabel)controlP5.getController("nfo2")).setValue(s2);
  ((Textlabel)controlP5.getController("nfo3")).setValue(s3);
  ((Textlabel)controlP5.getController("nfo4")).setValue(s4);
  ((Textlabel)controlP5.getController("nfo5")).setValue(s5);
  ((Textlabel)controlP5.getController("nfo6")).setValue(s6);
  ((Textlabel)controlP5.getController("nfo7")).setValue(s7);
  ((Textlabel)controlP5.getController("nfo8")).setValue(s8);
  ((Textlabel)controlP5.getController("nfo9")).setValue(s9);
  controlP5.getGroup("selection").setVisible(false);
  controlP5.getGroup("general").setVisible(false);
  controlP5.getGroup("render").setVisible(false);
  controlP5.getGroup("particles").setVisible(false);
  controlP5.getGroup("transforms").setVisible(false);
  controlP5.getGroup("centers").setVisible(false);
  controlP5.getGroup("channel").setVisible(false);
  controlP5.getGroup("controls").setVisible(false);
  controlP5.getGroup("options").setVisible(false);
  controlP5.getGroup("colorBars").setVisible(false);
  fill(0,0,0.2f);
  rect(width-controlWidth+10,height-50,275,40);
  controlP5.getController("save").setVisible(false);
  controlP5.getController("lblSave").setVisible(false);
  switch(attractorDisplayArray.mode){
  case AttractorDisplayArray.INIT:
    controlP5.getGroup("selection").setVisible(true); 
    controlP5.getGroup("attractorType").setValue(attractorDisplayArray.defaultASP.type);
    break;
  case AttractorDisplayArray.WAITING:
    controlP5.getGroup("selection").setVisible(true); 
    controlP5.getGroup("attractorType").setValue(attractorDisplayArray.defaultASP.type);
    break;
  case AttractorDisplayArray.FULLSCREENACTIVE:
    controlP5.getGroup("general").setVisible(true);
    controlP5.getController("save").setVisible(true);
    controlP5.getController("lblSave").setVisible(true);    
    break;
  case AttractorDisplayArray.FULLSCREENMODIFY:
    controlP5.getGroup("render").setVisible(true);
    controlP5.getGroup("particles").setVisible(true);
    controlP5.getGroup("transforms").setVisible(true);
    controlP5.getGroup("centers").setVisible(true);
    controlP5.getGroup("quality").setValue(attractorDisplayArray.activeDisplay.parameters.quality);
    controlP5.getGroup("sourceType").setValue(attractorDisplayArray.activeDisplay.attractorSystem.parameters.sourceType);
    controlP5.getGroup("mirror").setValue(attractorDisplayArray.activeDisplay.attractorSystem.parameters.mirror);
    controlP5.getController("symmetry").setValue(attractorDisplayArray.activeDisplay.attractorSystem.parameters.symmetry);
    controlP5.getController("rotation").setValue(attractorDisplayArray.activeDisplay.attractorSystem.parameters.rotation*360f/TWO_PI);
    controlP5.getController("mirrorRotation").setValue(attractorDisplayArray.activeDisplay.attractorSystem.parameters.mirrorRotation*360f/TWO_PI);
    controlP5.getController("range").setValue(attractorDisplayArray.activeDisplay.attractorSystem.parameters.maxX);
    controlP5.getController("numberOfParticles").setValue(attractorDisplayArray.activeDisplay.attractorSystem.parameters.numParticles);
    controlP5.getController("particleLife").setValue(attractorDisplayArray.activeDisplay.attractorSystem.parameters.particleLife);
    controlP5.getController("cutoff").setValue(min(attractorDisplayArray.activeDisplay.attractorSystem.parameters.particleLife-1,attractorDisplayArray.activeDisplay.parameters.cutoff));
    controlP5.getGroup("centerMode").setValue(attractorDisplayArray.activeDisplay.parameters.centerMode);
    
    break;
  case AttractorDisplayArray.FULLSCREENCOLOR:
    genericFunction gf;
    switch((int)controlP5.getGroup("colorChannel").getValue()){
    case 0:
     gf=attractorDisplayArray.activeDisplay.parameters.hueFunction;
      break;
    case 1:
     gf=attractorDisplayArray.activeDisplay.parameters.satFunction;
      break;
    case 2:
       gf=attractorDisplayArray.activeDisplay.parameters.briFunction;
      break;
      
      default:
      gf=attractorDisplayArray.activeDisplay.parameters.briFunction;
      break;
    }
    controlP5.getController("bias").setValue(gf.bias);
    controlP5.getController("gain").setValue(gf.gain);
    controlP5.getController("multiplier").setValue(gf.multiplier);
     controlP5.getController("offset").setValue(gf.offset);
    controlP5.getController("min").setValue(gf.lowerValue);
    controlP5.getController("max").setValue(gf.upperValue);
    controlP5.getController("multiplier").setValue(gf.multiplier);
    controlP5.getController("invert").setValue(gf.invert?1f:0f);
    controlP5.getController("repeat").setValue(gf.repeat?1f:0f);
    controlP5.getController("pingpong").setValue(gf.pingPong?1f:0f);
    controlP5.getController("symmetric").setValue(gf.symmetric?1f:0f);
    controlP5.getController("save").setVisible(true);    
    controlP5.getController("lblSave").setVisible(true);
    controlP5.getGroup("channel").setVisible(true);
    controlP5.getGroup("controls").setVisible(true);
    controlP5.getGroup("options").setVisible(true);
    controlP5.getGroup("colorBars").setVisible(true);
    briBar.cf=attractorDisplayArray.activeDisplay.parameters.briFunction;
    briBar.draw();
    hueBar.cf=attractorDisplayArray.activeDisplay.parameters.hueFunction;
    hueBar.draw();
    satBar.cf=attractorDisplayArray.activeDisplay.parameters.satFunction;
    satBar.draw();
    break;
  }
}

void mirror(int ID){
  if(attractorDisplayArray.responsiveToAttractorChange){    
    attractorDisplayArray.activeDisplay.setMirror(ID);      
  }  
}

void symmetry(int s){
  if(attractorDisplayArray.responsiveToAttractorChange){    
    attractorDisplayArray.activeDisplay.setSymmetry(s);      
  } 
}

void rotation(float r){
  if(attractorDisplayArray.responsiveToAttractorChange){    
    attractorDisplayArray.activeDisplay.setRotation(r/360f*TWO_PI);      
  } 
}

void mirrorRotation(float r){
  if(attractorDisplayArray.responsiveToAttractorChange){    
    attractorDisplayArray.activeDisplay.setMirrorRotation(r/360f*TWO_PI);      
  } 
}

void controlEvent(ControlEvent theEvent) {

  switch(theEvent.getId()) {  
  case 1:
    if(attractorDisplayArray.mode==AttractorDisplayArray.WAITING) attractorDisplayArray.setType((int)theEvent.getValue()); 
    break;
  case 3:
    attractorDisplayArray.processMutate();
    break;
  case 205:
    attractorDisplayArray.switchMode(AttractorDisplayArray.SAVING);
    break;
  }
  if(attractorDisplayArray.active){  
    AttractorDisplay attractorDisplay = attractorDisplayArray.activeDisplay;
    if(attractorDisplayArray.responsiveToGridChange){
      switch(theEvent.getId()) {      
        case(11):
        attractorDisplay.setQuality((int)theEvent.getValue()); 
        break;
        case(12):
        attractorDisplay.setSourceType((int)theEvent.getValue());  
        break;
        case(35):
        attractorDisplay.setCenterMode((int)theEvent.getValue()); 
        break;
      }
    }
    if(attractorDisplayArray.responsiveToAttractorChange){
      switch(theEvent.getId()) {      
        case(20):
        attractorDisplay.setRange(theEvent.getValue()); 
        break;
        case(21):
        attractorDisplay.setNumParticles((int)theEvent.getValue());   
        break;
        case(23):
        attractorDisplay.setParticleLife((int)theEvent.getValue()); 
        break;
        case(24):
        attractorDisplay.setCutoff((int)theEvent.getValue()); 
        break;
      }
    }
    if(attractorDisplayArray.responsiveToColorChange){
      genericFunction gf;
      switch((int)controlP5.getGroup("colorChannel").getValue()){
       case 0:
        gf=attractorDisplay.parameters.hueFunction;
        break;
       case 1:
        gf=attractorDisplay.parameters.satFunction;
        break;
       case 2:
         gf=attractorDisplay.parameters.briFunction;
        break;
        
        default:
        gf=attractorDisplay.parameters.briFunction;
        break;
      }
      switch(theEvent.getId()) {
      case 40:
        gf.setBias(theEvent.getValue()); 
        break;
      case 41:
        gf.setBias(gf.bias-0.1f); 
        break;
      case 42:
        gf.setBias(gf.bias-0.01f); 
        break;
      case 43:
        gf.setBias(gf.defBias); 
        break;
      case 44:
        gf.setBias(gf.bias+0.01f); 
        break;
      case 45:
        gf.setBias(gf.bias+0.1f); 
        break;
      case 50:
        gf.setGain(theEvent.getValue()); 
        break;
      case 51:
        gf.setGain(gf.gain-0.1f); 
        break;
      case 52:
        gf.setGain(gf.gain-0.01f); 
        break;
      case 53:
        gf.setGain(gf.defGain); 
        break;
      case 54:
        gf.setGain(gf.gain+0.01f); 
        break;
      case 55:
        gf.setGain(gf.gain+0.1f); 
        break;
      case 60:
        gf.setMultiplier(theEvent.getValue()); 
        break;
      case 61:
        gf.setMultiplier(gf.multiplier-0.1f); 
        break;
      case 62:
        gf.setMultiplier(gf.multiplier-0.01f); 
        break;
      case 63:
        gf.setMultiplier(gf.defMultiplier); 
        break;
      case 64:
        gf.setMultiplier(gf.multiplier+0.01f); 
        break;
      case 65:
        gf.setMultiplier(gf.multiplier+0.1f); 
        break;
        case 70:
        gf.setOffset(theEvent.getValue()); 
        break;
        case 71:
        gf.setOffset(gf.offset-0.1f); 
        break;
      case 72:
        gf.setOffset(gf.offset-0.01f); 
        break;
      case 73:
        gf.setOffset(gf.defOffset); 
        break;
      case 74:
        gf.setOffset(gf.offset+0.01f); 
        break;
      case 75:
        gf.setOffset(gf.offset+0.1f); 
        break;
           case 80:
        gf.setLowerValue(theEvent.getValue()); 
        break;
        case 81:
        gf.setLowerValue(gf.lowerValue-0.1f); 
        break;
      case 82:
        gf.setLowerValue(gf.lowerValue-0.01f); 
        break;
      case 83:
        gf.setLowerValue(gf.defLowerValue); 
        break;
      case 84:
        gf.setLowerValue(gf.lowerValue+0.01f); 
        break;
      case 85:
        gf.setLowerValue(gf.lowerValue+0.1f); 
        break;
           case 90:
        gf.setUpperValue(theEvent.getValue()); 
        break;
        case 91:
        gf.setUpperValue(gf.upperValue-0.1f); 
        break;
      case 92:
        gf.setUpperValue(gf.upperValue-0.01f); 
        break;
      case 93:
        gf.setUpperValue(gf.defUpperValue); 
        break;
      case 964:
        gf.setUpperValue(gf.upperValue+0.01f); 
        break;
      case 95:
        gf.setUpperValue(gf.upperValue+0.1f); 
        break;
      case 105:
        gf.invert=(theEvent.getValue()==1.0f);
        break; 
      case 102:
        gf.symmetric=(theEvent.getValue()==1.0f);
        break;
      case 103:
        gf.repeat=(theEvent.getValue()==1.0f);
        break;
      case 104:
        gf.pingPong=(theEvent.getValue()==1.0f);
        break;
      }
    }
  }
}
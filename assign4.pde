PImage bg1,bg2,start1,start2,end1,end2,enemy,fighter,hp,treasure,shoot;
//-----------------------------------------------
boolean upPressed=false,downPressed=false,leftPressed=false,rightPressed=false;  //key movement
boolean shooting=false;
//-----------------------------------------
int health,bgX,bgY,fighterX,fighterY,treasureX,treasureY;
int GAMEMODE=1,ENEMYTEAM=0,shootcount=0;
final int title=1,playing=2,gameover=3;
final int straight=1,slanted=2,diamond=3;

//------------------------------------straight startup

int[] teamStraight=new int[5];        //saving x value
int teamStrY=floor(random(0,419));    //saving y value
int straightTrack;                    //tracking x value(if the leader is destroyed)
//-------------------------------------slanted startup
int[] teamSlanted=new int[5];  
float teamSlaY=floor(random(0,419));
float teamSlaAngle=0;
int slantedTrack;
//-------------------------------------diamond startup
int[] teamDiamond=new int[8];
float teamDiaY=floor(random(0,419));
float teamDiaAngle;
int diamondTrack;
//---------------------------------------------------
int upDetect,downDetect,leftDetect,rightDetect;    //detect touch





void setup () {
	size(640, 480) ;
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png"); 
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png");
  shoot=loadImage("img/shoot.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  
  treasureX=floor(random(30,610));
  treasureY=floor(random(30,450));
  bgX=0;
  bgY=-640;
  fighterX=540;                       
  fighterY=240;
  health=450;
  treasureX=floor(random(30,610));
  treasureY=floor(random(30,450));
  //-------------------------------------------------straight startup
  for(int count1=0;count1<5;count1++){                       
            teamStraight[count1]=-61-61*count1*13/10;         
          }
          teamStrY=floor(random(0,419));
  straightTrack=teamStraight[0];
    //------------------------------------------------slanted startup
  for(int count2=0;count2<5;count2++){                       
            teamSlanted[count2]=-61-61*count2*13/10;         
          }
          teamSlaY=floor(random(0,419));
          teamSlaAngle=random(teamSlaY/(-5),(480-teamSlaY-61)/5);
  slantedTrack=teamSlanted[0];
//-----------------------------------------------------diamond startup
  if(teamDiaY<=209.5){                               //area detection
    teamDiaAngle=random(teamDiaY/3,0);  
    }else{
    teamDiaAngle=random((419-teamDiaY)/3,0);
    }
    
  for(int count3=0;count3<5;count3++){                       
            teamDiamond[count3]=-61-61*count3*13/10;         
          } 
  for(int count4=5;count4<8;count4++){
            teamDiamond[count4]=-61-61*(8-count4)*13/10;
    
          }
  diamondTrack=teamDiamond[0];



}

//---------------------------------------------------------------------





void draw()
{
   
   switch(GAMEMODE){
     case title:
         image(start2,0,0);
    if ((mouseX<444 && mouseX>202)&&(mouseY<422 && mouseY>380)){    //detecting mouse area
        image(start1,0,0);
    if(mousePressed){
        ENEMYTEAM=straight;
        GAMEMODE=playing;
     } 
    }
 break;
     
//-----------------------------------------------------------------    
//-----------------------------------------------------------------
//-----------------------------------------------------------------   
     case playing:
     
//----------------------------------------------------------------------     
       image(bg2,bgY,0);                    //background scrolling
       image(bg1,bgX,0);           
          bgX+=4;
          bgY+=4;
         if(bgX==640){                        //bg1 reset
              bgX=-640;
               }
         if(bgY==640){                        //bg2 reset
              bgY=-640;
               }
   //------------------------------------------------------------------------        
      image(fighter,fighterX,fighterY);     //fighter moving
        if(upPressed && fighterY>0){
          fighterY-=4;
        }
        if(downPressed && fighterY<429){
          fighterY+=4;
        }
        if(leftPressed && fighterX>0 ){
          fighterX-=4;
        }
        if(rightPressed && fighterX<589){
          fighterX+=4;
        }     
//----------------------------------------------------------------------------
      rectMode(CORNERS);                    //hp gauge 410-610
      fill(255,0,0);
      rect(410,50,health,30);               
      noStroke();
      image(hp,405,28);  

      image(treasure,treasureX,treasureY);  //treasure  

      
//-------------------------------------------------------touching detect
       upDetect=floor(random(fighterX,fighterX+51));
       downDetect=floor(random(fighterX,fighterX+51));
       leftDetect=floor(random(fighterY,fighterY+51));
       rightDetect=floor(random(fighterY,fighterY+51));
//------------------------------------------------------healing detect 
       if(upDetect>=treasureX && upDetect<=treasureX+41 && fighterY>=treasureY && fighterY<=treasureY+41 || downDetect>=treasureX && downDetect<=treasureX+41 && fighterY+51>=treasureY && fighterY+51<=treasureY+41
          || leftDetect>=treasureY && leftDetect<=treasureY+41 && fighterX>=treasureX && fighterX<=treasureX+41 || rightDetect>=treasureY && rightDetect<=treasureY+41 && fighterX+51>=treasureX && fighterX+51<=treasureX+41){
          treasureX=floor(random(0,589));
          treasureY=floor(random(0,429));      
          if(health<=590){
          health+=20;
            }
         }      
//------------------------------------------------------------------          
//------------------------------------------------------------------  
      switch(ENEMYTEAM){
        case straight:
        
        image(enemy,teamStraight[0],teamStrY);
        image(enemy,teamStraight[1],teamStrY);
        image(enemy,teamStraight[2],teamStrY);
        image(enemy,teamStraight[3],teamStrY);
        image(enemy,teamStraight[4],teamStrY);
                
        teamStraight[0]+=4;
        teamStraight[1]+=4;
        teamStraight[2]+=4;
        teamStraight[3]+=4;
        teamStraight[4]+=4;
        straightTrack+=4;
//---------------------------------------------------------fighter crash detect        
        if(upDetect>=teamStraight[0] && upDetect<=teamStraight[0]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[0] && downDetect<=teamStraight[0]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[0] && fighterX<=teamStraight[0]+61 || rightDetect>=teamStrY && rightDetect<=teamStrY+61 && fighterX+51>=teamStraight[0] && fighterX+51<=teamStraight[0]+61){
        teamStraight[0]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamStraight[1] && upDetect<=teamStraight[1]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[1] && downDetect<=teamStraight[1]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[1] && fighterX<=teamStraight[1]+61 || rightDetect>=teamStrY && rightDetect<=teamStrY+61 && fighterX+51>=teamStraight[1] && fighterX+51<=teamStraight[1]+61){
        teamStraight[1]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
        }
        
        if(upDetect>=teamStraight[2] && upDetect<=teamStraight[2]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[2] && downDetect<=teamStraight[2]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[2] && fighterX<=teamStraight[2]+61 || rightDetect>=teamStrY && rightDetect<=teamStrY+61 && fighterX+51>=teamStraight[2] && fighterX+51<=teamStraight[2]+61){
        teamStraight[2]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
        }
        
        if(upDetect>=teamStraight[3] && upDetect<=teamStraight[3]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[3] && downDetect<=teamStraight[3]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[3] && fighterX<=teamStraight[3]+61 || rightDetect>=teamStrY && rightDetect<=teamStrY+61 && fighterX+51>=teamStraight[3] && fighterX+51<=teamStraight[3]+61){
        teamStraight[3]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
        }
        
        if(upDetect>=teamStraight[4] && upDetect<=teamStraight[4]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[4] && downDetect<=teamStraight[4]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[4] && fighterX<=teamStraight[4]+61 || rightDetect>=teamStrY && rightDetect<=teamStrY+61 && fighterX+51>=teamStraight[4] && fighterX+51<=teamStraight[4]+61){
        teamStraight[4]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
        }










   
        if(straightTrack>=1000){
          for(int count1=0;count1<5;count1++){                       //team straight reset
          teamStraight[count1]=-61-61*count1*13/10;         
        }
        teamStrY=floor(random(0,419));
        straightTrack=teamStraight[0];
        ENEMYTEAM=slanted;
          
        }
        break;
//-------------------------------------------------------------------------------------
        case slanted:
        
        image(enemy,teamSlanted[0],teamSlaY);
        image(enemy,teamSlanted[1],teamSlaY+teamSlaAngle);
        image(enemy,teamSlanted[2],teamSlaY+teamSlaAngle*2);
        image(enemy,teamSlanted[3],teamSlaY+teamSlaAngle*3);
        image(enemy,teamSlanted[4],teamSlaY+teamSlaAngle*4);
        
        teamSlanted[0]+=4;
        teamSlanted[1]+=4;
        teamSlanted[2]+=4;
        teamSlanted[3]+=4;
        teamSlanted[4]+=4;
        slantedTrack+=4;
        
        
        
          if(upDetect>=teamSlanted[0] && upDetect<=teamSlanted[0]+61 && fighterY>=teamSlaY && fighterY<=teamSlaY+61 || downDetect>=teamSlanted[0] && downDetect<=teamSlanted[0]+61 && fighterY+51>=teamSlaY && fighterY+51<=teamSlaY+61
      || leftDetect>=teamSlaY && leftDetect<=teamSlaY+61 && fighterX>=teamSlanted[0] && fighterX<=teamSlanted[0]+61 || rightDetect>=teamSlaY && rightDetect<=teamSlaY+61 && fighterX+51>=teamSlanted[0] && fighterX+51<=teamSlanted[0]+61){
        teamSlanted[0]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamSlanted[1] && upDetect<=teamSlanted[1]+61 && fighterY>=teamSlaY+teamSlaAngle && fighterY<=teamSlaY+teamSlaAngle+61 || downDetect>=teamSlanted[1] && downDetect<=teamSlanted[1]+61 && fighterY+51>=teamSlaY+teamSlaAngle && fighterY+51<=teamSlaY+teamSlaAngle+61
      || leftDetect>=teamSlaY+teamSlaAngle && leftDetect<=teamSlaY+teamSlaAngle+61 && fighterX>=teamSlanted[1] && fighterX<=teamSlanted[0]+61 || rightDetect>=teamSlaY+teamSlaAngle && rightDetect<=teamSlaY+teamSlaAngle+61 && fighterX+51>=teamSlanted[1] && fighterX+51<=teamSlanted[1]+61){
        teamSlanted[1]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamSlanted[2] && upDetect<=teamSlanted[2]+61 && fighterY>=teamSlaY+teamSlaAngle*2 && fighterY<=teamSlaY+teamSlaAngle*2+61 || downDetect>=teamSlanted[2] && downDetect<=teamSlanted[2]+61 && fighterY+51>=teamSlaY+teamSlaAngle*2 && fighterY+51<=teamSlaY+teamSlaAngle*2+61
      || leftDetect>=teamSlaY+teamSlaAngle*2 && leftDetect<=teamSlaY+teamSlaAngle*2+61 && fighterX>=teamSlanted[2] && fighterX<=teamSlanted[2]+61 || rightDetect>=teamSlaY+teamSlaAngle*2 && rightDetect<=teamSlaY+teamSlaAngle*2+61 && fighterX+51>=teamSlanted[2] && fighterX+51<=teamSlanted[2]+61){
        teamSlanted[2]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamSlanted[3] && upDetect<=teamSlanted[3]+61 && fighterY>=teamSlaY && fighterY<=teamSlaY+61 || downDetect>=teamSlanted[3] && downDetect<=teamSlanted[3]+61 && fighterY+51>=teamSlaY+teamSlaAngle*3 && fighterY+51<=teamSlaY+teamSlaAngle*3+61
      || leftDetect>=teamSlaY+teamSlaAngle*3 && leftDetect<=teamSlaY+teamSlaAngle*3+61 && fighterX>=teamSlanted[3] && fighterX<=teamSlanted[3]+61 || rightDetect>=teamSlaY+teamSlaAngle*3 && rightDetect<=teamSlaY+teamSlaAngle*3+61 && fighterX+51>=teamSlanted[3] && fighterX+51<=teamSlanted[3]+61){
        teamSlanted[3]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamSlanted[4] && upDetect<=teamSlanted[4]+61 && fighterY>=teamSlaY+teamSlaAngle*4 && fighterY<=teamSlaY+teamSlaAngle*4+61 || downDetect>=teamSlanted[4] && downDetect<=teamSlanted[4]+61 && fighterY+51>=teamSlaY+teamSlaAngle*4 && fighterY+51<=teamSlaY+teamSlaAngle*4+61
      || leftDetect>=teamSlaY+teamSlaAngle*4 && leftDetect<=teamSlaY+teamSlaAngle*4+61 && fighterX>=teamSlanted[4] && fighterX<=teamSlanted[4]+61 || rightDetect>=teamSlaY+teamSlaAngle*4 && rightDetect<=teamSlaY+teamSlaAngle*4+61 && fighterX+51>=teamSlanted[4] && fighterX+51<=teamSlanted[4]+61){
        teamSlanted[4]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
       
      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        if(slantedTrack>=1000){
          for(int count2=0;count2<5;count2++){                       //team slanted reset
          teamSlanted[count2]=-61-61*count2*13/10;         
        }
        teamSlaY=floor(random(0,419));
        teamSlaAngle=random(teamSlaY/(-5),(480-teamSlaY-61)/5);
        slantedTrack=teamSlanted[0];
        ENEMYTEAM=diamond;
        }
        break;
//-----------------------------------------------------------------------------------        
        case diamond:
        
        image(enemy,teamDiamond[0],teamDiaY);
        image(enemy,teamDiamond[1],teamDiaY+teamDiaAngle);
        image(enemy,teamDiamond[2],teamDiaY+teamDiaAngle*2);
        image(enemy,teamDiamond[3],teamDiaY+teamDiaAngle);
        image(enemy,teamDiamond[4],teamDiaY);
        image(enemy,teamDiamond[5],teamDiaY-teamDiaAngle);
        image(enemy,teamDiamond[6],teamDiaY-teamDiaAngle*2);
        image(enemy,teamDiamond[7],teamDiaY-teamDiaAngle);
        
        teamDiamond[0]+=4;
        teamDiamond[1]+=4;
        teamDiamond[2]+=4;
        teamDiamond[3]+=4;
        teamDiamond[4]+=4;
        teamDiamond[5]+=4;
        teamDiamond[6]+=4;
        teamDiamond[7]+=4;
        diamondTrack+=4;
        
        
        if(upDetect>=teamDiamond[0] && upDetect<=teamDiamond[0]+61 && fighterY>=teamDiaY && fighterY<=teamDiaY+61 || downDetect>=teamDiamond[0] && downDetect<=teamDiamond[0]+61 && fighterY+51>=teamDiaY && fighterY+51<=teamDiaY+61
      || leftDetect>=teamDiaY && leftDetect<=teamDiaY+61 && fighterX>=teamStraight[0] && fighterX<=teamStraight[0]+61 || rightDetect>=teamDiaY && rightDetect<=teamDiaY+61 && fighterX+51>=teamDiamond[0] && fighterX+51<=teamDiamond[0]+61){        
        teamDiamond[0]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamDiamond[1] && upDetect<=teamDiamond[1]+61 && fighterY>=teamDiaY+teamDiaAngle && fighterY<=teamDiaY+teamDiaAngle+61 || downDetect>=teamDiamond[1] && downDetect<=teamDiamond[1]+61 && fighterY+51>=teamDiaY+teamDiaAngle && fighterY+51<=teamDiaY+teamDiaAngle+61
      || leftDetect>=teamDiaY+teamDiaAngle && leftDetect<=teamDiaY+teamDiaAngle+61 && fighterX>=teamDiamond[1] && fighterX<=teamDiamond[1]+61 || rightDetect>=teamDiaY+teamDiaAngle && rightDetect<=teamDiaY+teamDiaAngle+61 && fighterX+51>=teamDiamond[1] && fighterX+51<=teamDiamond[1]+61){
        teamDiamond[1]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamDiamond[2] && upDetect<=teamDiamond[2]+61 && fighterY>=teamDiaY+teamDiaAngle*2 && fighterY<=teamDiaY+teamDiaAngle*2+61 || downDetect>=teamDiamond[2] && downDetect<=teamDiamond[2]+61 && fighterY+51>=teamDiaY+teamDiaAngle*2 && fighterY+51<=teamDiaY+teamDiaAngle*2+61
      || leftDetect>=teamDiaY+teamDiaAngle*2 && leftDetect<=teamDiaY+teamDiaAngle*2+61 && fighterX>=teamDiamond[2] && fighterX<=teamDiamond[2]+61 || rightDetect>=teamDiaY+teamDiaAngle*2 && rightDetect<=teamDiaY+teamDiaAngle*2+61 && fighterX+51>=teamDiamond[2] && fighterX+51<=teamDiamond[2]+61){
        teamDiamond[2]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamDiamond[3] && upDetect<=teamDiamond[3]+61 && fighterY>=teamDiaY+teamDiaAngle && fighterY<=teamDiaY+teamDiaAngle+61 || downDetect>=teamDiamond[3] && downDetect<=teamDiamond[3]+61 && fighterY+51>=teamDiaY+teamDiaAngle && fighterY+51<=teamDiaY+teamDiaAngle+61
      || leftDetect>=teamDiaY+teamDiaAngle && leftDetect<=teamDiaY+teamDiaAngle+61 && fighterX>=teamDiamond[3] && fighterX<=teamDiamond[3]+61 || rightDetect>=teamDiaY+teamDiaAngle && rightDetect<=teamDiaY+teamDiaAngle+61 && fighterX+51>=teamDiamond[3] && fighterX+51<=teamDiamond[3]+61){
        teamDiamond[3]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamDiamond[4] && upDetect<=teamDiamond[4]+61 && fighterY>=teamDiaY && fighterY<=teamDiaY+61 || downDetect>=teamDiamond[4] && downDetect<=teamDiamond[4]+61 && fighterY+51>=teamDiaY && fighterY+51<=teamDiaY+61
      || leftDetect>=teamDiaY && leftDetect<=teamDiaY+61 && fighterX>=teamDiamond[4] && fighterX<=teamDiamond[4]+61 || rightDetect>=teamDiaY && rightDetect<=teamDiaY+61 && fighterX+51>=teamDiamond[4] && fighterX+51<=teamDiamond[4]+61){
        teamDiamond[4]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamDiamond[5] && upDetect<=teamDiamond[5]+61 && fighterY>=teamDiaY-teamDiaAngle && fighterY<=teamDiaY-teamDiaAngle+61 || downDetect>=teamDiamond[5] && downDetect<=teamDiamond[5]+61 && fighterY+51>=teamDiaY-teamDiaAngle && fighterY+51<=teamDiaY-teamDiaAngle+61
      || leftDetect>=teamDiaY-teamDiaAngle && leftDetect<=teamDiaY-teamDiaAngle+61 && fighterX>=teamDiamond[5] && fighterX<=teamDiamond[5]+61 || rightDetect>=teamDiaY-teamDiaAngle && rightDetect<=teamDiaY-teamDiaAngle+61 && fighterX+51>=teamDiamond[5] && fighterX+51<=teamDiamond[5]+61){
        teamDiamond[5]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamDiamond[6] && upDetect<=teamDiamond[6]+61 && fighterY>=teamDiaY-teamDiaAngle*2 && fighterY<=teamDiaY-teamDiaAngle*2+61 || downDetect>=teamDiamond[6] && downDetect<=teamDiamond[6]+61 && fighterY+51>=teamDiaY-teamDiaAngle*2 && fighterY+51<=teamDiaY-teamDiaAngle*2+61
      || leftDetect>=teamDiaY-teamDiaAngle*2 && leftDetect<=teamDiaY-teamDiaAngle*2+61 && fighterX>=teamDiamond[6] && fighterX<=teamDiamond[6]+61 || rightDetect>=teamDiaY-teamDiaAngle*2 && rightDetect<=teamDiaY-teamDiaAngle*2+61 && fighterX+51>=teamDiamond[6] && fighterX+51<=teamDiamond[6]+61){
        teamDiamond[6]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        if(upDetect>=teamDiamond[7] && upDetect<=teamDiamond[7]+61 && fighterY>=teamDiaY-teamDiaAngle && fighterY<=teamDiaY-teamDiaAngle+61 || downDetect>=teamDiamond[7] && downDetect<=teamDiamond[7]+61 && fighterY+51>=teamDiaY-teamDiaAngle && fighterY+51<=teamDiaY-teamDiaAngle+61
      || leftDetect>=teamDiaY-teamDiaAngle && leftDetect<=teamDiaY-teamDiaAngle+61 && fighterX>=teamDiamond[7] && fighterX<=teamDiamond[7]+61 || rightDetect>=teamDiaY-teamDiaAngle && rightDetect<=teamDiaY-teamDiaAngle+61 && fighterX+51>=teamDiamond[7] && fighterX+51<=teamDiamond[7]+61){
        teamDiamond[7]=5000;
        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        if(diamondTrack>=1000){                                //team diamond reset
          for(int count3=0;count3<5;count3++){                       
            teamDiamond[count3]=-61-61*count3*13/10;         
          } 
          for(int count4=5;count4<8;count4++){
            teamDiamond[count4]=-61-61*(8-count4)*13/10;
    
          }
          teamDiaY=floor(random(0,419));
          
          if(teamDiaY<=209.5){                               //area detection
            teamDiaAngle=random(teamDiaY/3,0);  
            }else{
            teamDiaAngle=random((419-teamDiaY)/3,0);
            }
        diamondTrack=teamDiamond[0];  
        ENEMYTEAM=straight;
        }
        
        
        
         
         
        
        
        
        
        
       
        break;                            //teams end
   }

          
//----------------------------------------------------------------------           
           
     break;                    //playing end

     
     
     
     
     
     
     
     
     
     
 
     
     
     
     
     

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     case gameover:
       image(end2,0,0);
  if ((mouseX<width*2/3 && mouseX>width*1/3)&&(mouseY<355 && mouseY>308)){
    image(end1,0,0);
  if(mousePressed){                            
    health=450;                         //restart
    fighterX=540;
    fighterY=240;
    
//-----------------------------------------------------------------------------------------------resetting all enemy    
    for(int count1=0;count1<5;count1++){                       //team straight reset
          teamStraight[count1]=-61-61*count1*13/10;         
        }
        teamStrY=floor(random(0,419));
        straightTrack=teamStraight[0];
    for(int count2=0;count2<5;count2++){                       //team slanted reset
          teamSlanted[count2]=-61-61*count2*13/10;         
        }
        teamSlaY=floor(random(0,419));
        teamSlaAngle=random(teamSlaY/(-5),(480-teamSlaY-61)/5);
        slantedTrack=teamSlanted[0]; 
    for(int count3=0;count3<5;count3++){                       
            teamDiamond[count3]=-61-61*count3*13/10;         
          } 
    for(int count4=5;count4<8;count4++){
            teamDiamond[count4]=-61-61*(8-count4)*13/10;
    
          }
          teamDiaY=floor(random(0,419));
          
          if(teamDiaY<=209.5){                               //area detection
            teamDiaAngle=random(teamDiaY/3,0);  
            }else{
            teamDiaAngle=random((419-teamDiaY)/3,0);
            }
        diamondTrack=teamDiamond[0];  
       
 //-----------------------------------------------------------------------------------
    ENEMYTEAM=straight;
    GAMEMODE=playing;
    
       } 
    }
  break;
   }//case gamemode end


   }                               //void draw end
  
  
//*********************************************************************************************end game 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  




void keyPressed(){                    //key detection
    if (keyPressed) {
    switch (keyCode) {
      case UP:
        upPressed=true;
      break;        
      case DOWN:
        downPressed=true;
      break;        
      case LEFT:
        leftPressed=true;
      break;
      case RIGHT:
        rightPressed=true;
      break;
      case 32:                       //space bar
        shooting=true;
    }
  }

}


void keyReleased(){
      if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed=false;
        break;
      case DOWN:
        downPressed=false;
        break;
      case LEFT:
        leftPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
      case 32:
        shooting=false;
    }
  }

}

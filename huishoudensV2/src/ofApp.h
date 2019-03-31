#pragma once

#include "ofMain.h"
#include "ofxSQLiteCpp.h"
//#include "ofxPoco.h"
//#include "ofxIO.h"

class ofApp : public ofBaseApp {
    
public:
    void setup();
    void update();
    void draw();
    
    void keyPressed(int key);
    void mouseMoved(int x, int y);
    
private:
    ofTrueTypeFont font;
    
    int yearIndex = 0;
    
    int years[9] = {1995,2000,2005,2010,2012,2013,2014,2015,2016};
    
    float lerpYear;
    float totaalLerpValue;
    float singleLerpValue;
    float multipleLerpValue;
    
    SQLite::Database* db;
};

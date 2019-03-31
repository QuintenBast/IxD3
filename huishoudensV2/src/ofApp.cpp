#include "ofApp.h"

void ofApp::setup(){
    ofSetCircleResolution(50);
    font.load("Futura.ttc", 64);
    
    try {
        
        string databasePath = ofToDataPath("Huishoudens.db", true);
        db = new SQLite::Database(databasePath);
    } catch (const std::exception& e) {
        ofLogError() << e.what() << endl;
    }
}

void ofApp::update(){
    
}

void ofApp::draw(){
    try {
        SQLite::Statement query(*db, "SELECT * FROM huishoudens WHERE jaar=?");
        
        int year = years[yearIndex];
        ofLog() << "jaar = " << year << endl;
        query.bind(1, year);
        
        while(query.executeStep()){
            
            ofSetColor(ofColor::orange);
            totaalLerpValue = ofLerp(totaalLerpValue, query.getColumn("huishoudens_totaal").getDouble(), 0.05);
            ofDrawCircle(100, 100, totaalLerpValue * 5);
//            ofDrawRectRounded(100, 100, totaalLerpValue * 5);
            
            ofSetColor(ofColor::red);
            singleLerpValue = ofLerp(singleLerpValue, query.getColumn("hh_single").getDouble(), 0.05);
            ofDrawCircle(300, 100, singleLerpValue * 5);
            
            ofSetColor(ofColor::blue);
            multipleLerpValue = ofLerp(multipleLerpValue, query.getColumn("hh_multiple").getDouble(),0.05);
            ofDrawCircle(500, 100, multipleLerpValue * 5);
            
            lerpYear = ofLerp(lerpYear, years[yearIndex], 0.01);
            ofSetColor(ofColor::black);
            font.drawString(ofToString((int)lerpYear), 200, 500);
            
        }
    } catch (const std::exception& e) {
        ofLogError() << e.what() << endl;
    }
}


void ofApp::keyPressed(int key){
    
}

void ofApp::mouseMoved(int x, int y ){
    yearIndex = ofMap(x, 0, ofGetWidth(), 0, 5);
}


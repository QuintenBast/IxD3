#include "ofApp.h"

void ofApp::setup(){

}

void ofApp::update(){

}

void ofApp::draw(){

}

void ofApp::getData() {
    string url = "http://api.openweathermap.org/data/2.5/forecast?q=Amsterdam,nl&appid=37f584c9d170b496e7abe382b2237a5a&units=metric";
    
    bool success = json.open(url); // load & parse data from the API url
    if (success) { // loading & parsing was successful?
        int elementCount = json["cnt"].asInt();
        ofLog() << json["cnt"].asInt() << " elementen gekregen" << endl;
        
        for (int i = 0; i < elementCount; i++) {
            ofLog() << "Datum van element #" << i << " : " << json["list"][i]["dt_txt"] << endl;
        }
        
    } else {
        ofLog() << "Oops. No data!" << endl;
    }
}


void ofApp::keyPressed(int key){

}

void ofApp::keyReleased(int key){

}

void ofApp::mouseMoved(int x, int y ){

}

void ofApp::mousePressed(int x, int y, int button){

}

void ofApp::mouseReleased(int x, int y, int button){

}



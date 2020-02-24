//
//  Date_NightTests.swift
//  Date-NightTests
//
//  Created by Michelle Cueva on 1/25/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import XCTest
@testable import Date_Night

class Date_NightTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
   private func getEventData() -> Data? {
            guard let pathToData = Bundle.main.path(forResource: "events", ofType: "json")
                else {
                    XCTFail("cant find data")
                    return nil
                    //fatalError("discovery.json file not found")
            }
            let url = URL(fileURLWithPath: pathToData)
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch let jsonError {
                fatalError("could not find file: \(jsonError)")
            }
        }

  
  func testEventDataLoad(){
      let data = getEventData() ?? Data()
     
      do{
          let dataLoad = try Event.getEventfulData(data: data) ?? []
          print("test406\(dataLoad)")
          XCTAssertTrue(dataLoad.count > 0, "We have \(dataLoad.count)")
          print("We have \(data.count)")
      } catch {
          XCTFail()
      }
  }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

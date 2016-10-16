//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
   /* public var amount : Int
    public var currency : String
  
  public func convert(_ to: String) -> Money {
  }
  
  public func add(_ to: Money) -> Money {
  }
  public func subtract(_ from: Money) -> Money {
  } */
    
    private var pennies: Int =  0
    public var amount : Int {
        get {
            return Int(convertOut())
        }
        set(newvalue) {
            self.pennies = newvalue * 100
        }
    }
    public var currency : String
    
    public mutating func convert(to: String) -> Money {
        if (to == "USD" || to == "GBP" || to == "EUR" || to == "CAN") {
            self.currency = to
        } else {
            print("Please enter a acceptable currency not: \(to)")
        }
        return self
    }
    
    private func convertOut() -> Double {
        if (self.currency == "GBP") {
            return Double.init((self.pennies / 2)) / 100.0
        } else if (self.currency == "EUR") {
            return (Double.init(self.pennies) * 1.5) / 100.0
        } else if (self.currency == "CAN") {
            return (Double.init(self.pennies) * 1.5) / 100.0
        } else {
            return Double.init(self.pennies / 100)
        }
    }
    
    public mutating func add(to: Money) -> Money {
        self.pennies = self.pennies + to.pennies
        return self
    }
    
    public mutating func subtract(from: Money) -> Money {
        self.pennies = self.pennies - from.pennies
        return self
    }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
  }
  
  open func raise(_ amt : Double) {
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { }
    set(value) {
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { }
    set(value) {
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  open func haveChild(_ child: Person) -> Bool {
  }
  
  open func householdIncome() -> Int {
  }
}






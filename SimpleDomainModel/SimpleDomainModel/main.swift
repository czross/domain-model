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
        self.title = title
        self.type = type
    }
  
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case let .Salary(cash):
            return cash
        case let .Hourly(cash) :
            let time = Double.init(hours)
            return Int.init(cash * time)
        }
    }
  
    open func raise(_ amt : Double) {
        switch self.type {
        case let .Salary(cash):
            let percent = amt / 100 + 1
            let currentAmt = Double.init(cash)
            self.type = JobType.Salary(Int.init(currentAmt * percent))
        default:
            break
        }
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
    get { return _job }
    set(value) {
        if (self.age >= 16) {
            self._job = value
        } else {
            print("This person is to young to have a job")
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse}
    set(value) {
        if (self.age >= 18 && (value?.age)! >= 18) {
            self._spouse = value
        } else {
            print("One of these people is to young for marriage")
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "" + self.firstName + " " + self.lastName + " is \(self.age) years old"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if (spouse1.age >= 21 || spouse2.age >= 21 && spouse1.spouse == nil && spouse2.spouse == nil) {
        let person1 = spouse1
        let person2 = spouse2
        person1.spouse = person2
        person2.spouse = person1
        self.members.append(person1)
        self.members.append(person2)
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    child.age = 0
    self.members.append(child)
    return true
  }
  
  open func householdIncome() -> Int {
    var income = 0
    for people in self.members {
        if (people.job != nil) {
            switch people.job!.type {
            case .Salary(_):
                income += (people.job?.calculateIncome(0))!
            case .Hourly(_):
                income += (people.job?.calculateIncome(2000))!
            }
        }
    }
    return income
  }
}



import Foundation

//struct ITunes: Codable {
//    let feed: Feed
//}
//
//let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json"
//
//if let url = URL(string: urlString) {
//    URLSession.shared.dataTask(with: url) {
//        data, response, error in
//        if let data {
//            let decoder = JSONDecoder()
//            decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: data)
//        }
//    }.resume()
//}

var ans = 0

for i in (0...5) {
    let tmp: Int
    tmp = i * i
    ans += tmp
}

//print(ans)

let name = "Joanna"
let hello = "my name is \(name), i am \(18 + 9) years old."

//print("a", "b")
//print("a", "b", separator: ",", terminator: "!")

print("""
      Use the let keyword when the value doesn't change.
      Use the var keyword when the value can change.
      When you define a function, you define the parameters that can be passed to it.
      When you call a function, you pass arguments for the parameters.
      """)

print("New chat message from a friend")

var discountPercentage: Int = 0
var offer: String = ""
let item = "Apple TV 4K"
discountPercentage = 20
offer = "Sale - Up to \(discountPercentage)% discount on \(item)! Hurry up!"
print(offer)

let numberOfAdults = 20
let numberOfKids = 30
let total = numberOfAdults + numberOfKids
print("The total party size is: \(total)")

let baseSalary = 5000
let bonusAmount = 1000
let totalSalary = "\(baseSalary) + \(bonusAmount)"
print("Congratulations for your bonus! You will receive a total of \(totalSalary)(additional bonus).")

//let result = 15
//let firstNumber = 10
//let secondNumber = 5
//print("\(firstNumber) + \(secondNumber) = \(result)")

let firstNumber = 10
let secondNumber = 5
let thirdNumber = 8

let result = add(firstNumber: firstNumber, secondNumber: secondNumber)
let anotherResult = add(firstNumber: firstNumber, secondNumber: thirdNumber)

func add (firstNumber: Int, secondNumber: Int) -> Int {
    return firstNumber + secondNumber
}

print("\(firstNumber) + \(secondNumber) = \(result)")
print("\(firstNumber) + \(thirdNumber) = \(anotherResult)")


let operatingSystem = "iOS"
let emailId = "peter@apple.com"

func displayAlertMessage (operatingSystem: String = "Unknown OS", emailId: String) -> String{
    return "There’s a new sign-in request on \(operatingSystem) for your Apple Account \(emailId)."
}
print(displayAlertMessage(operatingSystem: operatingSystem, emailId: emailId))

print(displayAlertMessage(emailId: emailId))

//
func pedometerStepsToCalories(numberOfSteps: Double) -> Double {
    let caloriesBurnedForEachStep = 0.04
    let totalCaloriesBurned = numberOfSteps * caloriesBurnedForEachStep
    return totalCaloriesBurned
}

let steps: Double = 4000
let caloriesBurned = pedometerStepsToCalories(numberOfSteps: steps)
print("Walking \(steps) steps burns \(caloriesBurned) calories")

func isSpendMoreTimeOfUsingCellphone (timeSpentToday: Int, timeSpentYesterday: Int) -> Bool {
    if timeSpentToday > timeSpentYesterday {
        return true
    } else {
        return false
    }
}

isSpendMoreTimeOfUsingCellphone(timeSpentToday: 300, timeSpentYesterday: 250)
isSpendMoreTimeOfUsingCellphone(timeSpentToday: 300, timeSpentYesterday: 300)
isSpendMoreTimeOfUsingCellphone(timeSpentToday: 200, timeSpentYesterday: 220)

//
func printCityWeather (city: String, lowTemperature: Int, highTemperature: Int, chanceOfRain: Int) {
    print("City: \(city)\nLow temperature: \(lowTemperature), High temperature: \(highTemperature)\nChance of rain: \(chanceOfRain)%\n")
}
printCityWeather(city: "Taipei", lowTemperature: 9, highTemperature: 11, chanceOfRain: 82)
printCityWeather(city: "Tokyo", lowTemperature: 3, highTemperature: 11, chanceOfRain: 10)
printCityWeather(city: "Kaohsiung", lowTemperature: 11, highTemperature: 18, chanceOfRain: 2)
printCityWeather(city: "London", lowTemperature: 2, highTemperature: 7, chanceOfRain: 7)


//
var number = Int()
var string = String()
var repeatString = String(repeating: "汪", count: 3)

let a = 1.2
let b = 2

let c = a + Double(b)

import Foundation
let now = Data()


import UIKit
let princessImage = UIImage(named: "princess")
let imageView = UIImageView(image: princessImage)
//let imageView = UIImageView(image: UIImage(named: "princess"))
//let icon = UIImage(systemName: "wifi")




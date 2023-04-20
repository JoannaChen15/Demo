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

//SDK
//import AVFoundation
//
//let url = URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview118/v4/69/0e/98/690e98db-440d-cb0c-2bff-91b00a05bdda/mzaf_1674062311671795807.plus.aac.p.m4a")
//let player = AVPlayer(url: url!)
//player.play()

//import AVKit
//import PlaygroundSupport
//
//let url = URL(string: "https://video-ssl.itunes.apple.com/apple-assets-us-std-000001/Video128/v4/ac/7c/62/ac7c6274-60ea-5b7c-4c99-f08d78bfe574/mzvf_484000410198456586.640x352.h264lc.U.p.m4v")
//let player = AVPlayer(url: url!)
//let controller = AVPlayerViewController()
//controller.player = player
//PlaygroundPage.current.liveView = controller
//player.play()

//import SafariServices
//import PlaygroundSupport
//
//let url = URL(string: "http://apppeterpan.strikingly.com")
//let controller = SFSafariViewController(url: url!)
//PlaygroundPage.current.liveView = controller

//import MapKit
//import PlaygroundSupport
//
//let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
//mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.08293, longitude: 121.55671), latitudinalMeters: 1000, longitudinalMeters: 1000)
//PlaygroundPage.current.liveView = mapView

//import Foundation
//
//let now = Date()
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy年MM月dd日"
//let dateString = dateFormatter.string(from: now)

//import Foundation
//
//let today = Date()
//let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: today)
//let month = dateComponents.month
//let day = dateComponents.day

//import AVFAudio

//let utterance = AVSpeechUtterance(string: "天線寶寶出來了")
//utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
//utterance.rate = 0.5
//utterance.pitchMultiplier = 1
//let synthesizer = AVSpeechSynthesizer()
//synthesizer.speak(utterance)

//let tinyVoice =  AVSpeechUtterance(string: "bello")
//tinyVoice.voice = AVSpeechSynthesisVoice(language: "zh-TW")
//tinyVoice.rate = 0.7
//tinyVoice.pitchMultiplier = 1.5
//let speaker = AVSpeechSynthesizer()
//speaker.speak(tinyVoice)

//func
func 梯形 (top: Double, bottom: Double, height: Double) -> Double {
    return (top + bottom)*height/2
}
梯形(top: 10, bottom: 20, height: 5)

//
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

import UIKit
var man = "peter"
man.count

let princessImage = UIImage(named: "princess")
let princessImageView = UIImageView(image: princessImage)
//let imageView = UIImageView(image: UIImage(named: "princess"))
//let icon = UIImage(systemName: "wifi")

//princessImageView.backgroundColor = UIColor(red: 227/255, green: 207/255, blue: 87/255, alpha: 1)
//let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//princessImageView.frame = frame
princessImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//princessImageView.backgroundColor = UIColor(red: 222/255, green: 207/255, blue: 87/255, alpha: 1)
//princessImageView.backgroundColor = .purple

let purplePinkImageView = UIImageView(image: UIImage(named: "purplePink"))
purplePinkImageView.frame = princessImageView.frame
purplePinkImageView.addSubview(princessImageView)
purplePinkImageView.layer.borderWidth = 3.5
purplePinkImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).cgColor
//purplePinkImageView.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
purplePinkImageView

var str = "hello"
str.append(" world")

let redRect = CGRect(x: 0, y: 0, width: 200, height: 200)
let redView = UIView(frame: redRect)
redView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)


let greenRect = CGRect(x: 10, y: 10, width: 100, height: 100)
let greenView = UIView(frame: greenRect)
greenView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)

let blueRect = CGRect(x: 60, y: 60, width: 100, height: 100)
let blueView = UIView(frame: blueRect)
blueView.layer.cornerRadius = 50
blueView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)

redView.addSubview(greenView)
redView.addSubview(blueView)

let label = UILabel(frame: blueRect)
print(label.frame.size.width)

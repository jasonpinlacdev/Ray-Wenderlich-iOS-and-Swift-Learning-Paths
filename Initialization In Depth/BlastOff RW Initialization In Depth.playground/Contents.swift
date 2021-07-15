import UIKit

// Using the default init {}
struct RocketConfiguration {
  let name: String = "Athena 9 Heavy"
  let numberOfFirstStageCores: Int = 3
  let numberOfSecondStageCores: Int = 1
  var numberOfStageReuseLandingLegss: Int?
}

let athena9Heavy = RocketConfiguration()


// Using the free memberwise init that only structs get
struct RocketStageConfiguration {
  let propellantMass: Double
  let liquidOxygenMass: Double
  let nominalBurnTime: Int
  
}

let stageOneConfiguration = RocketStageConfiguration(propellantMass: 119.1,
  liquidOxygenMass: 276.0, nominalBurnTime: 180)


//  use an extension to keep the free memberwise initializer and also add a custom init.
// you do this because if you add a custom init to the main definition of your class, you'll lose the free memberwise init
extension RocketStageConfiguration {
    init(propellantMass: Double, liquidOxygenMass: Double) {
      self.propellantMass = propellantMass
      self.liquidOxygenMass = liquidOxygenMass
      self.nominalBurnTime = 250
    }
}

let stageTwoConfiguration = RocketStageConfiguration(propellantMass: 120.0, liquidOxygenMass: 297.0)


// remember, initializers job is to set starting values for all stored properties that don't have a default value set
struct Weather {
  let temperatureCelsius: Double
  let windSpeedKilometersPerHour: Double
  
  init(temperatureFahrenheit: Double = 72, windSpeedMilesPerHour: Double = 5) {
    self.temperatureCelsius = (temperatureFahrenheit - 32) / 1.8
    self.windSpeedKilometersPerHour = windSpeedMilesPerHour * 1.609344
  }
}

let currentWeather = Weather(temperatureFahrenheit: 87, windSpeedMilesPerHour: 2)


// avoid initializer duplication using initializer delegation with self.init(...)

struct GuidanceSensorStatus {
  var currentZAngularVelocityRadiansPerMinute: Double
  let initialZAngularVelocityRadiansPerMinute: Double
  var needsCorrection: Bool

  init(zAngularVelocityDegreesPerMinute: Double, needsCorrection: Bool = false) {
    let radiansPerMinute = zAngularVelocityDegreesPerMinute * 0.01745329251994
    self.currentZAngularVelocityRadiansPerMinute = radiansPerMinute
    self.initialZAngularVelocityRadiansPerMinute = radiansPerMinute
    self.needsCorrection = needsCorrection
  }
  // this is the initializer that delegates
  init(zAngularVelocityDegreesPerMinute: Double, needsCorrection: Int) {
    self.init(zAngularVelocityDegreesPerMinute: zAngularVelocityDegreesPerMinute, needsCorrection: (needsCorrection > 0) )
    self.needsCorrection = true
  }
}

let guidanceStatus = GuidanceSensorStatus(zAngularVelocityDegreesPerMinute: 2.2, needsCorrection: 0)
guidanceStatus.currentZAngularVelocityRadiansPerMinute
guidanceStatus.needsCorrection


// two phase initialization
// 1st phase start of the initialization process where initialize all member variables/stored properties.
// for initializer delegation the 1st phase the the call stack all the way from initializer delegate to non-initializer delegate
// for class hiearchy the 1st phase starts from the creation of the derived object, assigning starting values to the member/stored properties, and then climbing up the parent hiearchy to repeat the process.
// 2nd phase rest of the initialization process where we can access members variables and further customization

struct CombustionChamberStatus {
  var temperatureKelvin: Double
  var pressureKiloPascals: Double

  init(temperatureKelvin: Double, pressureKiloPascals: Double) {
    print("Phase 1 init")
    self.temperatureKelvin = temperatureKelvin
    self.pressureKiloPascals = pressureKiloPascals
    print("CombustionChamberStatus fully initialized")
    print("Phase 2 init")
  }

  init(temperatureCelsius: Double, pressureAtmospheric: Double) {
    print("Phase 1 delegating init")
    let temperatureKelvin = temperatureCelsius + 273.15
    let pressureKiloPascals = pressureAtmospheric * 101.325
    self.init(temperatureKelvin: temperatureKelvin, pressureKiloPascals: pressureKiloPascals)
    print("Phase 2 delegating init")
  }
}

CombustionChamberStatus(temperatureCelsius: 32, pressureAtmospheric: 0.96)


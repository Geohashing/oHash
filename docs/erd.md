# Entity Relationship Diagram

Built with [MermaidJS](https://mermaid.js.org/)

```mermaid

classDiagram 

class HashState~EnvironmentObject~{
    selectedDate:HashDate
    displayDates:[HashDate]
    RetroHash:bool = false
    isCurrentlyGettingDJOpen:bool = false
    mapRegion:MapRegion

    getMapAnnotations()
}

class HashPoint{
    date:Date
    graticule:Graticule
    
    status()
    latitude()
    longitude()
}

class HashDate~Struct~{
    date:Date
    e-30, w-30:DateFraction

    hasOneOrMoreHashpoints()
}

class DateFraction~Struct~{
    +date:Date
    +isE-30:boolean
    dowJonesDate:DowJonesDate
    latFraction:LatitudeDelta
    longFraction:LongitudeDelta

    status()
}
HashPoint <-- DateFraction
HashDate <-- DateFraction
HashState <-- DateFraction
HashState <-- HashDate
HashState <-- HashPoint

class DowJonesDate~Class~{
    date:Date
    dowJonesStatus:DowJonesStatus
    dowJonesError:DowJonesError
    lastCheckTime:Date
    lastCheckInterval:Int
    dowJonesOpen:String

    static getDowJonesDateFor(date:Date)
}
DateFraction -- DowJonesDate

class DowJonesStatus~enum~{
    already-had-it
    too-early
    getting-it-now
    just-got-it
    couldnt-get-it
}
DowJonesDate -- DowJonesStatus

class DowJonesError~enum~{
    no-error
    timeout-error
    network-error
    unknown-error
}
DowJonesDate -- DowJonesError

class Graticule~Struct~{
    x:Int < 0 - 359 >
    y:Int < 0 - 179 >

    Longitude left()
    Longitude right()
    Latitude top()
    Latitude bottom()
    Point topLeft()
    Point bottomRight()
    bool isE-30()
}
HashPoint <-- Graticule
```

---
title: Map
---

```js
async function crash_map_with_data() {
    // Create a container div for the map
    const container = document.createElement("div");
    container.style.height = "600px";
    document.body.appendChild(container); // Append to the body

    // Initialize the map
    const map = L.map(container).setView([40.7299, -73.9923], 13);
    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution:
        "&copy; <a href=https://www.openstreetmap.org/copyright>OpenStreetMap</a> contributors",
    }).addTo(map);

    // Fetch crash data from the API
    try {
      const response = await fetch(
        "https://data.cityofnewyork.us/resource/h9gi-nx95.json?$where=number_of_cyclist_killed>=1"
      );
      const data = await response.json();

      // Add markers to the map
      data.forEach((crash) => {
        const lat = parseFloat(crash.latitude);
        const lng = parseFloat(crash.longitude);
        const killed = crash.number_of_cyclist_killed;
        const date = crash.crash_date;

        if (!isNaN(lat) && !isNaN(lng)) {
          const marker = L.circleMarker([lat, lng], {
            radius: Math.min(10, killed || 1), // Size marker based on injuries
            color: "red",
            fillOpacity: 0.5,
          }).addTo(map);
          marker.bindPopup("Cyclists Killed: ${killed}<br>Date: ${date}");
        }
      });
    } catch (error) {
      console.error("Error fetching crash data:", error);
    }

    return map;
  }

  // Call the function to render the map
  crash_map_with_data();
```

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Crash Map</title>
    <link
      rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
    />
    <style>
      body {
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
  </body>
</html>

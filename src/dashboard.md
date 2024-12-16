---
theme: dashboard
title: dashboard
toc: false
---

# Brooklyn Bicycle Crashes

```js
import {BurndownPlot} from "./components/burndownPlot.js";
```

<!-- Load and transform the data -->

```js
const crashes = FileAttachment("data/crashes.csv").csv({typed: true});
console.log(crashes);
```

<!-- A shared color scale for consistency, sorted by the number of launches -->

```js
const color = Plot.scale({
  color: {
    type: "categorical",
    domain: d3.groupSort(crashes, (D) => -D.length, (d) => d.BOROUGH),
    unknown: "var(--theme-foreground-muted)"
  }
});
```

<!-- Cards with big numbers -->

<div class="grid grid-cols-4">
  <div class="card">
    <h2>Brooklyn</h2>
    <span class="big">${crashes.filter((d) => d.BOROUGH === "BROOKLYN").length.toLocaleString("en-US")}</span>
  </div>
  <div class="card">
    <h2>Bronx</h2>
    <span class="big">${crashes.filter((d) => d.BOROUGH === "BRONX").length.toLocaleString("en-US")}</span>
  </div>
  <div class="card">
    <h2>Manhattan</h2>
     <span class="big">${crashes.filter((d) => d.BOROUGH === "MANHATTAN").length.toLocaleString("en-US")}</span>
  </div>
  <div class="card">
    <h2>Queens</h2>
     <span class="big">${crashes.filter((d) => d.BOROUGH === "QUEENS").length.toLocaleString("en-US")}</span>
  </div>
  <div class="card">
    <h2>Staten Island</h2>
     <span class="big">${crashes.filter((d) => d.BOROUGH === "STATEN ISLAND").length.toLocaleString("en-US")}</span>
  </div>
</div>

<!-- Plot of crash history -->

```js
function peopleInjured(data, {width} = {}) {
  return Plot.plot({
  title: "Crashes over the years",
  width, 
  height: 300, 
  margin: 40,
  color: { legend: false },
  marks: [
    Plot.line(crashes, {
      x: "CRASH DATE",
      y: "NUMBER OF PERSONS INJURED",
      stroke: "ZIP CODE",
      z: "ZIP CODE",
      strokeWidth: 3,
      opacity: 0.15
    }),
    Plot.dotY(crashes, { 
      x: "CRASH DATE",
      y: "NUMBER OF PERSONS INJURED",
      r: 2,
      fill: "ZIP CODE",
      tip: true
    }),
  ]
});
}
```

<div class="grid grid-cols-1">
  <div class="card">
  ${resize((width) => peopleInjured(crashes, {width}))}

  </div>
</div>

<!-- Plot of crash vehicles -->

```js
function peopleDead(data, {width}) {
  return Plot.plot({
  title: "Death",
  width, 
  height: 300, 
  margin: 40,
  color: { legend: false },
  marks: [
    Plot.line(crashes, {
      x: "CRASH DATE",
      y: "NUMBER OF PERSONS KILLED",
      stroke: "ZIP CODE",
      z: "ZIP CODE",
      strokeWidth: 3,
      opacity: 0.15
    }),
    Plot.dotY(crashes, { 
      x: "CRASH DATE",
      y: "NUMBER OF PERSONS KILLED",
      r: 2.5,
      fill: "ZIP CODE",
      tip: true
    }),
    ]
  });
}
```

<div class="grid grid-cols-1">
  <div class="card">
    ${resize((width) => peopleDead(crashes, {width}))}
  
  </div>
</div>

<!-- pedestrians deaths -->

```js
function pedsDead(data, {width} = {}) {
  return Plot.plot({
  title: "Pedaestrains Deaths",
  width, 
  height: 300, 
  margin: 40,
  color: { legend: false },
  marks: [
    Plot.line(crashes, {
      x: "CRASH DATE",
      y: "NUMBER OF PEDESTRIANS KILLED",
      stroke: "ZIP CODE",
      z: "ZIP CODE",
      strokeWidth: 3,
      opacity: 0.15
    }),
    Plot.dotY(crashes, { 
      x: "CRASH DATE",
      y: "NUMBER OF PEDESTRIANS KILLED",
      r: 2,
      fill: "ZIP CODE",
      tip: true
    }),
  ]
});
}
```

<div class="grid grid-cols-1">
  <div class="card">
  ${resize((width) => pedsDead(crashes, {width}))}

  </div>
</div>

<div class="grid">
  <div class="card">
    <h2>BURN DOWN PLOT TEST</h2>
    ${BurndownPlot(crashes.filter((d) => !d.BOROUGH), {x, color: {legend: true, label: "borough"}})}

  </div>
</div>

Data: NYPD

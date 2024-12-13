---
title: Meow
header: |
  <div class="banner">
    <a target="_blank" href="https://github.com/uwdata/mosaic-framework-example/blob/main/docs/nyc-taxi-rides.md?plain=1"><span>View source ↗</span></a>
  </div>
sql:
  crashes: data/crashes.parquet
---

# MEOWWWWW!!!!


```js
const $filter = vg.Selection.crossfilter();

const defaultAttributes = [
  vg.width(335),
  vg.height(550),
  vg.margin(0),
  vg.xAxis(null),
  vg.yAxis(null),
  vg.xDomain([975000, 1005000]),
  vg.yDomain([190000, 240000]),
  vg.colorScale("symlog")
];
```

```js
vg.hconcat(
  vg.plot(
    vg.raster(
      vg.from("crashes", { filterBy: $filter }),
    //   { x: "px", y: "py", imageRendering: "pixelated" }
    ),
    vg.intervalXY({ as: $filter }),
    vg.text(
      [{label: "Crashes"}],
      {
        dx: 10,
        dy: 10,
        text: "label",
        fill: "black",
        fontSize: "1.2em",
        frameAnchor: "top-left"
      }
    ),
    ...defaultAttributes,
    vg.colorScheme("turbo")
  ),
  vg.hspace(10),
  vg.plot(
    vg.raster(
      vg.from("crashes", { filterBy: $filter }),
      { x: "dx", y: "dy", imageRendering: "pixelated" }
    ),
    vg.intervalXY({ as: $filter }),
    vg.text(
      [{label: "Taxi Dropoffs"}],
      {
        dx: 10,
        dy: 10,
        text: "label",
        fill: "black",
        fontSize: "1.2em",
        frameAnchor: "top-left"
      }
    ),
    ...defaultAttributes,
    vg.colorScheme("turbo")
  )
)
```

<!-- ```js
vg.plot(
  vg.rectY(
    vg.from("crashes"),
    { x: vg.bin("time"), y: vg.count(), inset: 0.5 }
  ),
  vg.intervalX({ as: $filter }),
  vg.yTickFormat("s"),
  vg.xLabel("Pickup Hour"),
  vg.yLabel("Number of Rides"),
  vg.width(680),
  vg.height(100)
)
``` -->

Select an interval in a plot to filter the maps.
_What spatial patterns can you find?_
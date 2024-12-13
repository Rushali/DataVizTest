import {csvFormat, csvParse, tsvParse} from "d3-dsv";
import {utcParse} from "d3-time-format";

async function text(url) {
    const response = await fetch(url);
    if (!response.ok) throw new Error(`fetch failed: ${response.status}`);
    return response.text();
}

// Neighbourhoods
const boroughs = new Set([
    "BROOKLYN",
    "BRONX",
    "MANHATTAN"
  ]);

// Load and parse crashes
const crashcsv = await FileAttachment("crashes.csv").csv({typed: true});
// log it to see how the csv gets formated into objects 
console.log(crashcsv);

// Construct map to lookup borough from name.
// const parseDate = d3.utcParse("%Y-%m-%d");
// const boroughTest = csvParse(crashcsv, ({date, temperature}) => ({
//     date: parseDate(date),
//     temperature: +temperature
//   }));

//console.log(boroughTest);

// const crashdata = csvParse(crashcsv, ({temperature}) => ({
//       temperature: +temperature
// }));

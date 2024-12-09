import { readFileSync } from "fs";

const listOfElement = readFileSync("2.txt");

const splittedLines = listOfElement.toString().trim().split("\n");

const formatedReports = splittedLines.map((subLine) =>
  subLine.split(" ").map(Number)
); //?
const nbOfReportsSafe = formatedReports.reduce((acc, report) => {
  let direction: number;
  let isValid = true;

  for (let i = 0; i < report.length - 1; i++) {
    const computedDistance = report[i + 1] - report[i];

    // Vérifie que la direction reste la même
    if (direction !== undefined && computedDistance * direction < 0) {
      isValid = false;
      break;
    }

    // Vérifie que la différence est entre 1 et 3
    if (Math.abs(computedDistance) < 1 || Math.abs(computedDistance) > 3) {
      isValid = false;
      break;
    }

    direction = computedDistance;
  }

  return isValid ? acc + 1 : acc;
}, 0);

console.log(nbOfReportsSafe);

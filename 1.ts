import { readFileSync } from "fs";

const listOfElement = readFileSync("1.txt"); //?

const splittedLines = listOfElement.toString().trim().split("\n");
const leftElements = splittedLines
  .map((element) => Number(element.split("  ")[0]))
  .sort();
const rightElements = splittedLines
  .map((element) => Number(element.split("  ")[1]))
  .sort();

const sumDistance = leftElements.reduce((acc, value, index) => {
  const distance = Math.abs(value - rightElements[index]);
  return acc + distance;
}, 0); //?

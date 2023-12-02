"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const read_input_1 = __importDefault(require("./read-input"));
const input = (0, read_input_1.default)();
const literals = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
console.log(input);
console.log(input.split('\n').map((x) => {
    let firstNum = undefined;
    let firstNumI = 2 ** 52;
    let lastNum = undefined;
    let lastNumI = -1;
    literals.forEach((literal, i) => {
        {
            const firstI = x.indexOf(literal);
            if (firstI < firstNumI && firstI != -1) {
                firstNumI = firstI;
                firstNum = i + 1;
            }
        }
        {
            const firstI = x.indexOf((i + 1).toString());
            if (firstI < firstNumI && firstI != -1) {
                firstNumI = firstI;
                firstNum = i + 1;
            }
        }
        {
            const lastI = x.lastIndexOf(literal);
            if (lastI > lastNumI) {
                lastNumI = lastI;
                lastNum = i + 1;
            }
        }
        {
            const lastI = x.lastIndexOf((i + 1).toString());
            if (lastI > lastNumI) {
                lastNumI = lastI;
                lastNum = i + 1;
            }
        }
    });
    if (!firstNum || !lastNum) {
        console.log(x, firstNum, lastNum);
    }
    return Number([firstNum, lastNum].join(""));
}).reduce((prev, curr) => prev + curr, 0));

import readInput from "./read-input";

const input = readInput();


const literals = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
console.log(input)
console.log(input.split('\n').map((x) => {
	let firstNum: number | undefined = undefined;
	let firstNumI = 2 ** 52;
	let lastNum: number | undefined = undefined;
	let lastNumI = -1;

	literals.forEach((literal, i) => {
		{
			const firstI = x.indexOf(literal)
			if (firstI < firstNumI && firstI != -1) {
				firstNumI = firstI
				firstNum = i + 1
			}
		}
		{
			const firstI = x.indexOf((i + 1).toString())
			if (firstI < firstNumI && firstI != -1) {
				firstNumI = firstI
				firstNum = i + 1
			}
		}
		{
			const lastI = x.lastIndexOf(literal)
			if (lastI > lastNumI) {
				lastNumI = lastI
				lastNum = i + 1
			}
		}
		{
			const lastI = x.lastIndexOf((i + 1).toString())
			if (lastI > lastNumI) {
				lastNumI = lastI
				lastNum = i + 1
			}
		}
	})

	return Number([firstNum, lastNum].join(""))
}).reduce((prev, curr) => prev + curr, 0))


"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const read_input_1 = __importDefault(require("./read-input"));
const input = (0, read_input_1.default)();
// const max: Record<string, number> = {
// 	red: 12,
// 	green: 13,
// 	blue: 14,
// }
const games = input.split('\n').filter((x) => x.startsWith('Game')).map((game) => {
    // const parts = game.split(' ')
    // const id = Number(parts[1]!.replace(':', ''))
    const subsets = game.split(':')[1].split(';').map((x) => x.split(', ').map((y) => {
        const [num, color] = y.trim().split(' ');
        return {
            num: Number(num),
            color: color,
        };
    }));
    const fewest = {};
    const valid = subsets.reduce((prev, curr) => {
        curr.forEach((x) => {
            if (fewest[x.color]) {
                if (fewest[x.color] < x.num) {
                    fewest[x.color] = x.num;
                }
            }
            else {
                fewest[x.color] = x.num;
            }
        });
        return prev;
    }, true);
    return valid ? Object.values(fewest).reduce((prev, curr) => prev * curr, 1) : 0;
}).reduce((prev, curr) => prev + curr, 0);
console.log(games);

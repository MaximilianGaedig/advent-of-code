"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = require("fs");
function readInput() { return (0, fs_1.readFileSync)(0, 'utf-8'); }
exports.default = readInput;

const fs = require('fs');
const crypto = require('crypto');
const path = require('path');

const ROOT_DIR = path.join(__dirname, '..');
const absolutePaths = (paths) => paths.map((p) => {
  return path.join(ROOT_DIR, p);
});

const readFile = (file) => fs.readFileSync(file, { encoding: 'utf-8' });
const readAllFiles = (files) => {
  let data = '';
  files.forEach((file) => {
    data += readFile(file);
  });
  return data;
};
const writeFile = (file, data) => fs.writeFileSync(file, modifiedData);

const md5 = (data) => {
  let hash = crypto.createHash('md5');
  hash.update(data, 'utf8');
  return hash.digest('hex');
};
const populateProductionHash = (data, hash) => data.replace(/<PROD_HASH_REPLACED_DURING_BUILD>/g, hash);


const serviceWorkerFile = './www/sw.js';
const hashRelevantFiles = absolutePaths([
  serviceWorkerFile,
  './www/index.html',
]);

const data = readAllFiles(hashRelevantFiles);
const hash = md5(data);

const serviceWorkerData = readFile(serviceWorkerFile);
const modifiedData = populateProductionHash(serviceWorkerData, hash);

writeFile(serviceWorkerFile, modifiedData);



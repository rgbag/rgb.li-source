const replace = require('replace-in-file');

const optionsLog = {
    files: 'source/js/main.coffee',
    from: / console.log/g,
    to: ' #console.log',
  };

replace(optionsLog)
  .then(results => {
    console.log('Replacement results:', results);
  })
  .catch(error => {
    console.error('Error occurred:', error);
  });

const optionsBrowserSyncStyle = {
    files: 'source/index.pug',
    from: /include css\/browser-sync.css/g,
    to: '//- include css/browser-sync.css',
  };

replace(optionsBrowserSyncStyle)
  .then(results => {
    console.log('Replacement results:', results);
  })
  .catch(error => {
    console.error('Error occurred:', error);
  });

const express = require('express');
const Redis = require("ioredis");
const bodyParser = require('body-parser');

const pino = require('pino');
const expressPino = require('express-pino-logger');
const logger = pino({ level: process.env.LOG_LEVEL || 'info' });
const expressLogger = expressPino({ logger });

const app = express();
app.use(expressLogger);

const redis = new Redis();
const jsonParser = bodyParser.json();

const port = process.env.PORT || 9000;

redis.on('connect', function() {
  logger.debug('redis connected');
});

redis.on('error', function(err) {
  logger.error('redis error:' + err);
  process.exit();
});

app.post('/', jsonParser, async function(req, res) {
  try {
    const { value } = req.body;

    if (!value) {
      return res.status(404).send({
        message: 'There is no value to set'
      });
    }

    const setResult = await redis.set('key', value);
    logger.debug('write key:' + value);

    if (setResult) {
      const getResult = await redis.get('key');
      res.json({
        data: getResult
      });
    } else {
      res.status(500).send({
        message: 'Could not read redis key'
      });
    }
  } catch (err) {
    logger.error(err);
    res.status(500).send({
      message: err
    });
  }
});

app.get('/', async function(req, res) {
  try {
    const getResult = await redis.get('key');
    logger.debug('read key:' + getResult);
    res.json({
      data: getResult
    });
  } catch (err) {
    logger.error(err);
    res.status(500).send({
      message: err
    });
  }
})

app.listen(port, '0.0.0.0', function() {
  console.log('hello redis app is listening on port 9000');
});

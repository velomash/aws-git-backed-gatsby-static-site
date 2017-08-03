'use strict'

exports.handler = function(event, context, callback) {
  console.log(event);
  console.log(process.env.DestinationS3Bucket);
}

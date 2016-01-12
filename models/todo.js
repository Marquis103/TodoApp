

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var TodoSchema  = new Schema(
    {
  name: String
});

mongoose.model('employees', TodoSchema);


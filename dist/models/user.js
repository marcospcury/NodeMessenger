var User, mongoose, userSchema;

mongoose = require("mongoose");

userSchema = new mongoose.Schema({
  name: {
    type: String
  },
  email: {
    type: String
  },
  password: {
    type: String
  }
});

User = mongoose.model("user", userSchema);

module.exports = User;

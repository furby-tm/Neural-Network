Card [] testing_set; // the set we use to train (2000)
Card [] training_set; // the set we use to train (8000)

class Card {
  float [] inputs;
  float [] outputs;
  int output;
  
  Card(){
    inputs = new float[196];
    outputs = new float[10];
  }
  
  void imageLoad(byte [] images, int offset){
    // Each image consists of 196 bytes
    // Loading  a total of 1,960,000 bytes
    for (int i = 0; i < 196; i++) {
      inputs[i] = int(images[i+offset]) / 128.0 - 1.0; // We then store each pixel in the array inputs[] after converting it from (0 - 255) to (+1 - -1) as they vary on the greyscale
    }
  }
  
  void labelLoad(byte [] labels, int offset){
    // Lables are a total of 10,000 byes, each one representing the label for the card in question.
    // We then go through the 10 template outputs and highlight the correct answer within them.
    output = int(labels[offset]);

    for (int i = 0; i < 10; i++) {  // We then set the correct index in output[] to +1 if it corresponds to the ouput and -1 if not
      if (i == output) {
        outputs[i] = 1.0;
      } else {
        outputs[i] = -1.0;
      }
    }
  }
}

// loadData is called outside of our class
void loadData(){
 // Uses Processing's inbuilt function "loadBytes()" to load the images and labels.
 // Four out of every five cards is assigned to the training set while every fifth card is assigned to the set instead.
  byte [] images = loadBytes("t10k-images-14x14.idx3-ubyte");
  byte [] labels = loadBytes("t10k-labels.idx1-ubyte");
  training_set = new Card [8000];
  int tr_pos = 0;
  testing_set = new Card [2000];
  int te_pos = 0;
  for (int i = 0; i < 10000; i++) {
    if (i % 5 != 0) { 
      training_set[tr_pos] = new Card();
      training_set[tr_pos].imageLoad(images, 16 + i * 196); // There is an offset of 16 bytes
      training_set[tr_pos].labelLoad(labels, 8 + i);  // There is an offset of 8 bytes
      tr_pos++;
    } else {
      testing_set[te_pos] = new Card();
      testing_set[te_pos].imageLoad(images, 16 + i * 196);  // There is an offset of 16 bytes 
      testing_set[te_pos].labelLoad(labels, 8 + i);  // There is an offset of 8 bytes
      te_pos++;
    }
  }
}
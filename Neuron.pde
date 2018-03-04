class Neuron {
  float m_output;
  void display() {
    // Number is inverted then scaled 0 to 255
    fill(128 * (1-m_output));
    ellipse(0,0,16,16);
  }
}
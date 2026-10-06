import 'dart:html';

void main() {
  // Select the paragraph from the HTML page
  final message = document.querySelector('#message');

  // Select the button from the HTML page
  final button = document.querySelector('#changeButton');

  // Handle the button click
  button?.onClick.listen((event) {
    // Change the text
    message?.text = 'The DOM was successfully updated using Dart!';

    // Change the style
    message?.style.color = 'green';
    message?.style.fontSize = '24px';
  });
}

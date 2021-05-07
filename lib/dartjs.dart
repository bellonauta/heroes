@JS()
library functions.js;

import 'package:js/js.dart';

// Calls invoke JavaScript `JSON.stringify(obj)`.
@JS('combatWinner')
external int winner(double pes1C, double alt1C, double vel1C, bool fav1C,
    double pes2C, double alt2C, double vel2C, bool fav2C);

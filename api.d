module gpioAPI;
import std.file;
import std.format;
import std.conv;

string sysPath = "/sys/class/gpio/";

enum GPIOPinState{
    HIGH,
    LOW
}

enum GPIOPinDirection
{
    IN,
    OUT
}

void exportPin(int pin){
    append(format!"%s%s"(sysPath, "export"), to!string(pin));
}

void unexportPin(int pin){
    append(format!"%s%s"(sysPath, "unexport"), to!string(pin));
}

void setPinDirection(int pin, GPIOPinDirection direction){
    append(format!"%sgpio%d/direction"(sysPath, pin), direction == GPIOPinDirection.IN? "in" : "out");
}

void setPinState(int pin, GPIOPinState state){
    append(format!"%sgpio%d/value"(sysPath, pin), state == GPIOPinState.HIGH? "1" : "0");
}
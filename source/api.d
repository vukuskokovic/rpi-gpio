module RPI.GPIO;
import std.file;
import std.format;
import std.conv;

const int GPIO_HIGH = 1;
const int GPIO_LOW = 0;
const string GPIO_OUT = "out";
const string GPIO_IN = "in";
const string api_path = "/sys/class/gpio/";

__gshared bool printWarngins = true;

void printWarnings(bool value){
    printWarngins = value;
}

void exportPin(int pin){
    writeToFile("export", to!string(pin));
}

void unexportPin(int pin){
    writeToFile("unexport", to!string(pin));
}

void setPinState(int pin, int state){
    writeToFile(format!"gpio%d/value"(pin), to!string(pin));
}

void setPinDirection(int pin, string direction){
    writeToFile(format!"gpio%d/direction"(pin), direction);
}

string getPinDirection(int pin){
    string dir = format!"gpio%d/direction"(pin);
    if(exists(formatPath(dir)){
        return readText(dir);
    }else if(printWarngins){
        writeln(format!"Pin %d was tried to get accessed, but it was not exported"(pin));
    }
}

int getPinState(int pin){
    string dir = format!"gpio%d/state"(pin);
    if(exists(formatPath(dir)){
        return readText(dir);
    }else if(printWarngins){
        writeln(format!"Pin %d was tried to get accessed, but it was not exported"(pin));
    }
}

string formatPath(string path){
    return format!"%s%s"(api_path, path);
}

void writeToFile(string path, string context){
    try{
        append(formatPath(path), context);
    }catch(Exception ex){
        import std.stdio : writeln;
        if(printWarngins){
            writeln("Failed writing file: " + ex);
        }
    }
}
#include <jni.h>
#include <string>
#include <linux/gpio.h>
#include <linux/i2c-dev.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <sstream>
#include <iomanip>


#define I2C_DEVICE "/dev/i2c-12"
#define I2C_ADDRESS 0x60
static float frequency;
int i2c_file;
extern "C"
JNIEXPORT jstring JNICALL
Java_com_example_pixel_1infotainment_MainActivity_setStation(JNIEnv *env, jobject thiz, float station) {
    std::string open1 = "Failed to open I2C device";
    std::string address1 ="Failed to set I2C slave address";
    std::string write1 ="Failed to write to I2C device";
    frequency = station;
    i2c_file = open(I2C_DEVICE, O_RDWR);
    if (i2c_file < 0) {
        perror("Failed to open I2C device");
        return env->NewStringUTF(open1.c_str());
    }

    int freq14bit = (int)(4 * (frequency * 1000000 + 225000) / 32768);
    unsigned char data[4] = {0};
    data[0] = freq14bit >> 8;
    data[1] = freq14bit & 0xFF;
    data[2] = 0xB0;
    data[3] = 0x10;

    if (ioctl(i2c_file, I2C_SLAVE, I2C_ADDRESS) < 0) {
        perror("Failed to set I2C slave address");
        return env->NewStringUTF(address1.c_str());
    }

    if (write(i2c_file, data, sizeof(data)) != sizeof(data)) {
        perror("Failed to write to I2C device");
        return env->NewStringUTF(write1.c_str());
    }
    
    std::stringstream ss;
    ss << std::fixed << std::setprecision(2) << frequency;
    std::string valueString = ss.str();

    // Return the string
    return env->NewStringUTF(valueString.c_str());
}
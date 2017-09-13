#ifndef SETTINGS_H
#define SETTINGS_H

#include <iostream>
#include <QDebug>
#include <fstream>
#include <cstdlib>
#include <string>
#include <cstring>
#include <sstream>
#include <time.h>
#include <pthread.h>
#include <cstddef>
#include <ctime>
#include <time.h>
#include <QThread>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <QStringList>

class settings
{
public:
    settings();

    settings(QString path);
    void readSettings(QString path);

    void initProg();
    void stop();

    QString getdatabaseip();
    void setdatabaseip(QString m);

    QString getdatabaseport();
    void setdatabaseport(QString m);

    QString getdatabasename();
    void setdatabasename(QString m);

    QString getdbpassword();
    void setdbpassword(QString m);

    QString getdbusername();
    void setdbusername(QString m);

    QString getlogging();
    void setlogging(QString m);

    bool isInitialized();
    virtual ~settings();

private:
    volatile bool stopped;
    bool initialized;
    QString database_ip;
    QString database_port;
    QString database_name;
    QString db_password;
    QString db_username;
    QString logging;
};

#endif // SETTINGS_H

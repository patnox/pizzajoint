#include "settings.h"

settings::settings(QString path)
{
    //All initialization here
    stopped = false;
    initProg();
    readSettings(path);
}

settings::settings()
{
    //All initialization here
    stopped = false;
    initProg();
}

QString settings::getdatabaseip()
{
    return(database_ip);
}

void settings::setdatabaseip(QString m)
{
    database_ip = m;
}

QString settings::getdatabaseport()
{
    return(database_port);
}

void settings::setdatabaseport(QString m)
{
    database_port = m;
}

QString settings::getdatabasename()
{
    return(database_name);
}

void settings::setdatabasename(QString m)
{
    database_name = m;
}

QString settings::getdbpassword()
{
    return(db_password);
}

void settings::setdbpassword(QString m)
{
    db_password = m;
}

QString settings::getdbusername()
{
    return(db_username);
}

void settings::setdbusername(QString m)
{
    db_username = m;
}

QString settings::getlogging()
{
    return(logging);
}

void settings::setlogging(QString m)
{
    logging = m;
}

void settings::readSettings(QString path)
{
    //Read settings from the file given in the path
    try
    {
        QFile settings(path);
        if(settings.open(QIODevice::ReadOnly|QIODevice::Text))
        {
            //The file is opened so let us read it
            QTextStream in(&settings);
            QStringList eam;
            QString line;
            do
            {
                line = in.readLine();
                eam << line;
            }
            while(!line.isNull());
            //loop through the list to extract data
            QString desi[eam.size()];
            /**
            QStringListIterator ji(eam);
            while (ji.hasNext())
            {
                desi[i] = ji.next().toLocal8Bit().constData() << endl;
            }
            **/
            for (int i = 0; i < eam.size(); ++i)
            {
                desi[i] = eam.at(i).toLocal8Bit().constData();
            }
            //yes now we have all the data from settings file
            //lets extract it
            for (int i = 0; i < eam.size(); ++i)
            {
                QString mess = desi[i].trimmed();
                int delpos = mess.indexOf("=");
                if(delpos != -1)
                {
                    QString valname = mess.left(delpos);
                    if(!valname.isNull() && !valname.isEmpty())
                    {
                        //qDebug() << "Got a valid settings value: " << mess.toStdString().c_str() << endl;
                        int sz = mess.size();
                        int rt = sz - (delpos + 1);
                        QString val = mess.right(rt);
                        valname = valname.simplified();
                        val = val.simplified();
                        //qDebug() << "valname is: " << valname.toStdString().c_str() << " || val is: " << val.toStdString().c_str() << endl;
                        if(QString::compare(valname, "database_ip", Qt::CaseInsensitive) == 0)
                        {
                            database_ip = val;
                            qDebug() << "database_ip is now initialized as: " << database_ip << endl;
                        }
                        else if(QString::compare(valname, "database_port", Qt::CaseInsensitive) == 0)
                        {
                            database_port = val;
                            qDebug() << "database_port is now initialized as: " << database_port << endl;
                        }
                        else if(QString::compare(valname, "database_name", Qt::CaseInsensitive) == 0)
                        {
                            database_name = val;
                            qDebug() << "database_name is now initialized as: " << database_name << endl;
                        }
                        else if(QString::compare(valname, "db_password", Qt::CaseInsensitive) == 0)
                        {
                            db_password = val;
                            qDebug() << "db_password is now initialized as: " << db_password << endl;
                        }
                        else if(QString::compare(valname, "logging", Qt::CaseInsensitive) == 0)
                        {
                            logging = val;
                            qDebug() << "logging is now initialized as: " << logging << endl;
                        }
                        else if(QString::compare(valname, "db_username", Qt::CaseInsensitive) == 0)
                        {
                            db_username = val;
                            qDebug() << "db_username is now initialized as: " << db_username << endl;
                        }
                    }
                }
            }
            initialized = true;
        }
        else
        {
            qDebug() << "Failed to read settings from file.::Opening Error::.Loading defaults" << endl;
        }
    }
    catch(...)
    {
        qDebug() << "Failed to read settings from file.::FS Error::.Loading defaults." << endl;
    }
}

void settings::initProg()
{
    //Program initialization
    stopped = false;
    initialized = false;
    logging = "false";
    database_ip = "127.0.0.1";
    database_port = "3306";
    database_name = "pizzajoint";
    db_password = "patnox";
    db_username = "root";
}

void settings::stop()
{
    stopped = true;
}

settings::~settings()
{
    stopped = true;
    qDebug() << "Settings Thread Destroyed" << endl;
}

bool settings::isInitialized()
{
    return(initialized);
}





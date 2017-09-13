#ifndef ORDERITEM_H
#define ORDERITEM_H

#include <QString>

class orderitem
{
public:
    explicit orderitem();
    //virtual ~orderitem() {};
    ~orderitem();
    int getID();
    int getType();
    QString getDescription();
    int getQuantity();
    double getEachAt();
    double getTotal();
    void setID(int);
    void setType(int);
    void setDescription(QString);
    void setQuantity(int);
    void setEachAt(double);
    void setTotal(double);

private:
    int id;
    int type;
    QString description;
    int quantity;
    double eachat;
    double total;
};

#endif // ORDERITEM_H

#include "orderitem.h"

orderitem::orderitem()
{
    //constructor
}

//destructor
orderitem::~orderitem()
{
    //destructor
}

int orderitem::getID()
{
    return(id);
}

int orderitem::getType()
{
    return(type);
}

QString orderitem::getDescription()
{
    return(description);
}

int orderitem::getQuantity()
{
    return(quantity);
}

double orderitem::getEachAt()
{
    return(eachat);
}

double orderitem::getTotal()
{
    return(total);
}

void orderitem::setID(int myid)
{
    id = myid;
}

void orderitem::setType(int mytype)
{
    type = mytype;
}

void orderitem::setDescription(QString mydescription)
{
    description = mydescription;
}

void orderitem::setQuantity(int myquantity)
{
    quantity = myquantity;
}

void orderitem::setEachAt(double myeachat)
{
    eachat = myeachat;
}

void orderitem::setTotal(double mytotal)
{
    total = mytotal;
}



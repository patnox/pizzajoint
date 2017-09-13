#include "mainwindow.h"
#include "ui_mainwindow.h"

//constructor
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    //This maps out the actions of the automaticaly created buttons
    connect(&productsMapper, SIGNAL(mapped(int)), this, SLOT(productSelected(int)));
    connect(&basicToppingsMapper, SIGNAL(mapped(int)), this, SLOT(basicToppingsDisplaySelected(int)));
    connect(&deluxeToppingsMapper, SIGNAL(mapped(int)), this, SLOT(deluxeToppingsDisplaySelected(int)));
    connect(&basicToppingsControlMapper, SIGNAL(mapped(QString)), this, SLOT(basicToppingsControlSelected(QString)));
    connect(&deluxeToppingsControlMapper, SIGNAL(mapped(QString)), this, SLOT(deluxeToppingsControlSelected(QString)));
    //Get settings
    localsettings = new settings(QCoreApplication::applicationDirPath() + "/pizzajoint.conf");
    //connect to the database
    connectedToDB = false;
    connectedToDB = connectToDB();
    if(connectedToDB)
    {
        qDebug() << "Application is Now Connected to DB";
        ui->cmdNewOrder->setEnabled(true);
        ui->cmdAddProduct->setEnabled(true);
        ui->stackedWidget->setCurrentIndex(0);
        initProducts();
        getTheTAX();
    }
    //The order display table model
    tableModel = new QStandardItemModel(30, 5, this); //30 Rows and 5 Columns
    tableModel->setHorizontalHeaderItem(0, new QStandardItem(QString("Description")));
    tableModel->setHorizontalHeaderItem(1, new QStandardItem(QString("Quantity")));
    tableModel->setHorizontalHeaderItem(2, new QStandardItem(QString("@")));
    tableModel->setHorizontalHeaderItem(3, new QStandardItem(QString("Total")));
    tableModel->setHorizontalHeaderItem(4, new QStandardItem(QString("Toppings")));

    ui->tblOrder->setModel(tableModel);

    //stretch out the order table
    for (int c = 0; c < ui->tblOrder->horizontalHeader()->count(); ++c)
    {
        ui->tblOrder->horizontalHeader()->setSectionResizeMode(c, QHeaderView::Stretch);
    }

    //clear order
    order.clear();
    ui->stackedWidget->setCurrentIndex(0);

    //One item selection at a time
    ui->tblOrder->setSelectionBehavior(QAbstractItemView::SelectRows);
    ui->tblOrder->setSelectionMode(QAbstractItemView::SingleSelection);

    //Height of rows
    QHeaderView *verticalHeader = ui->tblOrder->verticalHeader();
    verticalHeader->setSectionResizeMode(QHeaderView::Fixed);
    verticalHeader->setDefaultSectionSize(70);
}

//destructor
MainWindow::~MainWindow()
{
    delete ui;
}

//init the products choice buttons
void MainWindow::initProducts()
{
    //init the products choice buttons
    QSqlQuery query;
    query.exec("SELECT id, description FROM product");
    while (query.next())
    {
        QString name = query.value(1).toString();
        QPushButton *m_button = new QPushButton(name);
        m_button->setMinimumHeight(50);
        ui->vlProducts->addWidget(m_button);
        connect(m_button, SIGNAL(clicked()), &productsMapper, SLOT(map()));
        productsMapper.setMapping(m_button, query.value(0).toInt());
        ui->vlProducts->addStretch();
    }
}

//get the tax percentage
void MainWindow::getTheTAX()
{
    //TAX
    QSqlQuery query;
    query.exec("SELECT value FROM settings WHERE name = 'GST'");
    if (query.next())
    {
        tax = query.value(0).toDouble();
        qDebug() << "Got GST as: " << tax;
    }
    else
    {
        tax = 0;
        qDebug() << "Failed to get GST setting it as zero";
    }
}

void MainWindow::productSelected(int id)
{
    //handle product selection
    QSqlQuery query;
    QString myquery = "SELECT id, description, price  FROM product where id = ";
    myquery.append(QString::number(id));
    qDebug() << "Query is: " << myquery;
    query.exec(myquery);
    if (query.next())
    {
        orderitem myorderitem;
        myorderitem.setID(query.value(0).toInt());
        myorderitem.setDescription(query.value(1).toString());
        myorderitem.setEachAt(query.value(2).toDouble());
        myorderitem.setType(1);
        myorderitem.setQuantity(1);
        myorderitem.setTotal(query.value(2).toDouble());
        order.append(myorderitem);
        refreshOrderDisplay();
        qDebug() << "Populated order item: " << id;
    }
    else
    {
        qDebug() << "No product found matching id: " << id;
    }
    ui->stackedWidget->setCurrentIndex(0);
}

//Refresh the order display
void MainWindow::refreshOrderDisplay()
{
    //Refresh
    tableModel->removeRows(0, (tableModel->rowCount()));
    QVectorIterator<orderitem> m(order);
    double orderTotal = 0.00;
    while(m.hasNext())
    {
        orderitem k = m.next();
        int tablerow = tableModel->rowCount();
        QString description = k.getDescription();
        QStandardItem *item1 = new QStandardItem(description);
        tableModel->setItem(tablerow, 0, item1);
        int quantity = k.getQuantity();
        QStandardItem *item2 = new QStandardItem(QString::number(quantity));
        tableModel->setItem(tablerow, 1, item2);
        double eachat = k.getEachAt();
        QStandardItem *item3 = new QStandardItem(QString::number(eachat));
        tableModel->setItem(tablerow, 2, item3);
        double total = k.getTotal();
        QStandardItem *item4 = new QStandardItem(QString::number(total));
        tableModel->setItem(tablerow, 3, item4);
        orderTotal += total;
        //Add action buttons only if item is of type 1 (main product)
        if(k.getType() == 1)
        {
            QWidget *actions = new QWidget();
            QPushButton *m_button1 = new QPushButton("Basic");
            QPushButton *m_button2 = new QPushButton("Deluxe");
            m_button1->setMinimumHeight(50);
            m_button2->setMinimumHeight(50);
            QHBoxLayout *tblActionButtons = new QHBoxLayout();
            tblActionButtons->addWidget(m_button1);
            tblActionButtons->addWidget(m_button2);
            connect(m_button1, SIGNAL(clicked()), &basicToppingsMapper, SLOT(map()));
            connect(m_button2, SIGNAL(clicked()), &deluxeToppingsMapper, SLOT(map()));
            basicToppingsMapper.setMapping(m_button1, k.getID());
            deluxeToppingsMapper.setMapping(m_button2, k.getID());
            tblActionButtons->addStretch();
            //tableModel->setItem(tablerow, 4, tblActionButtons);
            actions->setLayout(tblActionButtons);
            QModelIndex item = tableModel->index(tablerow, 4);
            ui->tblOrder->setIndexWidget(item, actions);
        }
    }
    //stretch out the order table
    for (int c = 0; c < ui->tblOrder->horizontalHeader()->count(); ++c)
    {
        ui->tblOrder->horizontalHeader()->setSectionResizeMode(c, QHeaderView::Stretch);
    }
    //Refresh totals
    ui->lblSubTotal->setText(QString::number(orderTotal, 'f', 2));
    double orderTax = orderTotal * (tax / 100);
    ui->lblGST->setText(QString::number(orderTax, 'f', 2));
    double Total = orderTotal + orderTax;
    ui->lblTotal->setText(QString::number(Total, 'f', 2));
    //Enable or disable ability to save order in DB
    if(Total > 0)
    {
        ui->cmdPostOrder->setEnabled(true);
    }
    else
    {
        ui->cmdPostOrder->setEnabled(false);
    }
}

//connect to DB
bool MainWindow::connectToDB()
{
    db = QSqlDatabase::addDatabase("QMYSQL");
    /**
    db.setDatabaseName("pizzajoint");
    db.setHostName("localhost");
    db.setUserName("root");
    db.setPassword("patnox");
    db.setPort(3306);
    **/
    db.setDatabaseName(localsettings->getdatabasename());
    db.setHostName(localsettings->getdatabaseip());
    db.setUserName(localsettings->getdbusername());
    db.setPassword(localsettings->getdbpassword());
    db.setPort(localsettings->getdatabaseport().toInt());
    bool ok = db.open();

    if (!ok)
    {
      QMessageBox errorDialog;
      errorDialog.setIcon(QMessageBox::Critical);
      errorDialog.addButton(QMessageBox::Ok);
      errorDialog.setText(db.lastError().text() + " Set the DB and restart.");
      errorDialog.setWindowTitle("Database Error");
      errorDialog.exec();
      return(false);
    }
    return(true);
}

void MainWindow::on_cmdAddProduct_clicked()
{
    ui->stackedWidget->setCurrentIndex(1);
}

void MainWindow::on_cmdExit_clicked()
{
    //QApplication::quit();
    qApp->exit();
}

void MainWindow::on_cmdRemoveItem_clicked()
{
    //Remove an item from the order
    QModelIndex currentIndex = ui->tblOrder->selectionModel()->currentIndex();
    int index = currentIndex.row();
    qDebug() << "Removing Item at index: " << index;
    //tableModel->removeRow(index);
    if(index >= 0)
    {
        order.removeAt(index);
        refreshOrderDisplay();
    }
    else
    {
      QMessageBox errorDialog;
      errorDialog.setIcon(QMessageBox::Critical);
      errorDialog.addButton(QMessageBox::Ok);
      errorDialog.setText("Please select an item first");
      errorDialog.setWindowTitle("Selection Error");
      errorDialog.exec();
    }
}

//Add quantity of item
void MainWindow::on_cmdPlus_clicked()
{
    //Add quantity of item
    QModelIndex currentIndex = ui->tblOrder->selectionModel()->currentIndex();
    int index = currentIndex.row();
    if(index >= 0)
    {
        qDebug() << "Adding quantity on Item at index: " << index;
        orderitem addQuan = order.at(index);
        int quantity = addQuan.getQuantity();
        quantity++;
        addQuan.setQuantity(quantity);
        double price = addQuan.getEachAt();
        double total = quantity * price;
        addQuan.setTotal(total);
        order.replace(index, addQuan);
        refreshOrderDisplay();
    }
    else
    {
      QMessageBox errorDialog;
      errorDialog.setIcon(QMessageBox::Critical);
      errorDialog.addButton(QMessageBox::Ok);
      errorDialog.setText("Please select an item first");
      errorDialog.setWindowTitle("Selection Error");
      errorDialog.exec();
    }
}

//Reduce quantity of item
void MainWindow::on_cmdMinus_clicked()
{
    //Reduce quantity of item
    QModelIndex currentIndex = ui->tblOrder->selectionModel()->currentIndex();
    int index = currentIndex.row();
    if(index >= 0)
    {
        qDebug() << "Adding quantity on Item at index: " << index;
        orderitem addQuan = order.at(index);
        int quantity = addQuan.getQuantity();
        if(quantity >= 2)
        {
            quantity--;
            addQuan.setQuantity(quantity);
            double price = addQuan.getEachAt();
            double total = quantity * price;
            addQuan.setTotal(total);
            order.replace(index, addQuan);
            refreshOrderDisplay();
        }
    }
    else
    {
      QMessageBox errorDialog;
      errorDialog.setIcon(QMessageBox::Critical);
      errorDialog.addButton(QMessageBox::Ok);
      errorDialog.setText("Please select an item first");
      errorDialog.setWindowTitle("Selection Error");
      errorDialog.exec();
    }
}

//create a new order
void MainWindow::on_cmdNewOrder_clicked()
{
    //create a new order
    order.clear();
    ui->stackedWidget->setCurrentIndex(0);
    refreshOrderDisplay();
}

//user wants to add basic toppings -- id is product id
void MainWindow::basicToppingsDisplaySelected(int id)
{
    //user wants to add basic toppings
    clearLayout(ui->vlBasicToppings, true);
    clearLayout(ui->vlDeluxeToppings, true);
    QSqlQuery query;
    QString myquery = "SELECT basic_toppings.id, basic_toppings.description, basic_toppings_price.price FROM basic_toppings INNER JOIN basic_toppings_price ON basic_toppings.id = basic_toppings_price.basic_toppings_id and basic_toppings_price.product_id = ";
    myquery.append(QString::number(id));
    qDebug() << "Executing query: " << myquery;
    query.exec(myquery);
    while (query.next())
    {
        QString name = query.value(1).toString();
        name.append(" at $");
        name.append(query.value(2).toString());
        QPushButton *m_button = new QPushButton(name);
        m_button->setMinimumHeight(50);
        ui->vlBasicToppings->addWidget(m_button);
        //m_button->setGeometry(QRect(QPoint(100, 100), QSize(200, 50)));
        //connect(m_button, SIGNAL (clicked()), this, SLOT (handleButton()));
        connect(m_button, SIGNAL(clicked()), &basicToppingsControlMapper, SLOT(map()));
        //create a token composed of "product_id|basic_toppings_id"
        QString token = QString::number(id);
        token.append("|");
        token.append(QString::number(query.value(0).toInt()));
        basicToppingsControlMapper.setMapping(m_button, token);
        ui->vlBasicToppings->addStretch();
    }
    ui->stackedWidget->setCurrentIndex(2);
}

//user wants to add deluxe toppings -- id is product id
void MainWindow::deluxeToppingsDisplaySelected(int id)
{
    //user wants to add deluxe toppings
    clearLayout(ui->vlBasicToppings, true);
    clearLayout(ui->vlDeluxeToppings, true);
    QSqlQuery query;
    QString myquery = "SELECT deluxe_toppings.id, deluxe_toppings.description, deluxe_toppings_price.price FROM deluxe_toppings INNER JOIN deluxe_toppings_price ON deluxe_toppings.id = deluxe_toppings_price.deluxe_toppings_id and deluxe_toppings_price.product_id = ";
    myquery.append(QString::number(id));
    qDebug() << "Executing query: " << myquery;
    query.exec(myquery);
    while (query.next())
    {
        QString name = query.value(1).toString();
        name.append(" at $");
        name.append(query.value(2).toString());
        QPushButton *m_button = new QPushButton(name);
        m_button->setMinimumHeight(50);
        ui->vlDeluxeToppings->addWidget(m_button);
        //m_button->setGeometry(QRect(QPoint(100, 100), QSize(200, 50)));
        //connect(m_button, SIGNAL (clicked()), this, SLOT (handleButton()));
        connect(m_button, SIGNAL(clicked()), &deluxeToppingsControlMapper, SLOT(map()));
        //create a token composed of "product_id|basic_toppings_id"
        QString token = QString::number(id);
        token.append("|");
        token.append(QString::number(query.value(0).toInt()));
        deluxeToppingsControlMapper.setMapping(m_button, token);
        ui->vlDeluxeToppings->addStretch();
    }
    ui->stackedWidget->setCurrentIndex(2);
}

//A basic toppings item has been selected -- basic toppings id
void MainWindow::basicToppingsControlSelected(QString token)
{
    //A basic toppings item has been selected
    qDebug() << "Basic Toppings Got token: " << token;
    QStringList tokens = token.split ("|");
    int productID = 0;
    int basicToppingsID = 0;
    if (tokens.count() == 2)
    {
        productID = tokens.at(0).toInt();
        basicToppingsID = tokens.at(1).toInt();
    }
    QSqlQuery query;
    QString myquery = "SELECT basic_toppings.id, basic_toppings.description, basic_toppings_price.price FROM basic_toppings INNER JOIN basic_toppings_price ON basic_toppings.id = basic_toppings_price.basic_toppings_id and basic_toppings_price.product_id = ";
    myquery.append(QString::number(productID));
    myquery.append(" and basic_toppings.id = ");
    myquery.append(QString::number(basicToppingsID));
    qDebug() << "Executing query: " << myquery;
    query.exec(myquery);
    if (query.next())
    {
        orderitem myorderitem;
        myorderitem.setID(query.value(0).toInt());
        QString name = query.value(1).toString();
        name.append(" Basic Toppings");
        myorderitem.setDescription(name);
        myorderitem.setEachAt(query.value(2).toDouble());
        myorderitem.setType(2);
        myorderitem.setQuantity(1);
        myorderitem.setTotal(query.value(2).toDouble());
        order.append(myorderitem);
        refreshOrderDisplay();
        qDebug() << "Populated basic toppings order item: " << basicToppingsID;
    }
    else
    {
        qDebug() << "No basic toppings found matching id: " << basicToppingsID;
    }
    ui->stackedWidget->setCurrentIndex(0);
}

//A deluxe toppings item has been selected -- deluxe toppings id
void MainWindow::deluxeToppingsControlSelected(QString token)
{
    //A deluxe toppings item has been selected
    qDebug() << "Deluxe Toppings Got token: " << token;
    QStringList tokens = token.split ("|");
    int productID = 0;
    int deluxeToppingsID = 0;
    if (tokens.count() == 2)
    {
        productID = tokens.at(0).toInt();
        deluxeToppingsID = tokens.at(1).toInt();
    }
    QSqlQuery query;
    QString myquery = "SELECT deluxe_toppings.id, deluxe_toppings.description, deluxe_toppings_price.price FROM deluxe_toppings INNER JOIN deluxe_toppings_price ON deluxe_toppings.id = deluxe_toppings_price.deluxe_toppings_id and deluxe_toppings_price.product_id = ";
    myquery.append(QString::number(productID));
    myquery.append(" and deluxe_toppings.id = ");
    myquery.append(QString::number(deluxeToppingsID));
    qDebug() << "Executing query: " << myquery;
    query.exec(myquery);
    if (query.next())
    {
        orderitem myorderitem;
        myorderitem.setID(query.value(0).toInt());
        QString name = query.value(1).toString();
        name.append(" Deluxe Toppings");
        myorderitem.setDescription(name);
        myorderitem.setEachAt(query.value(2).toDouble());
        myorderitem.setType(3);
        myorderitem.setQuantity(1);
        myorderitem.setTotal(query.value(2).toDouble());
        order.append(myorderitem);
        refreshOrderDisplay();
        qDebug() << "Populated deluxe toppings order item: " << deluxeToppingsID;
    }
    else
    {
        qDebug() << "No deluxe toppings found matching id: " << deluxeToppingsID;
    }
    ui->stackedWidget->setCurrentIndex(0);
}

//Go back to the order view
void MainWindow::on_cmdBackToOrder_clicked()
{
    //Go back to the order view
    ui->stackedWidget->setCurrentIndex(0);
}

void MainWindow::clearLayout(QLayout* layout, bool deleteWidgets = true)
{
    while (QLayoutItem* item = layout->takeAt(0))
    {
        if (deleteWidgets)
        {
            if (QWidget* widget = item->widget())
            {
                widget->deleteLater();
            }
        }
        if (QLayout* childLayout = item->layout())
        {
            clearLayout(childLayout, deleteWidgets);
        }
        delete item;
    }
}

//Save the order into DB
void MainWindow::on_cmdPostOrder_clicked()
{
    //Save the order into DB
    double orderTotal = 0.00;
    QDateTime currentTime = QDateTime::currentDateTime();
    QString myCurrentTime = currentTime.toString("yyyy-MM-dd HH:mm:ss");
    qDebug() << "Got Order Date as: " << myCurrentTime;
    int orderID = 0;
    //Make sure we have items in the order
    if(order.size() > 0)
    {
        //Get the order total
        QVectorIterator<orderitem> m(order);
        while(m.hasNext())
        {
            orderitem k = m.next();
            double total = k.getTotal();
            orderTotal += total;
        }
        //round off to 2 decimal places
        orderTotal = orderTotal + (orderTotal * (tax / 100));
        orderTotal = ceilf(orderTotal * 100) / 100;
        qDebug() << "Got Order Total as: " << orderTotal;
        //Start Transaction
        db.transaction();
        //check for all success before committing
        bool okCheck = true;
        //Save order and get ID
        QSqlQuery query(db);
        query.prepare("INSERT INTO `order` (order_date, takeaway, issued, user_id, total) "
                      "VALUES (:order_date, :takeaway, :issued, :user_id, :total)");
        query.bindValue(":order_date", myCurrentTime);
        query.bindValue(":takeaway", 1);
        query.bindValue(":issued", 1);
        query.bindValue(":user_id", 1);
        query.bindValue(":total", orderTotal);
        if(query.exec())
        {
            orderID = query.lastInsertId().toString().toInt();
            qDebug() << "Got Order ID as: " << orderID;
            //Loop through
            QVectorIterator<orderitem> w(order);
            while(w.hasNext())
            {
                orderitem n = w.next();
                int id = n.getID();
                int quantity = n.getQuantity();
                double eachat = n.getEachAt();
                int type = n.getType();
                //Check if it is a main product, Basic Toppings or Deluxe Toppings
                if(type == 1)
                {
                    //Main Product
                    query.prepare("INSERT INTO `order_products` (order_id, product_id, quantity, price) "
                                  "VALUES (:order_id, :product_id, :quantity, :price)");
                    query.bindValue(":order_id", orderID);
                    query.bindValue(":product_id", id);
                    query.bindValue(":quantity", quantity);
                    query.bindValue(":price", eachat);
                    if(!query.exec())
                    {
                        okCheck = false;
                        qDebug() << "Failed to save order item - product";
                    }
                }
                else if(type == 2)
                {
                    //Basic Toppings
                    query.prepare("INSERT INTO `order_basic_toppings` (order_id, basic_toppings_id, quantity, price) "
                                  "VALUES (:order_id, :basic_toppings_id, :quantity, :price)");
                    query.bindValue(":order_id", orderID);
                    query.bindValue(":basic_toppings_id", id);
                    query.bindValue(":quantity", quantity);
                    query.bindValue(":price", eachat);
                    if(!query.exec())
                    {
                        okCheck = false;
                        qDebug() << "Failed to save order item - basic toppings";
                    }
                }
                else if(type == 3)
                {
                    //Deluxe Toppings
                    query.prepare("INSERT INTO `order_deluxe_toppings` (order_id, deluxe_toppings_id, quantity, price) "
                                  "VALUES (:order_id, :deluxe_toppings_id, :quantity, :price)");
                    query.bindValue(":order_id", orderID);
                    query.bindValue(":deluxe_toppings_id", id);
                    query.bindValue(":quantity", quantity);
                    query.bindValue(":price", eachat);
                    if(!query.exec())
                    {
                        okCheck = false;
                        qDebug() << "Failed to save order item - deluxe toppings";
                    }
                }
            }
        }
        else
        {
            okCheck = false;
            qDebug() << "DB Error : " << db.lastError().text();
        }
        //End Transaction
        if(okCheck)
        {
            db.commit();
        }
        else
        {
            db.rollback();
        }
        //crear order display
        order.clear();
        ui->stackedWidget->setCurrentIndex(0);
        refreshOrderDisplay();
    }
    else
    {
        qDebug() << "Error: No Items to save in order";
    }
}

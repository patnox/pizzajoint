#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSqlDatabase>
#include <QSqlError>
#include <QMessageBox>
#include <QSqlQuery>
#include <QPushButton>
#include <QSignalMapper>
#include <QDebug>
#include <QStandardItemModel>
#include <QVector>
#include "orderitem.h"
#include <QVectorIterator>
#include <QDateTime>
#include <math.h>
#include "settings.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    bool connectToDB();
    bool connectedToDB;
    QSqlDatabase db;
    void refreshOrderDisplay();

private:
    Ui::MainWindow *ui;
    QSignalMapper productsMapper;
    QSignalMapper basicToppingsMapper;
    QSignalMapper deluxeToppingsMapper;
    QSignalMapper basicToppingsControlMapper;
    QSignalMapper deluxeToppingsControlMapper;
    double tax;
    void getTheTAX();
    void initProducts();
    QStandardItemModel *tableModel;
    QVector<orderitem> order;
    void clearLayout(QLayout* layout, bool deleteWidgets);
    settings *localsettings;

private slots:
    void productSelected(int id);
    void basicToppingsDisplaySelected(int id);
    void deluxeToppingsDisplaySelected(int id);
    void basicToppingsControlSelected(QString token);
    void deluxeToppingsControlSelected(QString token);
    void on_cmdAddProduct_clicked();
    void on_cmdExit_clicked();
    void on_cmdRemoveItem_clicked();
    void on_cmdPlus_clicked();
    void on_cmdMinus_clicked();
    void on_cmdNewOrder_clicked();
    void on_cmdBackToOrder_clicked();
    void on_cmdPostOrder_clicked();
};

#endif // MAINWINDOW_H

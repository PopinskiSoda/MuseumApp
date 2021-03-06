#ifndef HALL_H
#define HALL_H

#include <QObject>

class Hall : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString image READ image WRITE setImage)

public:
    Hall();

    QString name();
    QString image();

    void setName(QString name);
    void setImage(QString image);

private:
    QString m_name;
    QString m_image;
};

#endif // HALL_H

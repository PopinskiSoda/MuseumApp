#include "hall.h"

Hall::Hall()
{
//QObject* parent = 0
}

QString Hall::name()
{
    return this->m_name;
}

QString Hall::image()
{
    return this->m_image;
}

void Hall::setName(QString name)
{
    this->m_name = name;
}

void Hall::setImage(QString image)
{
    this->m_image = image;
}

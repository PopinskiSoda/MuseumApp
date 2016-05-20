#include "exhibit.h"


Exhibit::Exhibit()
{
//QObject* parent = 0
}

QString Exhibit::name()
{
    return this->m_name;
}

QString Exhibit::image()
{
    return this->m_image;
}

void Exhibit::setName(QString name)
{
    this->m_name = name;
}

void Exhibit::setImage(QString image)
{
    this->m_image = image;
}

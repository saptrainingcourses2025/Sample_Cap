using { cuid, Currency, managed, sap } from '@sap/cds/common';
namespace sap.capire.bookshop;

entity Books : managed {
    key ID: Integer;
    title: localized String;
    descr: localized String;
    author: Association to Authors;
    genre: Association to Genres;
    stock: Integer;
    price: Decimal;
    currency: Currency;
} 

entity Authors : managed {
    key ID: Integer;
    name: String @mandatory;
    dateOfBirth: Date;
    dateOfDeath: Date;
    placeOfBirth: String;
    placeOfDeath: String;
    books: Association to many Books on
                books.author = $self;
} 

entity Genres : cuid, sap.common.CodeList {
    parent: Association to Genres;
    children: Composition of many Genres on 
                children.parent = $self;
} 

type price: Decimal(9,2);
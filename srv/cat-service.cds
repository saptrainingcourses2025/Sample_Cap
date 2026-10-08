using { sap.capire.bookshop as my } from '../db/schema';

service CatalogService @(odata:'/brows') {
    
    @readonly entity ListOdBooks as projection on Books {
        *, currency.symbol as currency,
    } excluding { descr };
    
    @readonly entity Books as projection on my.Books {
        *,
        author.name as author,
        genre.name as genre,
    } excluding { createdBy, modifiedBy };

    @requires: 'authenticated-user'
    action submitOrder ( 
        book: Books:ID @mandatory, 
        quantity : Integer default 1 @assert.range : [1,_] );    
}

annotate CatalogService with @hcql @odata @rest;

annotate CatalogService with @mcp;

annotate CatalogService with @agent;
annotate CatalogService.submitOrder with @agent.hitl;




import cds from '@sap/cds'
import { SELECT } from '@sap/cds/lib/ql/cds-ql.js'

export class CatalogService extends cds.ApplicationService { init() {

  const { Books } = cds.entities('CatalogService')

  this.before (['CREATE', 'UPDATE'], Books, async (req) => {
    console.log('Before CREATE/UPDATE Books', req.data)
  })

  this.after ('READ', Books, async (books, req) => {
    books.forEach(book => {
      if (book.stock > 111) {
        book.title += `-- 11% discount!`
      }
    })
  });

  this.on ('submitOrder', async req => {
    let { book:id, quantity } = req.data
    let affected = await UPDATE (Books,id)
                      .with `stock = stock - ${quantity}`
                      .where `stock >= ${quantity}`
    if (affected) return
    
    let exists = await SELECT.one`stock`.from(Books,id)
    if (!exists) req.error (404, `Book  #${id} doesn't exist`)
    else req.error (409,`${quantity} exceeds stock for book #${id}`,{ id, quantity, ...exists})
  });


  return super.init()
}}

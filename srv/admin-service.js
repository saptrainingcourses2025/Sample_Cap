import cds from '@sap/cds'
import { SELECT } from '@sap/cds/lib/ql/cds-ql.js'

export class AdminService extends cds.ApplicationService { init() {

  const { Authors, Books, Genres } = cds.entities('AdminService')

  this.before (['NEW', 'CREATE'], ['Books','Authors'], async (req) => {
    if (req.data.ID) return
    let {id} = await SELECT.one `max(ID) as id`.from(req.target)
    req.data.ID = id + 4
  })

  return super.init()
}}

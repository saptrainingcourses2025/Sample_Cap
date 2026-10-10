import cds from '@sap/cds'

export class ProcessorService extends cds.ApplicationService {
  async init() {
    const { Incidents, Customers } = this.entities

    // Prevent updating closed incidents
    this.before('UPDATE', Incidents, async (req) => {
      const closed = await SELECT.one
        .from(req.subject)
        .where({ status_code: 'C' })

      if (closed) {
        req.reject(400, "Can't modify a closed incident!")
      }
    })

    // Set urgency to High for urgent customers
    this.before('CREATE', Incidents, (req) => {
      const urgent = req.data.title?.match(/urgent/i)

      if (urgent) {
        req.data.urgency_code = 'H'
      }
    })

    return super.init()
  }
}

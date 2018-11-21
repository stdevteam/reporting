class HomeController < ApplicationController

  def report
    @report = []
    Location.all.includes(slots: [:purchase, appointment: [:client], slot_variations: [:variation]]).each do |loc|
      temp = Hash.new{0}
      temp['location_id'] = loc.id
      temp['location_full_address'] = "#{loc.country} #{loc.city} #{loc.zip_code} #{loc.street_address}"
      temp['clients'] = Hash.new()
      loc.slots.where('begin_at > ?',  2.weeks.ago).each do |slot|
        temp['clients'][slot.appointment.client.id] ||= {}
        temp['clients'][slot.appointment.client.id]['slot_variations'] ||= []
        temp['clients'][slot.appointment.client.id]['client'] = slot.appointment.client
        temp['clients'][slot.appointment.client.id]['slot_variations'] += slot.slot_variations.map{|e| e.variation.name}
        if slot.purchase.referrer.nil?
          temp['bookings_without_referrer'] += 1
        else
          temp['bookings_with_referrer'] += 1
        end
        if slot.appointment.status == 'canceled'
          temp['canceled_bookings_no'] += 1
          temp['price_for_canceled'] += slot.purchase.purchased_at_price
        else
          temp['active_bookings_no'] += 1
          temp['price_for_active'] += slot.purchase.purchased_at_price
        end
      end
      @report << temp
    end
    send_data self.to_csv, filename: "report-#{Date.today}.csv"
  end

  def to_csv
    attributes = %w{location_id location_full_address bookings_with_referrer bookings_without_referrer active_bookings_no canceled_bookings_no price_for_canceled price_for_active client_id client_full_name client_phone client_email variation_names}

    CSV.generate(headers: true) do |csv|
      csv << attributes
      @report.each do |one|
        csv << [
          one['location_id'],
          one['location_full_address'],
          one['bookings_with_referrer'],
          one['bookings_without_referrer'],
          one['active_bookings_no'],
          one['canceled_bookings_no'],
          one['price_for_canceled'],
          one['price_for_active']
        ]
        one['clients'].each do |k, c|
          client = c['client']
          csv << [
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            client['id']  ,
            client['first_name'] + ' ' + client['last_name'],
            client['phone'],
            client['email'],
            c['slot_variations'].join{'|'},
          ]
        end
      end
    end
  end
end

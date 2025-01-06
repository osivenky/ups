require 'httparty'

class UPSService
  BASE_URL = "https://onlinetools.ups.com"
  API_VERSION = "/rest"

  def initialize(access_token)
    @access_token = access_token
    @headers = {
      "Authorization" => "Bearer #{@access_token}",
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
  end

  # Fetch Shipping Rates
  def fetch_shipping_rates(origin, destination, package_details)
    url = "#{BASE_URL}#{API_VERSION}/rate"
    body = {
      RateRequest: {
        Shipment: {
          Shipper: { Address: origin },
          ShipTo: { Address: destination },
          Package: package_details
        }
      }
    }

    response = HTTParty.post(url, headers: @headers, body: body.to_json)
    handle_response(response)
  end

  # Create a Shipping Label
  def create_shipping_label(shipper, recipient, package_details, service_code)
    url = "#{BASE_URL}#{API_VERSION}/ship"
    body = {
      ShipmentRequest: {
        Shipment: {
          Shipper: { Address: shipper },
          ShipTo: { Address: recipient },
          Package: package_details,
          Service: { Code: service_code }
        }
      }
    }

    response = HTTParty.post(url, headers: @headers, body: body.to_json)
    handle_response(response)
  end

  # Track a Shipment
  def track_shipment(tracking_number)
    url = "#{BASE_URL}#{API_VERSION}/track"
    body = {
      TrackingRequest: {
        InquiryNumber: tracking_number
      }
    }

    response = HTTParty.post(url, headers: @headers, body: body.to_json)
    handle_response(response)
  end

  private

  # Handle and log UPS API responses
  def handle_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      Rails.logger.error "UPS API Error: #{response.body}"
      { error: response.body }
    end
  end
end

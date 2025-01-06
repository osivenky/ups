class Api::V1::UpsController < Api::V1::BaseController
  def rates
    ups_service = UPSService.new(current_user.ups_access_token)

    origin = {
      AddressLine: ["123 Main St"],
      City: "New York",
      StateProvinceCode: "NY",
      CountryCode: "US",
      PostalCode: "10001"
    }

    destination = {
      AddressLine: ["456 Elm St"],
      City: "San Francisco",
      StateProvinceCode: "CA",
      CountryCode: "US",
      PostalCode: "94105"
    }

    package_details = [
      {
        Dimensions: { Length: "10", Width: "5", Height: "5", UnitOfMeasurement: { Code: "IN" } },
        Weight: { UnitOfMeasurement: { Code: "LBS" }, Weight: "2" }
      }
    ]

    response = ups_service.fetch_shipping_rates(origin, destination, package_details)
    render json: response
  end

  def create_label
    ups_service = UPSService.new(current_user.ups_access_token)

    shipper = {
      AddressLine: ["123 Main St"],
      City: "New York",
      StateProvinceCode: "NY",
      CountryCode: "US",
      PostalCode: "10001"
    }

    recipient = {
      AddressLine: ["456 Elm St"],
      City: "San Francisco",
      StateProvinceCode: "CA",
      CountryCode: "US",
      PostalCode: "94105"
    }

    package_details = [
      {
        Dimensions: { Length: "10", Width: "5", Height: "5", UnitOfMeasurement: { Code: "IN" } },
        Weight: { UnitOfMeasurement: { Code: "LBS" }, Weight: "2" }
      }
    ]

    service_code = "03" # Example: UPS Ground

    response = ups_service.create_shipping_label(shipper, recipient, package_details, service_code)
    render json: response
  end

  def track
    ups_service = UPSService.new(current_user.ups_access_token)
    tracking_number = params[:tracking_number]
    response = ups_service.track_shipment(tracking_number)
    render json: response
  end
end

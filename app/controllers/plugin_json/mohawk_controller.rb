module PluginJson
  class MohawkController < MiqPluginExample::ApiController
    def index
      emss = ManageIQ::Providers::Metric::Mohawk.includes(:endpoints).all

      out = emss.map do |ems|
        {
          :ems => ems,
          :endpoints => ems.endpoints
        }
      end
      render :json => out
    end

    def show
      id = params[:id]
      ems = ManageIQ::Providers::Metric::Mohawk.includes(:endpoints).find(id)

      render :json => {
        :ems => ems,
        :endpoints => ems.endpoints
      }
    rescue Exception => e
      render :json => {:error => e.message}
    end

    def create
      data_ems = params[:mohawk][:ems].permit(:name)
      data_endpoint = params[:mohawk][:endpoints][0].permit(:hostname, :port, :role)

      endpoint = Endpoint.new(data_endpoint)
      ems = ManageIQ::Providers::Metric::Mohawk.new(data_ems)
      ems.endpoints = [endpoint]
      ems.save

      render :json => {
        :ems => ems,
        :endpoints => ems.endpoints
      }
    rescue Exception => e
      render :json => {:error => e.message}
    end

    def update
      id = params[:id]
      data_ems = params[:mohawk][:ems].permit(:name)
      data_endpoint = params[:mohawk][:endpoints][0].permit(:hostname, :port, :role)

      ems = ManageIQ::Providers::Metric::Mohawk.find(id)
      ems.hostname = data_endpoint[:hostname] if data_endpoint[:hostname]
      ems.port = data_endpoint[:port] if data_endpoint[:port]
      ems.name = data_ems[:name] if data_ems[:name]
      ems.save

      render :json => {
        :ems => ems,
        :endpoints => ems.endpoints
      }
    rescue Exception => e
      render :json => {:error => e.message}
    end

    def destroy
      id = params[:id]

      ems = ManageIQ::Providers::Metric::Mohawk.find(id)
      ems.delete

      render :json => {
        :ems => ems,
        :endpoints => ems.endpoints
      }
    rescue Exception => e
      render :json => {:error => e.message}
    end
  end
end
